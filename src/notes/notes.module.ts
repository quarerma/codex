import { Module } from '@nestjs/common';
import { NotesService } from './notes.service';
import { NotesController } from './notes.controller';
import { DataBaseService } from 'src/database/database.service';

@Module({
  controllers: [NotesController],
  providers: [NotesService, DataBaseService],
})
export class NotesModule {}
