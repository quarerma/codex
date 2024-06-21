import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { SkillService } from 'src/skill/skill.service';
import { SkillJson } from 'src/types/skill-relates-types';

@Injectable()
export class CharacterSkillsService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly skillService: SkillService,
  ) {}

  async assignBasicSkills() {
    const basicSkills = await this.skillService.getNonCustomSkills();

    const characterSkills = [];

    for (const skill of basicSkills) {
      const skillJson = {
        name: skill.name,
        atribute: skill.atribute,
        trainingLevel: 'none',
        alterations: [],
      } as SkillJson;
      characterSkills.push(skillJson);
    }

    return characterSkills;
  }
}
