import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { getDatabaseConfig } from './config/database.config';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { MatchesModule } from './matches/matches.module';
import { TeamsModule } from './teams/teams.module';
import { EventsModule } from './events/events.module';
import { SeedModule } from './seed/seed.module';
import { AppConfigModule } from './app-config/app-config.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    TypeOrmModule.forRoot(getDatabaseConfig()),
    AuthModule,
    UsersModule,
    MatchesModule,
    TeamsModule,
    EventsModule,
    SeedModule,
    AppConfigModule,
  ],
})
export class AppModule {}
