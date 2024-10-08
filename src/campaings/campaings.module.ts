import { Module } from '@nestjs/common';
import { CampaingsService } from './campaings.service';
import { CampaingsController } from './campaings.controller';
import { DataBaseService } from 'src/database/database.service';
import { CustomItemService } from './aux_services/custom.item.service';
import { EquipmentService } from 'src/equipment/equipment.service';
import { SkillService } from 'src/skill/skill.service';
import { CustomRitualService } from './aux_services/custom.ritual.service';
import { CustomFeatService } from './aux_services/custom.feat.service';
import { CustomSkillService } from './aux_services/custom.skill.service';

@Module({
  controllers: [CampaingsController],
  providers: [CampaingsService, DataBaseService, CustomItemService, EquipmentService, SkillService, CustomRitualService, CustomFeatService, CustomSkillService],
})
export class CampaingsModule {}
