import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { CacheService } from 'src/cache/cache.service';
import { UserSessionExecutor } from 'src/user/executor/session.executor';

@Injectable()
export class CacheServiceMiddleware implements NestMiddleware {
  constructor(
    private readonly cacheService: CacheService,
    private readonly sessionExecutor: UserSessionExecutor,
  ) {}

  use(req: Request, res: Response, next: NextFunction) {
    req['cacheService'] = this.cacheService;
    req['sessionExecutor'] = this.sessionExecutor;
    next();
  }
}
