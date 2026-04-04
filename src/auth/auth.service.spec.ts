import { Test, TestingModule } from '@nestjs/testing';
import { UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { getRepositoryToken } from '@nestjs/typeorm';
import * as bcrypt from 'bcrypt';
import { AuthService } from './auth.service';
import { User } from '../users/entities/user.entity';

describe('AuthService', () => {
  let service: AuthService;
  let userRepo: any;
  let jwtService: any;

  const mockUser: Partial<User> = {
    id: 'user-1',
    email: 'test@test.com',
    nickname: 'testuser',
    password: '',
    role: 'user',
    is_active: true,
    is_temp_password: false,
    temp_password_expires: null,
    predictions: [],
    podium: undefined as any,
  };

  beforeEach(async () => {
    mockUser.password = await bcrypt.hash('password123', 10);

    userRepo = { findOne: jest.fn() };
    jwtService = { sign: jest.fn().mockReturnValue('jwt-token') };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthService,
        { provide: getRepositoryToken(User), useValue: userRepo },
        { provide: JwtService, useValue: jwtService },
      ],
    }).compile();

    service = module.get<AuthService>(AuthService);
  });

  it('should return token and user on valid login', async () => {
    userRepo.findOne.mockResolvedValue({ ...mockUser });
    const result = await service.login({ email: 'test@test.com', password: 'password123' });

    expect(result.access_token).toBe('jwt-token');
    expect(result.user).toBeDefined();
    expect((result.user as any).password).toBeUndefined();
    expect(result.is_temp_password).toBe(false);
  });

  it('should throw UnauthorizedException for non-existent user', async () => {
    userRepo.findOne.mockResolvedValue(null);
    await expect(service.login({ email: 'bad@test.com', password: 'pass' }))
      .rejects.toThrow(UnauthorizedException);
  });

  it('should throw UnauthorizedException for wrong password', async () => {
    userRepo.findOne.mockResolvedValue({ ...mockUser });
    await expect(service.login({ email: 'test@test.com', password: 'wrong' }))
      .rejects.toThrow(UnauthorizedException);
  });

  it('should throw UnauthorizedException for inactive user', async () => {
    userRepo.findOne.mockResolvedValue({ ...mockUser, is_active: false });
    await expect(service.login({ email: 'test@test.com', password: 'password123' }))
      .rejects.toThrow(UnauthorizedException);
  });

  it('should throw UnauthorizedException for expired temp password', async () => {
    userRepo.findOne.mockResolvedValue({
      ...mockUser,
      is_temp_password: true,
      temp_password_expires: new Date(Date.now() - 60000), // expired 1 min ago
    });
    await expect(service.login({ email: 'test@test.com', password: 'password123' }))
      .rejects.toThrow(UnauthorizedException);
  });

  it('should flag is_temp_password when user has temp password', async () => {
    userRepo.findOne.mockResolvedValue({
      ...mockUser,
      is_temp_password: true,
      temp_password_expires: new Date(Date.now() + 600000), // valid for 10 min
    });
    const result = await service.login({ email: 'test@test.com', password: 'password123' });
    expect(result.is_temp_password).toBe(true);
  });
});
