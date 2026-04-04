import { Test, TestingModule } from '@nestjs/testing';
import { ForbiddenException, NotFoundException, BadRequestException } from '@nestjs/common';
import { getRepositoryToken } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { UsersService } from './users.service';
import { User } from './entities/user.entity';
import { UserMatch } from './entities/user-match.entity';
import { UserPodium } from './entities/user-podium.entity';
import { Match } from '../matches/entities/match.entity';
import { EventsGateway } from '../events/events.gateway';

describe('UsersService', () => {
  let service: UsersService;
  let userRepo: any;
  let userMatchRepo: any;
  let userPodiumRepo: any;
  let matchRepo: any;

  beforeEach(async () => {
    userRepo = {
      findOne: jest.fn(),
      find: jest.fn(),
      save: jest.fn(),
      create: jest.fn((data) => data),
    };
    userMatchRepo = {
      findOne: jest.fn(),
      find: jest.fn(),
      save: jest.fn(),
      create: jest.fn((data) => data),
    };
    userPodiumRepo = {
      findOne: jest.fn(),
      save: jest.fn(),
      create: jest.fn((data) => data),
    };
    matchRepo = {
      findOne: jest.fn(),
      find: jest.fn(),
    };

    const mockQueryRunner = {
      connect: jest.fn(),
      startTransaction: jest.fn(),
      commitTransaction: jest.fn(),
      rollbackTransaction: jest.fn(),
      release: jest.fn(),
      manager: { save: jest.fn((entity) => entity) },
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UsersService,
        { provide: getRepositoryToken(User), useValue: userRepo },
        { provide: getRepositoryToken(UserMatch), useValue: userMatchRepo },
        { provide: getRepositoryToken(UserPodium), useValue: userPodiumRepo },
        { provide: getRepositoryToken(Match), useValue: matchRepo },
        { provide: DataSource, useValue: { createQueryRunner: () => mockQueryRunner } },
        { provide: EventsGateway, useValue: { emitPredictionSaved: jest.fn(), emitForceLogout: jest.fn(), emitProfileUpdated: jest.fn() } },
      ],
    }).compile();

    service = module.get<UsersService>(UsersService);
  });

  describe('getRanking', () => {
    it('should return users sorted by total_score descending', async () => {
      userRepo.find.mockResolvedValue([
        { id: '1', nickname: 'alice', score: 10, podium_score: 5, profile_image: null },
        { id: '2', nickname: 'bob', score: 20, podium_score: 0, profile_image: null },
        { id: '3', nickname: 'carol', score: 15, podium_score: 30, profile_image: null },
      ]);

      const ranking = await service.getRanking();
      expect(ranking[0].nickname).toBe('carol');  // 45
      expect(ranking[1].nickname).toBe('bob');     // 20
      expect(ranking[2].nickname).toBe('alice');   // 15
      expect(ranking[0].total_score).toBe(45);
    });
  });

  describe('updatePrediction', () => {
    it('should throw ForbiddenException when userId != requestUserId', async () => {
      await expect(service.updatePrediction('user-1', 'match-1', 'user-2', { local_score: 1, visitor_score: 0 }))
        .rejects.toThrow(ForbiddenException);
    });

    it('should throw NotFoundException for non-existent match', async () => {
      matchRepo.findOne.mockResolvedValue(null);
      await expect(service.updatePrediction('user-1', 'match-1', 'user-1', { local_score: 1, visitor_score: 0 }))
        .rejects.toThrow(NotFoundException);
    });

    it('should throw BadRequestException for past match', async () => {
      matchRepo.findOne.mockResolvedValue({ id: 'match-1', match_date: new Date(Date.now() - 60000) });
      await expect(service.updatePrediction('user-1', 'match-1', 'user-1', { local_score: 1, visitor_score: 0 }))
        .rejects.toThrow(BadRequestException);
    });

    it('should save prediction for future match', async () => {
      matchRepo.findOne.mockResolvedValue({ id: 'match-1', match_date: new Date(Date.now() + 3600000) });
      userMatchRepo.findOne.mockResolvedValue({ user_id: 'user-1', match_id: 'match-1', local_score: null, visitor_score: null });
      userMatchRepo.save.mockImplementation((p) => Promise.resolve(p));

      const result = await service.updatePrediction('user-1', 'match-1', 'user-1', { local_score: 2, visitor_score: 1 });
      expect(result.local_score).toBe(2);
      expect(result.visitor_score).toBe(1);
    });
  });

  describe('updateUser', () => {
    it('should throw ForbiddenException when userId != requestUserId', async () => {
      await expect(service.updateUser('user-1', 'user-2', { password: 'newpass123' }))
        .rejects.toThrow(ForbiddenException);
    });

    it('should throw NotFoundException for non-existent user', async () => {
      userRepo.findOne.mockResolvedValue(null);
      await expect(service.updateUser('user-1', 'user-1', { password: 'newpass123' }))
        .rejects.toThrow(NotFoundException);
    });

    it('should update password and clear temp flag', async () => {
      const user = { id: 'user-1', password: 'old', is_temp_password: true, temp_password_expires: new Date() };
      userRepo.findOne.mockResolvedValue(user);
      userRepo.save.mockImplementation((u) => Promise.resolve(u));

      await service.updateUser('user-1', 'user-1', { password: 'newpass123' });
      expect(user.is_temp_password).toBe(false);
      expect(user.temp_password_expires).toBeNull();
    });

    it('should update podium selections', async () => {
      const user = { id: 'user-1', password: 'hash' };
      userRepo.findOne.mockResolvedValue(user);
      const podium = { user_id: 'user-1', champion_team_id: null, runner_up_team_id: null, third_place_team_id: null };
      userPodiumRepo.findOne.mockResolvedValue(podium);
      userPodiumRepo.save.mockImplementation((p) => Promise.resolve(p));

      await service.updateUser('user-1', 'user-1', {
        champion_team_id: 'ARG',
        runner_up_team_id: 'BRA',
        third_place_team_id: 'FRA',
      });
      expect(podium.champion_team_id).toBe('ARG');
      expect(podium.runner_up_team_id).toBe('BRA');
      expect(podium.third_place_team_id).toBe('FRA');
    });
  });
});
