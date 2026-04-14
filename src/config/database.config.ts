import { TypeOrmModuleOptions } from '@nestjs/typeorm';
import { join } from 'path';

export const getDatabaseConfig = (): TypeOrmModuleOptions => ({
  type: 'postgres',
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432', 10),
  username: process.env.DB_USERNAME || 'wc2026_user',
  password: process.env.DB_PASSWORD || 'wc2026_pass',
  database: process.env.DB_DATABASE || 'world_cup_2026',
  autoLoadEntities: true,
  synchronize: false,
  migrations: [join(__dirname, '..', 'migrations', '*{.ts,.js}')],
  migrationsRun: true,
  logging: process.env.NODE_ENV === 'development',
  extra: {
    max: parseInt(process.env.DB_POOL_MAX || '20', 10),
    min: parseInt(process.env.DB_POOL_MIN || '5', 10),
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 5000,
  },
});
