import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { EquipmentService } from './equipment.service';
import { CreateItemDto } from './dto/create.equipment.dto';

@Controller('equipment')
export class EquipmentController {
  constructor(private readonly equipmentService: EquipmentService) {}

  @Post()
  async createEquipment(@Body() data: CreateItemDto) {
    try {
      console.log(data);
      return this.equipmentService.createEquipment(data);
    } catch (error) {
      throw new Error(error);
    }
  }

  @Get('/campaign-items/:id')
  async getCampaignItems(@Param('id') id: string) {
    try {
      return this.equipmentService.getPossibleEquipmentsForCampaign(id);
    } catch (error) {
      throw new Error(error);
    }
  }
}
