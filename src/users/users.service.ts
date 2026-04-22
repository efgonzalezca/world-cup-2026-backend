import { Injectable, ConflictException, NotFoundException, BadRequestException, ForbiddenException, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ConfigService } from '@nestjs/config';
import { Repository, DataSource } from 'typeorm';
import * as bcrypt from 'bcrypt';
import * as crypto from 'crypto';
import { User } from './entities/user.entity';
import { UserMatch } from './entities/user-match.entity';
import { UserPodium } from './entities/user-podium.entity';
import { Match } from '../matches/entities/match.entity';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdatePredictionDto } from './dto/update-prediction.dto';
import { EventsGateway } from '../events/events.gateway';
import { AppConfigService } from '../app-config/app-config.service';
import { CacheService } from '../common/cache/cache.service';

@Injectable()
export class UsersService {
  private readonly logger = new Logger(UsersService.name);

  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    @InjectRepository(UserMatch)
    private readonly userMatchRepository: Repository<UserMatch>,
    @InjectRepository(UserPodium)
    private readonly userPodiumRepository: Repository<UserPodium>,
    @InjectRepository(Match)
    private readonly matchRepository: Repository<Match>,
    private readonly dataSource: DataSource,
    private readonly configService: ConfigService,
    private readonly eventsGateway: EventsGateway,
    private readonly appConfigService: AppConfigService,
    private readonly cacheService: CacheService,
  ) { }

  async create(createUserDto: CreateUserDto): Promise<Omit<User, 'password'>> {
    const { email, nickname, password, ...rest } = createUserDto;

    const existingEmail = await this.userRepository.findOne({ where: { email } });
    if (existingEmail) throw new ConflictException('El correo electronico ya esta registrado');

    const existingNickname = await this.userRepository.findOne({ where: { nickname } });
    if (existingNickname) throw new ConflictException('El nickname ya esta en uso');

    const saltRounds = parseInt(this.configService.getOrThrow<string>('SALT_ROUNDS'), 10);
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    const queryRunner = this.dataSource.createQueryRunner();
    await queryRunner.connect();
    await queryRunner.startTransaction();

    try {
      const user = this.userRepository.create({
        email,
        nickname,
        password: hashedPassword,
        ...rest,
      });
      const savedUser = await queryRunner.manager.save(user);

      const matches = await this.matchRepository.find();
      const predictions = matches.map((match) =>
        this.userMatchRepository.create({
          user_id: savedUser.id,
          match_id: match.id,
        }),
      );
      await queryRunner.manager.save(predictions);

      const podium = this.userPodiumRepository.create({ user_id: savedUser.id });
      await queryRunner.manager.save(podium);

      await queryRunner.commitTransaction();

      this.logger.log(`User ${email} registered successfully`);
      await this.cacheService.delByPrefix('ranking:');
      this.eventsGateway.emitUserRegistered();
      const { password: _, ...result } = savedUser;
      return result as Omit<User, 'password'>;
    } catch (error) {
      await queryRunner.rollbackTransaction();
      throw error;
    } finally {
      await queryRunner.release();
    }
  }

  async getRanking(page: number, limit: number, currentUserId: string) {
    const safePage = Math.max(1, page);
    const safeLimit = Math.min(Math.max(1, limit), 100);

    const cacheKey = `ranking:${safePage}:${safeLimit}:${currentUserId}`;
    const cached = await this.cacheService.get(cacheKey);
    if (cached) return cached;

    const qb = this.userRepository
      .createQueryBuilder('u')
      .select([
        'u.id AS id',
        'u.nickname AS nickname',
        'u.score AS score',
        'u.podium_score AS podium_score',
        '(u.score + u.podium_score) AS total_score',
        'u.profile_image AS profile_image',
      ])
      .where('u.is_active = :active', { active: true })
      .orderBy('(u.score + u.podium_score)', 'DESC')
      .addOrderBy('u.nickname', 'ASC');

    const total = await qb.getCount();

    const data = await qb
      .offset((safePage - 1) * safeLimit)
      .limit(safeLimit)
      .getRawMany();

    const currentUser = await this.getUserRankPosition(currentUserId);

    const totalPages = Math.ceil(total / safeLimit);
    const result = { data, total, page: safePage, limit: safeLimit, totalPages, currentUser };
    await this.cacheService.set(cacheKey, result, 120_000);
    return result;
  }

  private async getUserRankPosition(userId: string) {
    const user = await this.userRepository.findOne({
      where: { id: userId, is_active: true },
      select: ['id', 'nickname', 'score', 'podium_score', 'profile_image'],
    });
    if (!user) return null;

    const totalScore = user.score + user.podium_score;

    const higherCount = await this.userRepository
      .createQueryBuilder('u')
      .where('u.is_active = :active', { active: true })
      .andWhere('(u.score + u.podium_score) > :totalScore', { totalScore })
      .getCount();

    return {
      id: user.id,
      nickname: user.nickname,
      score: user.score,
      podium_score: user.podium_score,
      total_score: totalScore,
      profile_image: user.profile_image,
      position: higherCount + 1,
    };
  }

  async getUserPredictions(userId: string, requestUserId: string) {
    if (userId !== requestUserId) throw new ForbiddenException('No autorizado');
    return this.userMatchRepository.find({
      where: { user_id: userId },
      select: ['id', 'user_id', 'match_id', 'local_score', 'visitor_score', 'points', 'discriminated_points'],
    });
  }

  async getMatchPredictions(matchId: string, page: number, limit: number) {
    const safePage = Math.max(1, page);
    const safeLimit = Math.min(Math.max(1, limit), 100);

    const match = await this.matchRepository.findOne({ where: { id: matchId } });
    if (!match) throw new NotFoundException('Partido no encontrado');

    const [activeUsers, total] = await this.userRepository.findAndCount({
      where: { is_active: true },
      select: ['id', 'nickname'],
      order: { nickname: 'ASC' },
      skip: (safePage - 1) * safeLimit,
      take: safeLimit,
    });

    const userIds = activeUsers.map((u) => u.id);

    const predictions = userIds.length > 0
      ? await this.userMatchRepository
        .createQueryBuilder('um')
        .select(['um.id', 'um.user_id', 'um.local_score', 'um.visitor_score', 'um.points', 'um.discriminated_points'])
        .where('um.match_id = :matchId', { matchId })
        .andWhere('um.user_id IN (:...userIds)', { userIds })
        .getMany()
      : [];

    const predictionMap = new Map(predictions.map((p) => [p.user_id, p]));

    const data = activeUsers.map((user) => {
      const pred = predictionMap.get(user.id);
      return {
        id: pred?.id ?? `no-pred-${user.id}`,
        local_score: pred?.local_score ?? null,
        visitor_score: pred?.visitor_score ?? null,
        points: pred?.points ?? 0,
        discriminated_points: pred?.discriminated_points ?? null,
        user: { id: user.id, nickname: user.nickname },
      };
    });

    return { data, total, page: safePage, limit: safeLimit };
  }

  async updateUser(userId: string, requestUserId: string, updateData: { nickname?: string; password?: string; champion_team_id?: string; runner_up_team_id?: string; third_place_team_id?: string }) {
    if (userId !== requestUserId) throw new ForbiddenException('No autorizado');

    const user = await this.userRepository.findOne({ where: { id: userId } });
    if (!user) throw new NotFoundException('Usuario no encontrado');

    if (updateData.nickname && updateData.nickname !== user.nickname) {
      const existing = await this.userRepository.findOne({ where: { nickname: updateData.nickname } });
      if (existing && existing.id !== userId) throw new ConflictException('El nickname ya esta en uso');
      user.nickname = updateData.nickname;
      await this.userRepository.save(user);
      await this.cacheService.delByPrefix('ranking:');
    }

    if (updateData.password) {
      const saltRounds = parseInt(this.configService.getOrThrow<string>('SALT_ROUNDS'), 10);
      user.password = await bcrypt.hash(updateData.password, saltRounds);
      user.is_temp_password = false;
      user.temp_password_expires = null;
      await this.userRepository.save(user);
      this.eventsGateway.emitForceLogout(userId);
    }

    if (updateData.champion_team_id !== undefined || updateData.runner_up_team_id !== undefined || updateData.third_place_team_id !== undefined) {
      const deadlineStr = await this.appConfigService.getPodiumDeadline();
      if (deadlineStr) {
        const deadline = new Date(deadlineStr);
        if (new Date() >= deadline) {
          throw new BadRequestException('El plazo para modificar predicciones de podio ha finalizado');
        }
      }

      let podium = await this.userPodiumRepository.findOne({ where: { user_id: userId } });
      if (!podium) {
        podium = this.userPodiumRepository.create({ user_id: userId });
      }
      if (updateData.champion_team_id !== undefined) podium.champion_team_id = updateData.champion_team_id;
      if (updateData.runner_up_team_id !== undefined) podium.runner_up_team_id = updateData.runner_up_team_id;
      if (updateData.third_place_team_id !== undefined) podium.third_place_team_id = updateData.third_place_team_id;
      await this.userPodiumRepository.save(podium);
    }

    const { password: _, ...result } = user;
    return result;
  }

  async updateProfileImage(userId: string, requestUserId: string, imageUrl: string) {
    if (userId !== requestUserId) throw new ForbiddenException('No autorizado');
    const user = await this.userRepository.findOne({ where: { id: userId } });
    if (!user) throw new NotFoundException('Usuario no encontrado');
    user.profile_image = imageUrl;
    await this.userRepository.save(user);
    await this.cacheService.delByPrefix('ranking:');
    this.eventsGateway.emitProfileUpdated(userId, imageUrl);
    const { password: _, ...result } = user;
    return result;
  }

  async requestPasswordReset(email: string) {
    const user = await this.userRepository.findOne({ where: { email } });
    if (!user) throw new NotFoundException('Correo electronico no registrado');

    const tempPassword = crypto.randomBytes(4).toString('hex');
    const saltRounds = parseInt(this.configService.getOrThrow<string>('SALT_ROUNDS'), 10);
    user.password = await bcrypt.hash(tempPassword, saltRounds);
    user.is_temp_password = true;
    user.temp_password_expires = new Date(Date.now() + 15 * 60 * 1000);
    await this.userRepository.save(user);

    this.logger.log(`Temporary password generated for ${email}`);

    return { message: 'Contrasena temporal enviada al correo electronico' };
  }

  async updatePrediction(userId: string, matchId: string, requestUserId: string, dto: UpdatePredictionDto) {
    if (userId !== requestUserId) throw new ForbiddenException('No autorizado');

    const match = await this.matchRepository.findOne({ where: { id: matchId } });
    if (!match) throw new NotFoundException('Partido no encontrado');

    if (match.has_played) {
      throw new BadRequestException('No se pueden modificar predicciones de un partido ya jugado');
    }

    const now = new Date();
    if (now >= match.match_date) {
      throw new BadRequestException('No se pueden modificar predicciones despues de la fecha del partido');
    }

    let prediction = await this.userMatchRepository.findOne({
      where: { user_id: userId, match_id: matchId },
    });

    if (!prediction) {
      prediction = this.userMatchRepository.create({
        user_id: userId,
        match_id: matchId,
      });
    }

    prediction.local_score = dto.local_score;
    prediction.visitor_score = dto.visitor_score;

    const saved = await this.userMatchRepository.save(prediction);
    await this.cacheService.delByPrefix('matchPredictions:');
    this.eventsGateway.emitPredictionSaved(userId, matchId, dto.local_score, dto.visitor_score);
    this.eventsGateway.emitMatchPredictionUpdated(matchId);
    return saved;
  }
}
