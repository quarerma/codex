import { Injectable } from '@nestjs/common';
import { Atribute } from '@prisma/client';
import { DataBaseService } from 'src/database/database.service';
import { SkillService } from 'src/skill/skill.service';
import { SkillAlterationObject, SkillJson, TrainingLevel } from 'src/types/skill-relates-types';

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
        value: 0,
        alterations: [],
      } as SkillJson;
      characterSkills.push(skillJson);
    }

    return characterSkills;
  }

  async editCharacterSkillAtribute(characterId: string, skillName: string, atribute: Atribute) {
    try {
      const character = await this.dataBaseService.character.findUnique({
        where: { id: characterId },
        select: {
          skills: true,
        },
      });

      const skills = character.skills as SkillJson[];

      const skillIndex = skills.findIndex((skill) => skill.name === skillName);

      if (skillIndex === -1) {
        throw new Error('Skill not found');
      }

      skills[skillIndex].atribute = atribute;

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          skills: {
            set: skills,
          },
        },
      });
    } catch (error) {
      throw new Error('Error editing character skill atribute');
    }
  }

  async editCharacterSkillTraining(characterId: string, skillName: string, trainingLevel: TrainingLevel) {
    try {
      const character = await this.dataBaseService.character.findUnique({
        where: { id: characterId },
        select: {
          skills: true,
        },
      });

      const skills = character.skills as SkillJson[];

      const skillIndex = skills.findIndex((skill) => skill.name === skillName);

      if (skillIndex === -1) {
        throw new Error('Skill not found');
      }

      skills[skillIndex].trainingLevel = trainingLevel;

      switch (trainingLevel) {
        case 'none':
          skills[skillIndex].value = 0;
          break;
        case 'trained':
          skills[skillIndex].value = 5;
          break;
        case 'veteran':
          skills[skillIndex].value = 10;
          break;
        case 'expert':
          skills[skillIndex].value = 15;
          break;
        default:
          throw new Error('Invalid training level');
      }

      for (const alteration of skills[skillIndex].alterations) {
        skills[skillIndex].value += alteration.value;
      }

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          skills: {
            set: skills,
          },
        },
      });
    } catch (error) {
      throw new Error('Error editing character skill training');
    }
  }

  async addSkillAlteration(characterId: string, skillName: string, alteration: SkillAlterationObject) {
    try {
      const character = await this.dataBaseService.character.findUnique({
        where: { id: characterId },
        select: {
          skills: true,
        },
      });

      const skills = character.skills as SkillJson[];

      const skillIndex = skills.findIndex((skill) => skill.name === skillName);

      if (skillIndex === -1) {
        throw new Error('Skill not found');
      }

      skills[skillIndex].alterations.push(alteration);

      skills[skillIndex].value += alteration.value;

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          skills: {
            set: skills,
          },
        },
      });
    } catch (error) {
      throw new Error('Error adding skill alteration');
    }
  }
}
