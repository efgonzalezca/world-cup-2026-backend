import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TeamsService } from './teams.service';
import { TeamsController } from './teams.controller';
import { Team } from './entities/team.entity';
import { TournamentGroup } from './entities/tournament-group.entity';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([Team, TournamentGroup]),
    AuthModule,
  ],
  controllers: [TeamsController],
  providers: [TeamsService],
  exports: [TeamsService],
})
export class TeamsModule {}
