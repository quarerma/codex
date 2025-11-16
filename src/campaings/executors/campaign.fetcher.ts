import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';

@Injectable()
export class CampaignFetcher {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async fetchCampaignBasicisById(campaign_id: string) {
    try {
      return await this.dataBaseService.campaign.findUnique({
        where: { id: campaign_id },
        select: {
          id: true,
          name: true,
          ownerId: true,
          players: {
            select: {
              playerId: true,
            },
          },
        },
      });
    } catch (error) {
      throw error;
    }
  }
}
