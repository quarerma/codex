import { Module } from '@nestjs/common';
import { InventoryService } from './inventory.service';
import { InventoryController } from './inventory.controller';
import { DataBaseService } from 'src/database/database.service';
import { WeapondAddService } from './aux-services/weapond-add-service';

@Module({
  controllers: [InventoryController],
  providers: [InventoryService, DataBaseService, WeapondAddService],
})
export class InventoryModule {}