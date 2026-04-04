import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { User } from './entities/user.entity';
import { UserMatch } from './entities/user-match.entity';
import { UserPodium } from './entities/user-podium.entity';
import { Match } from '../matches/entities/match.entity';
import { EventsModule } from '../events/events.module';
import { AppConfigModule } from '../app-config/app-config.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([User, UserMatch, UserPodium, Match]),
    EventsModule,
    AppConfigModule,
  ],
  controllers: [UsersController],
  providers: [UsersService],
  exports: [UsersService],
})
export class UsersModule {}
