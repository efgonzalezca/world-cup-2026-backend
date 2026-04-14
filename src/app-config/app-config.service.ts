import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { AppConfig } from './entities/app-config.entity';
import { CacheService } from '../common/cache/cache.service';

@Injectable()
export class AppConfigService {
  private readonly logger = new Logger(AppConfigService.name);

  constructor(
    @InjectRepository(AppConfig)
    private readonly configRepository: Repository<AppConfig>,
    private readonly cacheService: CacheService,
  ) {}

  async get(key: string): Promise<string | null> {
    const cacheKey = `config:${key}`;
    const cached = await this.cacheService.get<{ v: string | null }>(cacheKey);
    if (cached) return cached.v;

    const config = await this.configRepository.findOne({ where: { key } });
    const value = config?.value ?? null;
    await this.cacheService.set(cacheKey, { v: value }, 3_600_000);
    return value;
  }

  async set(key: string, value: string, description?: string): Promise<AppConfig> {
    let config = await this.configRepository.findOne({ where: { key } });
    if (!config) {
      config = this.configRepository.create({ key, value, description: description ?? null });
    } else {
      config.value = value;
      if (description !== undefined) config.description = description;
    }
    const saved = await this.configRepository.save(config);
    await this.cacheService.del(`config:${key}`);
    return saved;
  }

  async getAll(): Promise<AppConfig[]> {
    return this.configRepository.find({ order: { key: 'ASC' } });
  }

  async getPodiumDeadline(): Promise<string | null> {
    return this.get('podium_deadline');
  }
}
