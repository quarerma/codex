import { Controller, Param, Patch } from '@nestjs/common';

import { CharacterSkillsService } from './aux_services/character.skills.service';
import { TrainingLevel } from 'src/types/skill-relates-types';

@Controller('character')
export class CharacterskillsController {
  constructor(private readonly customSkillService: CharacterSkillsService) {}

  @Patch('edit-skill-training-level/:characterId/:skillName/:trainingLevel')
  async editSkillTrainingLevel(@Param('characterId') characterId: string, @Param('skillName') skillName: string, @Param('trainingLevel') trainingLevel: string) {
    try {
      return await this.customSkillService.editCharacterSkillTraining(characterId, skillName, trainingLevel as TrainingLevel);
    } catch (error) {
      throw new Error('Error editing skill training level');
    }
  }
}
