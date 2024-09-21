import { Module } from '@nestjs/common';
import { CharacterService } from './character.service';
import { CharacterController } from './character.controller';
import { DataBaseService } from 'src/database/database.service';
import { SkillService } from 'src/skill/skill.service';
import { CharacterSkillsService } from './aux_services/character.skills.service';
import { CharacterAttacksService } from './aux_services/character.attacks.service';
import { CharacterUpgradesService } from './aux_services/character.upgrades.service';
import { CharacterClassService } from './aux_services/character.class.service';
import { CharacterFeatsService } from './aux_services/character.feats.service';
import { InventoryService } from 'src/inventory/inventory.service';
import { CharacterAtributesService } from './aux_services/character.atributes.service';
import { WeapondAddService } from 'src/inventory/aux-services/weapond-add-service';
import { CharacterUnUpgradesService } from './aux_services/character.unupgrade.service';
import { CharacterRitualsService } from './aux_services/character.rituals.service';

@Module({
  controllers: [CharacterController],
  providers: [CharacterService, CharacterRitualsService, DataBaseService, WeapondAddService, SkillService, CharacterSkillsService, CharacterAttacksService, CharacterAtributesService, CharacterUpgradesService, CharacterClassService, CharacterFeatsService, InventoryService, CharacterUnUpgradesService],
})
export class CharacterModule {}
