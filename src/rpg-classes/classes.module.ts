import { Module } from '@nestjs/common';
import { ClassesService } from './classes.service';
import { ClassesController } from './classes.controller';
import { DataBaseService } from 'src/database/database.service';

@Module({
  controllers: [ClassesController],
  providers: [ClassesService, DataBaseService],
})
export class ClassesModule {}
