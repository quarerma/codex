import { NestFactory } from '@nestjs/core';
import { NestExpressApplication } from '@nestjs/platform-express';
import { AppModule } from './app.module';
import { Logger, ValidationPipe } from '@nestjs/common';
import * as cookieParser from 'cookie-parser';
import * as express from 'express';
async function bootstrap() {
  const logger = new Logger('Bootstrap');
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  const isDev = process.env.NODE_ENV !== 'development';
  app.use(cookieParser());

  app.useGlobalPipes(new ValidationPipe({ transform: true }));

  const allowedOrigins = ['http://localhost:5173', process.env.FRONTEND_URL].filter(Boolean);

  app.enableCors({
    origin: (origin, callback) => {
      if (!origin && isDev) return callback(null, true);
      if (allowedOrigins.includes(origin)) return callback(null, true);
      return callback(new Error('Not allowed by CORS'));
    },
    credentials: true,
  });
  app.use(express.json({ limit: '10mb' }));
  app.use(express.urlencoded({ limit: '10mb', extended: true }));

  app.set('trust proxy', 1);
  app.useGlobalPipes(new ValidationPipe({ transform: true }));

  const shutdown = async (signal: string) => {
    logger.log(`Received ${signal}, shutting down...`);
    try {
      await app.close();
      logger.log('Application closed');
    } catch (err) {
      logger.error('Error during shutdown', err);
    }
    process.exit(0);
  };

  process.on('SIGINT', () => shutdown('SIGINT'));
  process.on('SIGTERM', () => shutdown('SIGTERM'));

  process.env.TZ = 'UTC';

  await app.listen(3000);
}
bootstrap();
