import { Module } from '@nestjs/common';
import { RitualService } from './ritual.service';
import { RitualController } from './ritual.controller';
import { DataBaseService } from 'src/database/database.service';

@Module({
  controllers: [RitualController],
  providers: [RitualService, DataBaseService],
})
export class RitualModule {}
