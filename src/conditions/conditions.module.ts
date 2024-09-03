import { Module } from '@nestjs/common';
import { ConditionsService } from './conditions.service';
import { ConditionsController } from './conditions.controller';
import { DataBaseService } from 'src/database/database.service';

@Module({
  controllers: [ConditionsController],
  providers: [ConditionsService, DataBaseService],
})
export class ConditionsModule {}
