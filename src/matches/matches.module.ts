import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MatchesService } from './matches.service';
import { MatchesController } from './matches.controller';
import { Match } from './entities/match.entity';
import { UserMatch } from '../users/entities/user-match.entity';
import { User } from '../users/entities/user.entity';
import { EventsModule } from '../events/events.module';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([Match, UserMatch, User]),
    EventsModule,
    AuthModule,
  ],
  controllers: [MatchesController],
  providers: [MatchesService],
  exports: [MatchesService],
})
export class MatchesModule {}
