import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import { EquipmentService } from './equipment.service';
import { CreateItemDto } from './dto/create.equipment.dto';

@Controller('equipment')
export class EquipmentController {
  constructor(private readonly equipmentService: EquipmentService) {}

  @Post()
  async createEquipment(@Body() data: CreateItemDto) {
    try {
      return await this.equipmentService.createEquipment(data);
    } catch (error) {
      throw new Error(`Error creating equipment: ${error.message}`);
    }
  }

  @Get('campaign-items')
  async getCampaignItems(@Query('campaignId') campaignId: string) {
    try {
      return await this.equipmentService.getPossibleEquipmentsForCampaign(campaignId);
    } catch (error) {
      throw new Error(`Error retrieving campaign items: ${error.message}`);
    }
  }
}
