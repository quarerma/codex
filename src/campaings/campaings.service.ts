import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
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

      if (!campaign) {
        throw new HttpException(
          {
            status: 'campaignError',
            message: 'Campaign not found',
          },
          HttpStatus.NOT_FOUND,
        );
      }

      // check if user is already in campaign
      const playerOnCampaign = await this.dataBaseService.playerOnCampaign.findFirst({
        where: {
          campaignId: data.campaignId,
          playerId: userId,
        },
      });

      if (playerOnCampaign) {
        throw new HttpException(
          {
            status: 'campaignError',
            message: 'You already ar on this campaign',
          },
          HttpStatus.CONFLICT,
        );
      }

      // check if is the owner of the campaign
      const isOwner = await this.dataBaseService.campaign.findFirst({
        where: {
          id: data.campaignId,
          ownerId: userId,
        },
      });

      if (isOwner) {
        throw new HttpException(
          {
            status: 'campaignError',
            message: 'You are the owner of this campaign',
          },
          HttpStatus.CONFLICT,
        );
      }

      if (campaign.password) {
        const isPasswordCorrect = await bcrypt.compare(data.password, campaign.password);

        if (!isPasswordCorrect) {
          throw new Error('Incorrect password');
        }
      }
      const joinObject = await this.dataBaseService.playerOnCampaign.create({
        data: {
          player: { connect: { id: userId } },
          campaign: { connect: { id: data.campaignId } },
        },
        select: {
          campaign: {
            select: {
              createdAt: true,
              id: true,
              name: true,
              description: true,
              owner: {
                select: {
                  id: true,
                  username: true,
                },
              },
            },
          },
        },
      });

      return joinObject.campaign;
    } catch (error) {
      throw error;
    }
  }

  async leaveCampaign(userId: string, campaignId: string) {
    // TODO delete character
    try {
      const participation = await this.dataBaseService.playerOnCampaign.findUnique({
        where: {
          campaignId_playerId: {
            campaignId: campaignId,
            playerId: userId,
          },
        },
      });

      if (!participation) {
        throw new Error('User is not in this campaign');
      }
      await this.dataBaseService.playerOnCampaign.delete({
        where: {
          campaignId_playerId: {
            campaignId: campaignId,
            playerId: userId,
          },
        },
      });
    } catch (error) {
      console.log('Error leaving the campaign:', error.message);
    }
  }
}
