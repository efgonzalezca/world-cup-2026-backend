import './config/env.validation';
import { NestFactory } from '@nestjs/core';
import { ValidationPipe, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as express from 'express';
import * as path from 'path';
import helmet from 'helmet';
import { AppModule } from './app.module';
import { HttpExceptionFilter } from './common/filters/http-exception.filter';
import { JwtUploadsMiddleware } from './common/middleware/jwt-uploads.middleware';

async function bootstrap() {
  const isProduction = process.env.NODE_ENV === 'production';

  const app = await NestFactory.create(AppModule, {
    logger: isProduction
      ? ['error', 'warn', 'log']
      : ['error', 'warn', 'log', 'debug', 'verbose'],
  });

  const configService = app.get(ConfigService);
  const logger = new Logger('Bootstrap');

  app.use(helmet({
    crossOriginResourcePolicy: { policy: 'cross-origin' },
  }));

  app.enableCors({
    origin: configService.getOrThrow<string>('CORS_ORIGIN'),
    credentials: true,
  });

  app.setGlobalPrefix('api');

  const uploadsAuth = app.get(JwtUploadsMiddleware);
  app.use('/api/uploads',
    uploadsAuth.use.bind(uploadsAuth),
    express.static(path.join(process.cwd(), 'uploads'), {
      setHeaders: (res) => {
        res.setHeader('X-Content-Type-Options', 'nosniff');
      },
    }),
  );

  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
    }),
  );

  app.useGlobalFilters(new HttpExceptionFilter());

  const port = configService.getOrThrow<number>('PORT');
  await app.listen(port);

  logger.log(`Environment: ${configService.getOrThrow<string>('NODE_ENV')}`);
  logger.log(`Application running on port ${port}`);
  logger.log(`CORS origin: ${configService.getOrThrow<string>('CORS_ORIGIN')}`);
}
bootstrap();
