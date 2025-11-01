import { Inject, Injectable, OnModuleInit } from '@nestjs/common';
import { createHash } from 'crypto';
import Redis from 'ioredis';
import { Queue, Worker, Job } from 'bullmq';
import { brotliCompressSync, brotliDecompressSync, constants } from 'zlib';

@Injectable()
export class CacheService implements OnModuleInit {
  private readonly ONE_HOUR = 60 * 60 * 1000;
  private readonly STALE_THRESHOLD = 10 * 60 * 1000;
  private readonly fetchers = new Map<string, (args: any[]) => Promise<any>>();

  constructor(
    @Inject('REDIS') private readonly redis: Redis,
    @Inject('CACHE_QUEUE') private readonly warmQueue: Queue,
  ) {}

  onModuleInit() {
    new Worker(this.warmQueue.name, this.warmProcessor.bind(this), { connection: this.warmQueue.opts.connection as any });
  }

  private makeKey(parts: string[]): string {
    const [pageId, ...keyParts] = parts;
    const partsHash = createHash('sha256').update(keyParts.join('|')).digest('hex');
    return `${pageId}:${partsHash}`;
  }

  private registerFetcher(fetcherKey: string, fetcher: (args: any[]) => Promise<any>) {
    if (!this.fetchers.has(fetcherKey)) {
      this.fetchers.set(fetcherKey, fetcher);
    }
  }

  async getCached<T>(pageId: string, keyParts: string[], fetcher?: () => Promise<T>, customStaleTime?: number): Promise<T> {
    const key = this.makeKey([pageId, ...keyParts]);
    if (fetcher) {
      this.registerFetcher(key, (_args) => fetcher());
    }
    const cached = await this.redis.getBuffer(key);
    if (cached) {
      const payload: T = JSON.parse(brotliDecompressSync(cached).toString());
      const ttl = await this.redis.pttl(key);
      if (ttl !== -1) {
        const age = this.ONE_HOUR - ttl;
        const staleThreshold = customStaleTime ?? this.STALE_THRESHOLD;
        if (age > staleThreshold) {
          await this.warmQueue.add('warm', { pageId, parts: keyParts });
        }
      }
      return payload;
    }
    const registeredFetcher = fetcher || this.fetchers.get(key);
    if (!registeredFetcher) {
      throw new Error(`No fetcher provided and no registered fetcher found for key: ${key}`);
    }
    const data = await registeredFetcher([]);
    const compressed = brotliCompressSync(Buffer.from(JSON.stringify(data)), {
      params: { [constants.BROTLI_PARAM_QUALITY]: 4 },
    });
    await this.redis.set(key, compressed, 'PX', this.ONE_HOUR);
    console.log('Fetched data from function');

    return data;
  }

  async clearCache(): Promise<void> {
    await this.redis.flushdb();
  }

  // caches with page = 'session'
  async deleteSessionCaches(): Promise<void> {
    console.log('Deleting session caches');
    const keys = await this.redis.keys('session:*');
    if (keys.length > 0) {
      await this.redis.del(...keys);
    }
  }

  async deleteSpecificCache(pageId: string, keyParts: string[]) {
    const key = this.makeKey([pageId, ...keyParts]);
    await this.redis.del(key);
  }

  async clearPreloadCache(): Promise<{ deletedKeys: number; message: string }> {
    try {
      // Get all keys from Redis
      const allKeys = await this.redis.keys('*');

      // Filter keys that are likely from preload/cache warming
      // These include:
      // 1. Keys from CacheUtilsService (pattern: cache:${keyName}:${keyId}:filters:${hash})
      // 2. Keys from CacheService (hashed keys that are registered with fetchers)
      const preloadKeys = allKeys.filter((key) => {
        // Check if it's a CacheUtilsService key pattern
        if (key.startsWith('cache:')) {
          return true;
        }

        // Check if it's a registered fetcher key (from CacheService)
        // Since these are hashed, we can't easily identify them by pattern
        // But we can check if they exist in our fetchers map
        return this.fetchers.has(key);
      });

      if (preloadKeys.length === 0) {
        return { deletedKeys: 0, message: 'No preload cache entries found' };
      }

      // Delete the filtered keys
      const deletedCount = await this.redis.del(...preloadKeys);

      return {
        deletedKeys: deletedCount,
        message: `Successfully cleared ${deletedCount} preload cache entries`,
      };
    } catch (error) {
      throw new Error(`Failed to clear preload cache: ${error.message}`);
    }
  }

  async clearCacheByPattern(pattern: string): Promise<{ deletedKeys: number; message: string }> {
    try {
      const keys = await this.redis.keys(pattern);

      if (keys.length === 0) {
        return { deletedKeys: 0, message: `No cache entries found matching pattern: ${pattern}` };
      }

      const deletedCount = await this.redis.del(...keys);

      return {
        deletedKeys: deletedCount,
        message: `Successfully cleared ${deletedCount} cache entries matching pattern: ${pattern}`,
      };
    } catch (error) {
      throw new Error(`Failed to clear cache by pattern: ${error.message}`);
    }
  }

  async getCacheStats(): Promise<{ totalKeys: number; preloadKeys: number; patterns: Record<string, number> }> {
    try {
      const allKeys = await this.redis.keys('*');
      const preloadKeys = allKeys.filter((key) => {
        if (key.startsWith('cache:')) {
          return true;
        }
        return this.fetchers.has(key);
      });

      // Count keys by pattern
      const patterns: Record<string, number> = {};
      allKeys.forEach((key) => {
        if (key.startsWith('cache:')) {
          const parts = key.split(':');
          const keyType = parts[1] || 'unknown';
          patterns[keyType] = (patterns[keyType] || 0) + 1;
        } else {
          patterns['hashed'] = (patterns['hashed'] || 0) + 1;
        }
      });

      return {
        totalKeys: allKeys.length,
        preloadKeys: preloadKeys.length,
        patterns,
      };
    } catch (error) {
      throw new Error(`Failed to get cache stats: ${error.message}`);
    }
  }
  private async warmProcessor(job: Job) {
    const { pageId, parts } = job.data as { pageId: string; parts: string[] };
    const key = this.makeKey([pageId, ...parts]);
    const fetcher = this.fetchers.get(key);
    if (!fetcher) return;
    const data = await fetcher(parts);
    const compressed = brotliCompressSync(Buffer.from(JSON.stringify(data)));
    await this.redis.set(key, compressed, 'PX', this.ONE_HOUR);
  }

  async setCached<T>(pageId: string, keyParts: string[], data: T, ttl: number = this.ONE_HOUR): Promise<void> {
    const key = this.makeKey([pageId, ...keyParts]);
    const compressed = brotliCompressSync(Buffer.from(JSON.stringify(data)), {
      params: { [constants.BROTLI_PARAM_QUALITY]: 4 },
    });
    await this.redis.set(key, compressed, 'PX', ttl);
    console.log(`Cached data for key: ${key} with TTL: ${ttl}ms`);
  }
}
