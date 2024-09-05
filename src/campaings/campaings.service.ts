import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateCampaignDTO } from './dto/create-campaign-dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class CampaingsService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createCampaign(data: CreateCampaignDTO, ownerId: string) {
    try {
      // console.log('data', data, ownerId);
      const { password, ...campaignWithoutPassword } = data;
      const hashPassword = await this.hashPassword(password);

      console.log(data, ownerId);
      return await this.dataBaseService.campaign.create({
        data: {
          name: campaignWithoutPassword.name,
          description: campaignWithoutPassword.description,
          password: hashPassword,
          owner: {
            connect: { id: ownerId },
          },
        },
        select: {
          id: true,
          name: true,
          description: true,
          createdAt: true,
          owner: {
            select: {
              id: true,
              username: true,
            },
          },
        },
      });
    } catch (error) {
      throw new Error('Error creating campaign');
    }
  }

  async hashPassword(password: string) {
    const saltOrRounds = await bcrypt.genSalt();
    const hash = await bcrypt.hash(password, saltOrRounds);

    return hash;
  }

  async joinCampaign(data: { campaignId: string; password: string }, userId: string) {
    try {
      const campaign = await this.dataBaseService.campaign.findUnique({
        where: { id: data.campaignId },
        select: {
          id: true,
          password: true,
        },
      });

      if (campaign.password) {
        const isPasswordCorrect = await bcrypt.compare(data.password, campaign.password);

        if (!isPasswordCorrect) {
          throw new Error('Incorrect password');
        }
      }

      return await this.dataBaseService.playerOnCampaign.create({
        data: {
          player: { connect: { id: userId } },
          campaign: { connect: { id: data.campaignId } },
        },
      });
    } catch (error) {
      throw new Error('Error joining campaign');
    }
  }
}
