import { Injectable, Inject } from '@nestjs/common';
import Redis from 'ioredis';
import { REDIS_CLIENT } from '../redis/redis.constants';

@Injectable()
export class CacheService {
  constructor(@Inject(REDIS_CLIENT) private readonly redis: Redis) {}

  async get<T>(key: string): Promise<T | null> {
    const raw = await this.redis.get(key);
    if (!raw) return null;
    return JSON.parse(raw) as T;
  }

  async set(key: string, value: unknown, ttlMs: number): Promise<void> {
    await this.redis.set(key, JSON.stringify(value), 'PX', ttlMs);
  }

  async del(key: string): Promise<void> {
    await this.redis.del(key);
  }

  async delByPrefix(prefix: string): Promise<void> {
    const stream = this.redis.scanStream({ match: `${prefix}*`, count: 100 });
    const pipeline = this.redis.pipeline();
    let count = 0;

    for await (const keys of stream) {
      for (const key of keys as string[]) {
        pipeline.del(key);
        count++;
      }
    }

    if (count > 0) await pipeline.exec();
  }
}
