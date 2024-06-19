import { Module } from '@nestjs/common';
import { CharacterService } from './character.service';
import { CharacterController } from './character.controller';
import { DataBaseService } from 'src/database/database.service';

@Module({
  controllers: [CharacterController],
  providers: [CharacterService, DataBaseService],
})
export class CharacterModule {}
