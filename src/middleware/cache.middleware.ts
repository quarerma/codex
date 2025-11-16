import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { CacheService } from 'src/cache/cache.service';
import { CampaignFetcher } from 'src/campaings/executors/campaign.fetcher';
import { CharacterFetcher } from 'src/character/executor/character.fetcher';
import { UserSessionExecutor } from 'src/user/executor/session.executor';

@Injectable()
export class CacheServiceMiddleware implements NestMiddleware {
  constructor(
    private readonly cacheService: CacheService,
    private readonly sessionExecutor: UserSessionExecutor,
    private readonly characterFetcher: CharacterFetcher,
    private readonly campaignFetcher: CampaignFetcher,
  ) {}

  use(req: Request, res: Response, next: NextFunction) {
    req['cacheService'] = this.cacheService;
    req['sessionExecutor'] = this.sessionExecutor;
    req['characterFetcher'] = this.characterFetcher;
    req['campaignFetcher'] = this.campaignFetcher;
    next();
  }
}
