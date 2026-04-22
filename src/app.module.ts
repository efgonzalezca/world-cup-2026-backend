import { Module } from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ThrottlerModule, ThrottlerGuard } from '@nestjs/throttler';
import { BullModule } from '@nestjs/bullmq';
import { getDatabaseConfig } from './config/database.config';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { MatchesModule } from './matches/matches.module';
import { TeamsModule } from './teams/teams.module';
import { EventsModule } from './events/events.module';
import { SeedModule } from './seed/seed.module';
import { AppConfigModule } from './app-config/app-config.module';
import { HealthModule } from './health/health.module';
import { CacheModule } from './common/cache/cache.module';
import { RedisModule } from './common/redis/redis.module';
import { JwtUploadsMiddleware } from './common/middleware/jwt-uploads.middleware';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    RedisModule,
    CacheModule,
    TypeOrmModule.forRoot(getDatabaseConfig()),
    ThrottlerModule.forRoot([
      {
        name: 'short',
        ttl: 60000,
        limit: 10,
      },
      {
        name: 'long',
        ttl: 3600000,
        limit: 100,
      },
    ]),
    BullModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (config: ConfigService) => ({
        connection: {
          host: config.getOrThrow<string>('REDIS_HOST'),
          port: config.getOrThrow<number>('REDIS_PORT'),
          password: config.get<string>('REDIS_PASSWORD') || undefined,
          db: config.getOrThrow<number>('REDIS_DB'),
          maxRetriesPerRequest: null,
        },
      }),
      inject: [ConfigService],
    }),
    AuthModule,
    UsersModule,
    MatchesModule,
    TeamsModule,
    EventsModule,
    SeedModule,
    AppConfigModule,
    HealthModule,
  ],
  providers: [
    {
      provide: APP_GUARD,
      useClass: ThrottlerGuard,
    },
    JwtUploadsMiddleware,
  ],
})
export class AppModule { }
