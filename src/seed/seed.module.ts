import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SeedService } from './seed.service';
import { TournamentGroup } from '../teams/entities/tournament-group.entity';
import { Team } from '../teams/entities/team.entity';
import { Match } from '../matches/entities/match.entity';
import { AppConfig } from '../app-config/entities/app-config.entity';

@Module({
  imports: [TypeOrmModule.forFeature([TournamentGroup, Team, Match, AppConfig])],
  providers: [SeedService],
})
export class SeedModule {}
