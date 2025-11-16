import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { JwtAuthGuard } from './jwt.guards';
import { UserRequest } from 'src/user/dto/user-request';
import { CacheService } from 'src/cache/cache.service';
import { CampaignFetcher } from 'src/campaings/executors/campaign.fetcher';
import { CharacterFetcher } from 'src/character/executor/character.fetcher';

@Injectable()
export class CampaignCharacterOwnerGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    private jwtAuthGuard: JwtAuthGuard,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const isJwtValid = await this.jwtAuthGuard.canActivate(context);
    if (!isJwtValid) {
      return false;
    }

    const request = context.switchToHttp().getRequest();
    const user: UserRequest = request.user;
    if (!user) {
      throw new UnauthorizedException('User not authenticated');
    }

    const cacheService: CacheService = request['cacheService'];
    const campaignFetcher: CampaignFetcher = request['campaignFetcher'];
    const characterFetcher: CharacterFetcher = request['characterFetcher'];

    const { campaign_id, character_id } = request.params;

    if (!campaign_id && !character_id) {
      throw new UnauthorizedException('Missing campaign_id or character_id in route parameters');
    }

    const method = request.method.toUpperCase();

    const userId = user.id;

    try {
      let hasAccess = false;

      if (campaign_id) {
        const campaign = await cacheService.getCached('campaign', [`${campaign_id}`], () => campaignFetcher.fetchCampaignBasicisById(campaign_id), 5 * 60 * 1000);

        if (!campaign) {
          throw new UnauthorizedException('Campaign not found');
        }

        if (campaign.ownerId === userId) {
          hasAccess = true;
        } else if (method === 'GET') {
          const isPlayer = campaign.players.some((p) => p.playerId === userId);
          if (isPlayer) {
            hasAccess = true;
          }
        } else {
          throw new UnauthorizedException('You are not part of this campaign');
        }
      }

      if (character_id) {
        const character = await cacheService.getCached('character', [`${character_id}`], () => characterFetcher.fetchCharacterBasicisById(character_id), 5 * 60 * 1000);
        const characterCampaign = await cacheService.getCached('campaign', [`${character?.campaignId}`], () => campaignFetcher.fetchCampaignBasicisById(character!.campaignId), 5 * 60 * 1000);

        const hasOwnership = character && (character.ownerId === userId || characterCampaign.ownerId === userId);
        if (!character) {
          throw new UnauthorizedException('Character not found');
        }

        if (hasOwnership) {
          hasAccess = true;
        } else if (method === 'GET') {
          if (character.privacy_level === 'PUBLIC') {
            hasAccess = true;
          } else if (character.privacy_level === 'CAMPAIGN_ONLY') {
            const isPlayer = characterCampaign.players.some((p) => p.playerId === userId);
            if (isPlayer) {
              hasAccess = true;
            }
          }
        } else {
          if (!hasOwnership) {
            throw new UnauthorizedException('You do not have permission to modify this character');
          }
        }
      }

      if (!hasAccess) {
        throw new UnauthorizedException('You do not own this campaign or character');
      }

      return true;
    } catch (error) {
      if (error instanceof UnauthorizedException) {
        throw error;
      }
      throw new UnauthorizedException('Failed to validate ownership');
    }
  }
}
