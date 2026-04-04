import { TypeOrmModuleOptions } from '@nestjs/typeorm';

export const getDatabaseConfig = (): TypeOrmModuleOptions => ({
  type: 'postgres',
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432', 10),
  username: process.env.DB_USERNAME || 'wc2026_user',
  password: process.env.DB_PASSWORD || 'wc2026_pass',
  database: process.env.DB_DATABASE || 'world_cup_2026',
  autoLoadEntities: true,
  synchronize: process.env.NODE_ENV !== 'production',
  logging: process.env.NODE_ENV === 'development',
});
