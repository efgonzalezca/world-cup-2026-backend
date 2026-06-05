import { Injectable, NotFoundException, BadRequestException, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { InjectQueue } from '@nestjs/bullmq';
import { Queue } from 'bullmq';
import { Match } from './entities/match.entity';
import { Team } from '../teams/entities/team.entity';
import { EventsGateway } from '../events/events.gateway';
import { CacheService } from '../common/cache/cache.service';
import { UpdateResultDto } from './dto/update-result.dto';
import { AssignTeamsDto } from './dto/assign-teams.dto';
import { SCORE_CALCULATION_QUEUE } from './jobs/score-calculation.constants';
import { ScoreCalculationJobData } from './jobs/score-calculation.job';

@Injectable()
export class MatchesService {
  private readonly logger = new Logger(MatchesService.name);

  constructor(
    @InjectRepository(Match)
    private readonly matchRepository: Repository<Match>,
    @InjectRepository(Team)
    private readonly teamRepository: Repository<Team>,
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

  async assignTeams(matchId: string, dto: AssignTeamsDto) {
    const match = await this.matchRepository.findOne({ where: { id: matchId } });
    if (!match) throw new NotFoundException('Partido no encontrado');

    if (match.phase === 'group') {
      throw new BadRequestException('Solo se pueden asignar equipos en fases eliminatorias');
    }
    if (match.has_played) {
      throw new BadRequestException('No se pueden modificar equipos de un partido ya jugado');
    }
    if (new Date() >= new Date(match.match_date)) {
      throw new BadRequestException('No se pueden modificar equipos despues de la fecha del partido');
    }

    const hasLocal = Object.prototype.hasOwnProperty.call(dto, 'local_team_id');
    const hasVisiting = Object.prototype.hasOwnProperty.call(dto, 'visiting_team_id');
    if (!hasLocal && !hasVisiting) {
      throw new BadRequestException('Debe indicar al menos un equipo (local o visitante)');
    }

    const nextLocal = hasLocal ? dto.local_team_id ?? null : match.local_team_id;
    const nextVisiting = hasVisiting ? dto.visiting_team_id ?? null : match.visiting_team_id;

    if (nextLocal && nextVisiting && nextLocal === nextVisiting) {
      throw new BadRequestException('Los equipos local y visitante no pueden ser el mismo');
    }

    const idsToCheck = [
      ...(hasLocal && nextLocal ? [nextLocal] : []),
      ...(hasVisiting && nextVisiting ? [nextVisiting] : []),
    ];
    for (const teamId of idsToCheck) {
      const exists = await this.teamRepository.findOne({ where: { id: teamId } });
      if (!exists) throw new BadRequestException(`El equipo "${teamId}" no existe`);
    }

    if (hasLocal) match.local_team_id = nextLocal;
    if (hasVisiting) match.visiting_team_id = nextVisiting;
    await this.matchRepository.save(match);

    this.logger.log(`Match ${matchId} teams assigned: local=${match.local_team_id} visiting=${match.visiting_team_id}`);

    await this.cacheService.delByPrefix('matches:');
    this.eventsGateway.emitMatchTeamsUpdated(matchId);

    return this.matchRepository.findOne({
      where: { id: matchId },
      relations: ['local_team', 'visiting_team', 'group'],
    });
  }
}
