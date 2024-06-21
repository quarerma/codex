import { Module } from '@nestjs/common';
import { CharacterService } from './character.service';
import { CharacterController } from './character.controller';
import { DataBaseService } from 'src/database/database.service';
import { SkillService } from 'src/skill/skill.service';
import { CharacterSkillsService } from './aux_services/character.skills.service';

@Module({
  controllers: [CharacterController],
  providers: [CharacterService, DataBaseService, SkillService, CharacterSkillsService],
})
export class CharacterModule {}
