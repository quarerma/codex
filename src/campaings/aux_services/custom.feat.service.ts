import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateFeatDto } from 'src/feats/dto/create-feat-dto';

@Injectable()
export class CustomFeatService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createCustomFeat(data: CreateFeatDto, campaignId: string) {
    try {
      return await this.dataBaseService.campaign.update({
        where: { id: campaignId },
        data: {
          customFeat: {
            create: {
              name: data.name,
              description: data.description,
              prerequisites: data.prerequisites,
              characterUpgrades: data.characterUpgrade,
              type: 'CUSTOM',
              element: data.element,
            },
          },
        },
      });
    } catch (error) {
      throw new Error('Error creating custom feat');
    }
  }

  async getCampaignCustomFeats(campaignId: string) {
    try {
      return await this.dataBaseService.campaign.findUnique({
        where: { id: campaignId },
        select: {
          customFeat: true,
        },
      });
    } catch (error) {
      throw new Error('Error getting custom feats');
    }
  }
}
