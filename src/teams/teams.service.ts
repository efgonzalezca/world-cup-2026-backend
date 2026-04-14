import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Team } from './entities/team.entity';
import { TournamentGroup } from './entities/tournament-group.entity';
import { CacheService } from '../common/cache/cache.service';

@Injectable()
export class TeamsService {
  private readonly logger = new Logger(TeamsService.name);

  constructor(
    @InjectRepository(Team)
    private readonly teamRepository: Repository<Team>,
    @InjectRepository(TournamentGroup)
    private readonly groupRepository: Repository<TournamentGroup>,
    private readonly cacheService: CacheService,
  ) {}

  async findAll(groupCode?: string) {
    const cacheKey = `teams:${groupCode || 'all'}`;
    const cached = await this.cacheService.get(cacheKey);
    if (cached) return cached;

    const where: any = {};
    if (groupCode) where.group_code = groupCode;

    const data = await this.teamRepository.find({
      where,
      relations: ['group'],
      order: { group_code: 'ASC', fifa_rank: 'ASC' },
    });

    await this.cacheService.set(cacheKey, data, 86_400_000);
    return data;
  }

  async findGroups() {
    const cacheKey = 'groups:all';
    const cached = await this.cacheService.get(cacheKey);
    if (cached) return cached;

    const data = await this.groupRepository.find({
      relations: ['teams'],
      order: { id: 'ASC' },
    });

    await this.cacheService.set(cacheKey, data, 86_400_000);
    return data;
  }
}
