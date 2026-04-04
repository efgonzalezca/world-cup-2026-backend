import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { AppConfig } from './entities/app-config.entity';

@Injectable()
export class AppConfigService {
  private readonly logger = new Logger(AppConfigService.name);

  constructor(
    @InjectRepository(AppConfig)
    private readonly configRepository: Repository<AppConfig>,
  ) {}

  async get(key: string): Promise<string | null> {
    const config = await this.configRepository.findOne({ where: { key } });
    return config?.value ?? null;
  }

  async set(key: string, value: string, description?: string): Promise<AppConfig> {
    let config = await this.configRepository.findOne({ where: { key } });
    if (!config) {
      config = this.configRepository.create({ key, value, description: description ?? null });
    } else {
      config.value = value;
      if (description !== undefined) config.description = description;
    }
    return this.configRepository.save(config);
  }

  async getAll(): Promise<AppConfig[]> {
    return this.configRepository.find({ order: { key: 'ASC' } });
  }

  async getPodiumDeadline(): Promise<string | null> {
    return this.get('podium_deadline');
  }
}
