import { Controller, Patch, Query } from '@nestjs/common';

import { CharacterSkillsService } from './aux_services/character.skills.service';
import { TrainingLevel } from 'src/types/skill-relates-types';

@Controller('character')
export class CharacterskillsController {
  constructor(private readonly customSkillService: CharacterSkillsService) {}

  @Patch('edit-skill-training-level')
  async editSkillTrainingLevel(@Query('characterId') characterId: string, @Query('skillId') skillName: string, @Query('traininglevel') trainingLevel: string) {
    try {
      return await this.customSkillService.editCharacterSkillTraining(characterId, skillName, trainingLevel as TrainingLevel);
    } catch (error) {
      throw new Error('Error editing skill training level');
    }
  }
}
