import { Module } from '@nestjs/common';
import { CampaingsService } from './campaings.service';
import { CampaingsController } from './campaings.controller';
import { DataBaseService } from 'src/database/database.service';
import { CustomItemService } from './aux_services/custom-item-service';
import { EquipmentService } from 'src/equipment/equipment.service';

@Module({
  controllers: [CampaingsController],
  providers: [CampaingsService, DataBaseService, CustomItemService, EquipmentService],
})
export class CampaingsModule {}
