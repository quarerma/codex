import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateRitualDto } from 'src/ritual/dto/create.ritual';

@Injectable()
export class CustomRitualService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createCustomRitual(campaignId: string, data: CreateRitualDto) {
    try {
      const ritual = await this.dataBaseService.campaignRitual.create({
        data: {
          campaign: {
            connect: { id: campaignId },
          },
          ritual: {
            create: {
              name: data.name,
              normalCastDescription: data.normalCastDescription,
              discentCastDescription: data.discentCastDescription,
              trueCastDescription: data.trueCastDescription,
              exectutionTime: data.exectutionTime,
              range: data.range,
              target: data.target,
              duration: data.duration,
              element: data.element,
              is_custom: true,
              type: data.type,
            },
          },
        },
      });

      if (data.type === 'DAMAGE') {
        await this.dataBaseService.damageRitual.create({
          data: {
            ritual: {
              connect: { id: ritual.id },
            },
            normalCastDamageType: data.normalCastDamageType,
            discentCastDamageType: data.discentCastDamageType,
            trueCastDamageType: data.trueCastDamageType,
            normalCastDamage: data.normalCastDamage,
            discentCastDamage: data.discentCastDamage,
            trueCastDamage: data.trueCastDamage,
          },
        });
      }
    } catch (error) {
      throw new Error('Error creating custom ritual');
    }
  }

  async getCampaignCustomRituals(campaignId: string) {
    try {
      return await this.dataBaseService.campaign.findUnique({
        where: { id: campaignId },
        select: {
          customRituals: {
            select: {
              ritual: true,
            },
          },
        },
      });
    } catch (error) {
      throw new Error('Error getting custom rituals');
    }
  }

  async deleteCustomRitual(ritualId: string, campaignId: string) {
    try {
      const campaignCharacters = await this.dataBaseService.campaign.findUnique({
        where: { id: campaignId },
        select: {
          characters: true,
        },
      });

      for (const character of campaignCharacters.characters) {
        await this.dataBaseService.characterRitual.delete({
          where: {
            characterId_ritualId: {
              characterId: character.id,
              ritualId,
            },
          },
        });
      }
      await this.dataBaseService.campaignRitual.delete({
        where: {
          campaignId_ritualId: {
            campaignId,
            ritualId,
          },
        },
      });

      await this.dataBaseService.ritual.delete({
        where: { id: ritualId },
      });
    } catch (error) {
      throw new Error('Error deleting custom ritual');
    }
  }
}