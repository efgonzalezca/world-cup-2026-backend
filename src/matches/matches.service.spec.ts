import { Test, TestingModule } from '@nestjs/testing';
import { NotFoundException, BadRequestException } from '@nestjs/common';
import { getRepositoryToken } from '@nestjs/typeorm';
import { getQueueToken } from '@nestjs/bullmq';
import { MatchesService } from './matches.service';
import { Match } from './entities/match.entity';
import { Team } from '../teams/entities/team.entity';
import { EventsGateway } from '../events/events.gateway';
import { CacheService } from '../common/cache/cache.service';
import { SCORE_CALCULATION_QUEUE } from './jobs/score-calculation.constants';

describe('MatchesService', () => {
  let service: MatchesService;
  let matchRepo: any;
  let teamRepo: any;
  let cacheService: any;
  let eventsGateway: any;

  const FUTURE = new Date(Date.now() + 3600_000);
  const PAST = new Date(Date.now() - 3600_000);

  const knockoutMatch = (overrides: Partial<Match> = {}): any => ({
    id: 'match-1',
    phase: 'quarter',
    match_date: FUTURE,
    local_team_id: null,
    visiting_team_id: null,
    has_played: false,
    ...overrides,
  });

  beforeEach(async () => {
    matchRepo = {
      findOne: jest.fn(),
      find: jest.fn(),
      save: jest.fn((m) => Promise.resolve(m)),
    };
    teamRepo = {
      findOne: jest.fn(),
    };
    cacheService = {
      get: jest.fn().mockResolvedValue(null),
      set: jest.fn().mockResolvedValue(undefined),
      del: jest.fn().mockResolvedValue(undefined),
      delByPrefix: jest.fn().mockResolvedValue(undefined),
    };
    eventsGateway = {
      emitMatchResult: jest.fn(),
      emitMatchTeamsUpdated: jest.fn(),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        MatchesService,
        { provide: getRepositoryToken(Match), useValue: matchRepo },
        { provide: getRepositoryToken(Team), useValue: teamRepo },
        { provide: getQueueToken(SCORE_CALCULATION_QUEUE), useValue: { add: jest.fn() } },
        { provide: EventsGateway, useValue: eventsGateway },
        { provide: CacheService, useValue: cacheService },
      ],
    }).compile();

    service = module.get<MatchesService>(MatchesService);
  });

  describe('assignTeams', () => {
    it('rechaza si el partido no existe', async () => {
      matchRepo.findOne.mockResolvedValue(null);
      await expect(service.assignTeams('x', { local_team_id: 'BRA' })).rejects.toThrow(NotFoundException);
    });

    it('rechaza si la fase es group', async () => {
      matchRepo.findOne.mockResolvedValue(knockoutMatch({ phase: 'group' }));
      await expect(service.assignTeams('match-1', { local_team_id: 'BRA' })).rejects.toThrow(BadRequestException);
    });

    it('rechaza si has_played es true', async () => {
      matchRepo.findOne.mockResolvedValue(knockoutMatch({ has_played: true }));
      await expect(service.assignTeams('match-1', { local_team_id: 'BRA' })).rejects.toThrow(BadRequestException);
    });

    it('rechaza si la fecha del partido ya paso', async () => {
      matchRepo.findOne.mockResolvedValue(knockoutMatch({ match_date: PAST }));
      await expect(service.assignTeams('match-1', { local_team_id: 'BRA' })).rejects.toThrow(BadRequestException);
    });

    it('rechaza si el body llega vacio', async () => {
      matchRepo.findOne.mockResolvedValue(knockoutMatch());
      await expect(service.assignTeams('match-1', {})).rejects.toThrow(BadRequestException);
    });

    it('rechaza si los dos equipos quedarian iguales', async () => {
      matchRepo.findOne.mockResolvedValue(knockoutMatch({ visiting_team_id: 'BRA' }));
      teamRepo.findOne.mockResolvedValue({ id: 'BRA' });
      await expect(service.assignTeams('match-1', { local_team_id: 'BRA' })).rejects.toThrow(BadRequestException);
    });

    it('rechaza si el id de un equipo no existe', async () => {
      matchRepo.findOne.mockResolvedValue(knockoutMatch());
      teamRepo.findOne.mockResolvedValue(null);
      await expect(service.assignTeams('match-1', { local_team_id: 'ZZZ' })).rejects.toThrow(BadRequestException);
    });

    it('aplica patch parcial solo de local_team_id', async () => {
      const match = knockoutMatch({ visiting_team_id: 'ARG' });
      matchRepo.findOne.mockResolvedValueOnce(match);
      teamRepo.findOne.mockResolvedValue({ id: 'BRA' });
      matchRepo.findOne.mockResolvedValueOnce({ ...match, local_team_id: 'BRA' });

      await service.assignTeams('match-1', { local_team_id: 'BRA' });

      expect(matchRepo.save).toHaveBeenCalledWith(expect.objectContaining({ local_team_id: 'BRA', visiting_team_id: 'ARG' }));
    });

    it('aplica patch parcial solo de visiting_team_id', async () => {
      const match = knockoutMatch({ local_team_id: 'ARG' });
      matchRepo.findOne.mockResolvedValueOnce(match);
      teamRepo.findOne.mockResolvedValue({ id: 'BRA' });
      matchRepo.findOne.mockResolvedValueOnce({ ...match, visiting_team_id: 'BRA' });

      await service.assignTeams('match-1', { visiting_team_id: 'BRA' });

      expect(matchRepo.save).toHaveBeenCalledWith(expect.objectContaining({ local_team_id: 'ARG', visiting_team_id: 'BRA' }));
    });

    it('aplica patch de ambos equipos', async () => {
      const match = knockoutMatch();
      matchRepo.findOne.mockResolvedValueOnce(match);
      teamRepo.findOne.mockResolvedValue({ id: 'any' });
      matchRepo.findOne.mockResolvedValueOnce({ ...match, local_team_id: 'BRA', visiting_team_id: 'ARG' });

      await service.assignTeams('match-1', { local_team_id: 'BRA', visiting_team_id: 'ARG' });

      expect(matchRepo.save).toHaveBeenCalledWith(expect.objectContaining({ local_team_id: 'BRA', visiting_team_id: 'ARG' }));
    });

    it('permite desasignar un slot con null explicito', async () => {
      const match = knockoutMatch({ local_team_id: 'BRA', visiting_team_id: 'ARG' });
      matchRepo.findOne.mockResolvedValueOnce(match);
      matchRepo.findOne.mockResolvedValueOnce({ ...match, local_team_id: null });

      await service.assignTeams('match-1', { local_team_id: null });

      expect(matchRepo.save).toHaveBeenCalledWith(expect.objectContaining({ local_team_id: null }));
      expect(teamRepo.findOne).not.toHaveBeenCalled();
    });

    it('invalida cache matches:', async () => {
      const match = knockoutMatch();
      matchRepo.findOne.mockResolvedValue(match);
      teamRepo.findOne.mockResolvedValue({ id: 'BRA' });

      await service.assignTeams('match-1', { local_team_id: 'BRA' });

      expect(cacheService.delByPrefix).toHaveBeenCalledWith('matches:');
    });

    it('emite match.teams.updated', async () => {
      const match = knockoutMatch();
      matchRepo.findOne.mockResolvedValue(match);
      teamRepo.findOne.mockResolvedValue({ id: 'BRA' });

      await service.assignTeams('match-1', { local_team_id: 'BRA' });

      expect(eventsGateway.emitMatchTeamsUpdated).toHaveBeenCalledWith('match-1');
    });
  });
});