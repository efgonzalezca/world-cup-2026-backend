import { Injectable, NotFoundException, BadRequestException, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { InjectQueue } from '@nestjs/bullmq';
import { Queue } from 'bullmq';
import { Match } from './entities/match.entity';
import { EventsGateway } from '../events/events.gateway';
import { CacheService } from '../common/cache/cache.service';
import { UpdateResultDto } from './dto/update-result.dto';
import { SCORE_CALCULATION_QUEUE } from './jobs/score-calculation.constants';
import { ScoreCalculationJobData } from './jobs/score-calculation.job';

@Injectable()
export class MatchesService {
  private readonly logger = new Logger(MatchesService.name);

  constructor(
    @InjectRepository(Match)
    private readonly matchRepository: Repository<Match>,
    @InjectQueue(SCORE_CALCULATION_QUEUE)
    private readonly scoreQueue: Queue<ScoreCalculationJobData>,
    private readonly eventsGateway: EventsGateway,
    private readonly cacheService: CacheService,
  ) {}

  async findAll(phase?: string) {
    const cacheKey = `matches:${phase || 'all'}`;
    const cached = await this.cacheService.get(cacheKey);
    if (cached) return cached;

    const where: any = {};
    if (phase) where.phase = phase;

    const data = await this.matchRepository.find({
      where,
      relations: ['local_team', 'visiting_team', 'group'],
      order: { match_date: 'ASC' },
    });

    await this.cacheService.set(cacheKey, data, 300_000);
    return data;
  }

  async updateResult(matchId: string, dto: UpdateResultDto) {
    const match = await this.matchRepository.findOne({ where: { id: matchId } });
    if (!match) throw new NotFoundException('Partido no encontrado');
    if (match.has_played) throw new BadRequestException('El resultado de este partido ya fue registrado');

    match.local_result = dto.local_result;
    match.visiting_result = dto.visiting_result;
    match.has_played = true;
    await this.matchRepository.save(match);

    this.logger.log(`Match ${matchId} result registered: ${dto.local_result}-${dto.visiting_result}`);

    this.eventsGateway.emitMatchResult(matchId, dto.local_result, dto.visiting_result);

    await this.scoreQueue.add('calculate', {
      matchId,
      localResult: dto.local_result,
      visitingResult: dto.visiting_result,
    });

    this.logger.log(`Score calculation job enqueued for match ${matchId}`);

    return match;
  }
}
