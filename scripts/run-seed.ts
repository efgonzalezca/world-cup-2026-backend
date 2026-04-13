import { NestFactory } from '@nestjs/core';
import { AppModule } from '../src/app.module';
import { SeedService } from '../src/seed/seed.service';
import { Logger } from '@nestjs/common';

async function bootstrap() {
  const logger = new Logger('SeedRunner');

  const app = await NestFactory.createApplicationContext(AppModule, {
    logger: ['error', 'warn', 'log'],
  });

  const seedService = app.get(SeedService);

  logger.log('Running base seed (groups, teams, matches, config)...');
  await seedService.seedIfEmpty();
  logger.log('Base seed completed.');

  await app.close();
  process.exit(0);
}

bootstrap().catch((err) => {
  console.error('Seed failed:', err);
  process.exit(1);
});