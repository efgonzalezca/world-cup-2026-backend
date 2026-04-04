import { Injectable, NotFoundException, BadRequestException, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, DataSource } from 'typeorm';
import { Match } from './entities/match.entity';
import { UserMatch } from '../users/entities/user-match.entity';
import { User } from '../users/entities/user.entity';
import { UpdateResultDto } from './dto/update-result.dto';
import { EventsGateway } from '../events/events.gateway';
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
  ) {}

  async findAll(phase?: string) {
    const where: any = {};
    if (phase) where.phase = phase;

    return this.matchRepository.find({
      where,
      relations: ['local_team', 'visiting_team', 'group'],
      order: { match_date: 'ASC' },
    });
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
        await queryRunner.manager.save(prediction);

        await queryRunner.manager
          .createQueryBuilder()
          .update(User)
          .set({ score: () => `score + ${points.total}` })
          .where('id = :id', { id: prediction.user_id })
          .execute();
      }

      await queryRunner.commitTransaction();

      this.logger.log(`Match ${matchId} result registered: ${dto.local_result}-${dto.visiting_result}`);

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
