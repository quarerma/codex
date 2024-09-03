import { Module } from '@nestjs/common';
import { InventoryService } from './inventory.service';
import { InventoryController } from './inventory.controller';
import { DataBaseService } from 'src/database/database.service';
import { WeapondAddService } from './aux-services/weapond-add-service';
import { CharacterUpgradesService } from 'src/character/aux_services/character.upgrades.service';
import { CharacterAtributesService } from 'src/character/aux_services/character.atributes.service';
import { CharacterUnUpgradesService } from 'src/character/aux_services/character.unupgrade.service';

@Module({
  controllers: [InventoryController],
  providers: [InventoryService, DataBaseService, WeapondAddService, CharacterUpgradesService, CharacterAtributesService, CharacterUnUpgradesService],
})
export class InventoryModule {}
