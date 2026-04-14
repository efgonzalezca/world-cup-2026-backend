import { Processor, WorkerHost, OnWorkerEvent } from '@nestjs/bullmq';
import { Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, DataSource } from 'typeorm';
import { Job } from 'bullmq';
import { UserMatch } from '../../users/entities/user-match.entity';
import { EventsGateway } from '../../events/events.gateway';
import { CacheService } from '../../common/cache/cache.service';
import { calculatePoints } from '../scoring';
import { SCORE_CALCULATION_QUEUE } from './score-calculation.constants';
import { ScoreCalculationJobData } from './score-calculation.job';

@Processor(SCORE_CALCULATION_QUEUE)
export class ScoreCalculationProcessor extends WorkerHost {
  private readonly logger = new Logger(ScoreCalculationProcessor.name);

  constructor(
    @InjectRepository(UserMatch)
    private readonly userMatchRepository: Repository<UserMatch>,
    private readonly dataSource: DataSource,
    private readonly eventsGateway: EventsGateway,
    private readonly cacheService: CacheService,
  ) {
    super();
  }

  async process(job: Job<ScoreCalculationJobData>): Promise<void> {
    const { matchId, localResult, visitingResult } = job.data;
    this.logger.log(`Processing score calculation for match ${matchId}`);

    const predictions = await this.userMatchRepository.find({
      where: { match_id: matchId },
    });

    const scoreUpdates: { userId: string; points: number }[] = [];

    for (const prediction of predictions) {
      const points = calculatePoints(
        prediction.local_score,
        prediction.visitor_score,
        localResult,
        visitingResult,
      );

      prediction.points = points.total;
      prediction.discriminated_points = {
        resultPoints: points.resultPoints,
        localScorePoints: points.localScorePoints,
        visitorScorePoints: points.visitorScorePoints,
        exactScoreBonus: points.exactScoreBonus,
        drawBonus: points.drawBonus,
      };

      if (points.total > 0) {
        scoreUpdates.push({ userId: prediction.user_id, points: points.total });
      }
    }

    const queryRunner = this.dataSource.createQueryRunner();
    await queryRunner.connect();
    await queryRunner.startTransaction();

    try {
      if (predictions.length > 0) {
        const predValues: unknown[] = [];
        const predPlaceholders: string[] = [];
        predictions.forEach((p, i) => {
          const offset = i * 3;
          predPlaceholders.push(`($${offset + 1}::uuid, $${offset + 2}::int, $${offset + 3}::jsonb)`);
          predValues.push(p.id, p.points, JSON.stringify(p.discriminated_points));
        });

        await queryRunner.query(
          `UPDATE user_matches um SET
            points = v.points,
            discriminated_points = v.disc
          FROM (VALUES ${predPlaceholders.join(', ')}) AS v(id, points, disc)
          WHERE um.id = v.id`,
          predValues,
        );
      }

      if (scoreUpdates.length > 0) {
        const scoreValues: unknown[] = [];
        const scorePlaceholders: string[] = [];
        scoreUpdates.forEach((s, i) => {
          const offset = i * 2;
          scorePlaceholders.push(`($${offset + 1}::uuid, $${offset + 2}::int)`);
          scoreValues.push(s.userId, s.points);
        });

        await queryRunner.query(
          `UPDATE users u SET score = u.score + v.points
          FROM (VALUES ${scorePlaceholders.join(', ')}) AS v(id, points)
          WHERE u.id = v.id`,
          scoreValues,
        );
      }

      await queryRunner.commitTransaction();
    } catch (error) {
      await queryRunner.rollbackTransaction();
      throw error;
    } finally {
      await queryRunner.release();
    }

    await this.cacheService.delByPrefix('ranking:');
    await this.cacheService.delByPrefix('matches:');
    await this.cacheService.delByPrefix('matchPredictions:');

    this.eventsGateway.emitScoreUpdated(matchId);
    this.eventsGateway.emitRankingUpdated();

    this.logger.log(`Score calculation completed for match ${matchId}: ${predictions.length} predictions processed`);
  }

  @OnWorkerEvent('failed')
  onFailed(job: Job<ScoreCalculationJobData>, error: Error) {
    this.logger.error(`Score calculation failed for match ${job.data.matchId}: ${error.message}`, error.stack);
  }
}
