import { DataSource } from 'typeorm';
import { config } from 'dotenv';
import { readFileSync } from 'fs';
import { join } from 'path';
import { Logger } from '@nestjs/common';

config();

const logger = new Logger('TestDataRunner');

async function bootstrap() {
  const dataSource = new DataSource({
    type: 'postgres',
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '5432', 10),
    username: process.env.DB_USERNAME || 'wc2026_user',
    password: process.env.DB_PASSWORD || 'wc2026_pass',
    database: process.env.DB_DATABASE || 'world_cup_2026',
  });

  await dataSource.initialize();
  logger.log('Connected to database');

  const scriptsDir = join(__dirname);

  const seedFiles = [
    'seed-full-global.sql',
    'seed-new-users-predictions.sql',
  ];

  for (const file of seedFiles) {
    const filePath = join(scriptsDir, file);
    try {
      const sql = readFileSync(filePath, 'utf8');
      logger.log(`Executing ${file}...`);
      await dataSource.query(sql);
      logger.log(`${file} executed successfully`);
    } catch (err) {
      logger.warn(`${file} not found or failed: ${(err as Error).message}`);
    }
  }

  await dataSource.destroy();
  logger.log('Test data load completed.');
  process.exit(0);
}

bootstrap().catch((err) => {
  console.error('Test data load failed:', err);
  process.exit(1);
});