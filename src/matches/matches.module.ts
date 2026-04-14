import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { BullModule } from '@nestjs/bullmq';
import { MatchesService } from './matches.service';
import { MatchesController } from './matches.controller';
import { Match } from './entities/match.entity';
import { UserMatch } from '../users/entities/user-match.entity';
import { User } from '../users/entities/user.entity';
import { EventsModule } from '../events/events.module';
import { AuthModule } from '../auth/auth.module';
import { SCORE_CALCULATION_QUEUE } from './jobs/score-calculation.constants';
import { ScoreCalculationProcessor } from './jobs/score-calculation.processor';

@Module({
  imports: [
    TypeOrmModule.forFeature([Match, UserMatch, User]),
    BullModule.registerQueue({ name: SCORE_CALCULATION_QUEUE }),
    EventsModule,
    AuthModule,
  ],
  controllers: [MatchesController],
  providers: [MatchesService, ScoreCalculationProcessor],
  exports: [MatchesService],
})
export class MatchesModule {}
