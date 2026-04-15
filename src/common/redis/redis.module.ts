import { Global, Module, OnModuleDestroy, Inject, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import Redis from 'ioredis';
import { REDIS_CLIENT } from './redis.constants';

@Global()
@Module({
  providers: [
    {
      provide: REDIS_CLIENT,
      useFactory: (config: ConfigService) => {
        const logger = new Logger('RedisModule');
        const client = new Redis({
          host: config.getOrThrow<string>('REDIS_HOST'),
          port: config.getOrThrow<number>('REDIS_PORT'),
          password: config.get<string>('REDIS_PASSWORD') || undefined,
          db: config.getOrThrow<number>('REDIS_DB'),
          maxRetriesPerRequest: null,
          lazyConnect: true,
        });

        client.on('connect', () => logger.log('Redis connected'));
        client.on('error', (err) => logger.error(`Redis error: ${err.message}`));

        client.connect().catch((err) => {
          logger.error(`Redis connection failed: ${err.message}`);
        });

        return client;
      },
      inject: [ConfigService],
    },
  ],
  exports: [REDIS_CLIENT],
})
export class RedisModule implements OnModuleDestroy {
  constructor(@Inject(REDIS_CLIENT) private readonly redis: Redis) {}

  async onModuleDestroy() {
    await this.redis.quit();
  }
}
