import { Module } from '@nestjs/common';
import { SubClassController } from './rpg-subclass.controller';
import { SubClassService } from './rpg-subclass.service';
import { DataBaseService } from 'src/database/database.service';

@Module({
  controllers: [SubClassController],
  providers: [SubClassService, DataBaseService],
})
export class SubClassModule {}
