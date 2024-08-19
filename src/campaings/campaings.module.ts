import { Module } from '@nestjs/common';
import { CampaingsService } from './campaings.service';
import { CampaingsController } from './campaings.controller';
import { DataBaseService } from 'src/database/database.service';
import { CustomItemService } from './aux_services/custom.item.service';
import { EquipmentService } from 'src/equipment/equipment.service';
import { SkillService } from 'src/skill/skill.service';
import { CustomRitualService } from './aux_services/custom.ritual.service';

@Module({
  controllers: [CampaingsController],
  providers: [CampaingsService, DataBaseService, CustomItemService, EquipmentService, SkillService, CustomRitualService],
})
export class CampaingsModule {}
