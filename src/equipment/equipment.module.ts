import { Module } from '@nestjs/common';
import { EquipmentService } from './equipment.service';
import { EquipmentController } from './equipment.controller';
import { DataBaseService } from 'src/database/database.service';

@Module({
  controllers: [EquipmentController],
  providers: [EquipmentService, DataBaseService],
})
export class EquipmentModule {}
