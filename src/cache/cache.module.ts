import { Global, Module } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import Redis from 'ioredis';
import { Queue } from 'bullmq';
import { CacheService } from './cache.service';

@Global()
@Module({
  providers: [
    {
      provide: 'REDIS',
      inject: [ConfigService],
      useFactory: (config: ConfigService) => {
        return new Redis({
          host: config.get<string>('REDIS_HOST', 'localhost'),
          port: parseInt(config.get<string>('REDIS_PORT', '6379')),
          password: config.get<string>('REDIS_PASSWORD') || undefined,
        });
      },
    },
    {
      provide: 'CACHE_QUEUE',
      inject: [ConfigService],
      useFactory: (config: ConfigService) => {
        return new Queue('cache-warm', {
          connection: {
            host: config.get<string>('REDIS_HOST', 'localhost'),
            port: parseInt(config.get<string>('REDIS_PORT', '6379')),
            password: config.get<string>('REDIS_PASSWORD') || undefined,
          },
        });
      },
    },
    CacheService,
  ],
  exports: [CacheService, 'CACHE_QUEUE', 'REDIS'],
})
export class CacheModule {}
