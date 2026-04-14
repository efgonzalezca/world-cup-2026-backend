import { Injectable, NotFoundException, BadRequestException, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, DataSource } from 'typeorm';
import { Match } from './entities/match.entity';
import { UserMatch } from '../users/entities/user-match.entity';
import { User } from '../users/entities/user.entity';
import { UpdateResultDto } from './dto/update-result.dto';
import { EventsGateway } from '../events/events.gateway';
import { CacheService } from '../common/cache/cache.service';
import { calculatePoints } from './scoring';

@Injectable()
export class MatchesService {
  private readonly logger = new Logger(MatchesService.name);

  constructor(
    @InjectRepository(Match)
    private readonly matchRepository: Repository<Match>,
    @InjectRepository(UserMatch)
    private readonly userMatchRepository: Repository<UserMatch>,
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    private readonly dataSource: DataSource,
    private readonly eventsGateway: EventsGateway,
    private readonly cacheService: CacheService,
  ) {}

  async findAll(phase?: string) {
    const cacheKey = `matches:${phase || 'all'}`;
    const cached = this.cacheService.get(cacheKey);
    if (cached) return cached;

    const where: any = {};
    if (phase) where.phase = phase;

    const data = await this.matchRepository.find({
      where,
      relations: ['local_team', 'visiting_team', 'group'],
      order: { match_date: 'ASC' },
    });

    this.cacheService.set(cacheKey, data, 300_000);
    return data;
  }

  async updateResult(matchId: string, dto: UpdateResultDto) {
    const match = await this.matchRepository.findOne({ where: { id: matchId } });
    if (!match) throw new NotFoundException('Partido no encontrado');
    if (match.has_played) throw new BadRequestException('El resultado de este partido ya fue registrado');

    const queryRunner = this.dataSource.createQueryRunner();
    await queryRunner.connect();
    await queryRunner.startTransaction();

    try {
      match.local_result = dto.local_result;
      match.visiting_result = dto.visiting_result;
      match.has_played = true;
      await queryRunner.manager.save(match);

      const predictions = await this.userMatchRepository.find({
        where: { match_id: matchId },
      });

      const scoreUpdates: { userId: string; points: number }[] = [];

      for (const prediction of predictions) {
        const points = calculatePoints(
          prediction.local_score,
          prediction.visitor_score,
          dto.local_result,
          dto.visiting_result,
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

      this.logger.log(`Match ${matchId} result registered: ${dto.local_result}-${dto.visiting_result}`);

      this.cacheService.delByPrefix('ranking:');
      this.cacheService.delByPrefix('matches:');
      this.cacheService.delByPrefix('matchPredictions:');

      this.eventsGateway.emitMatchResult(matchId, dto.local_result, dto.visiting_result);
      this.eventsGateway.emitScoreUpdated(matchId);
      this.eventsGateway.emitRankingUpdated();

      return match;
    } catch (error) {
      await queryRunner.rollbackTransaction();
      throw error;
    } finally {
      await queryRunner.release();
    }
  }
}
