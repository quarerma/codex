import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateItemDto } from 'src/equipment/dto/create.equipment.dto';
import { EquipmentService } from 'src/equipment/equipment.service';

@Injectable()
export class CustomItemService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly equipmentService: EquipmentService,
  ) {}

  async createCustomCampaignItem(data: CreateItemDto, campaignId: string) {
    try {
      const equipment = await this.equipmentService.createEquipment(data);

      return await this.dataBaseService.campaignEquipment.create({
        data: {
          campaign: {
            connect: { id: campaignId },
          },
          equipment: {
            connect: { id: equipment.id },
          },
        },
      });
    } catch (error) {
      throw new Error('Error creating equipment');
    }
  }

  async getCampaignCustomItems(campaignId: string) {
    try {
      return await this.dataBaseService.campaign.findUnique({
        where: { id: campaignId },
        select: {
          customEquipment: {
            select: {
              equipment: true,
            },
          },
        },
      });
    } catch (error) {
      throw new Error('Error getting custom items');
    }
  }
}
