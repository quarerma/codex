import { Module } from '@nestjs/common';
import { InventoryService } from './inventory.service';
import { InventoryController } from './inventory.controller';
import { DataBaseService } from 'src/database/database.service';

@Module({
  controllers: [InventoryController],
  providers: [InventoryService, DataBaseService],
})
export class InventoryModule {}
