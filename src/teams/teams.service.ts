import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Team } from './entities/team.entity';
import { TournamentGroup } from './entities/tournament-group.entity';

@Injectable()
export class TeamsService {
  private readonly logger = new Logger(TeamsService.name);

  constructor(
    @InjectRepository(Team)
    private readonly teamRepository: Repository<Team>,
    @InjectRepository(TournamentGroup)
    private readonly groupRepository: Repository<TournamentGroup>,
  ) {}

  async findAll(groupCode?: string) {
    const where: any = {};
    if (groupCode) where.group_code = groupCode;

    return this.teamRepository.find({
      where,
      relations: ['group'],
      order: { group_code: 'ASC', fifa_rank: 'ASC' },
    });
  }

  async findGroups() {
    return this.groupRepository.find({
      relations: ['teams'],
      order: { id: 'ASC' },
    });
  }
}
