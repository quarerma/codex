import { Module } from '@nestjs/common';
import { CharacterService } from './character.service';
import { CharacterController } from './character.controller';
import { DataBaseService } from 'src/database/database.service';
import { SkillService } from 'src/skill/skill.service';
import { CharacterSkillsService } from './aux_services/character.skills.service';
import { CharacterAttacksService } from './aux_services/character.attacks.service';
import { CharacterUpgradesService } from './aux_services/character.upgrades';
import { CharacterClassService } from './aux_services/character.class.service';
import { CharacterFeatsService } from './aux_services/character.feats';
import { InventoryService } from 'src/inventory/inventory.service';

@Module({
  controllers: [CharacterController],
  providers: [CharacterService, DataBaseService, SkillService, CharacterSkillsService, CharacterAttacksService, CharacterUpgradesService, CharacterClassService, CharacterFeatsService, InventoryService],
})
export class CharacterModule {}
