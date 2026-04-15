import { TypeOrmModuleOptions } from '@nestjs/typeorm';
import { join } from 'path';

export const getDatabaseConfig = (): TypeOrmModuleOptions => ({
  type: 'postgres',
  host: process.env.DB_HOST,
  port: parseInt(process.env.DB_PORT!, 10),
  username: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  autoLoadEntities: true,
  synchronize: false,
  migrations: [join(__dirname, '..', 'migrations', '*{.ts,.js}')],
  migrationsRun: true,
  logging: process.env.NODE_ENV === 'development',
  extra: {
    max: parseInt(process.env.DB_POOL_MAX!, 10),
    min: parseInt(process.env.DB_POOL_MIN!, 10),
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 5000,
  },
});
