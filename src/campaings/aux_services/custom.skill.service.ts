import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateSkillDTO } from 'src/skill/dto/create.skill.dto';
import { SkillService } from 'src/skill/skill.service';
import { SkillJson } from 'src/types/skill-relates-types';

@Injectable()
export class CustomSkillService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly skillService: SkillService,
  ) {}

  async createCustomSkill(data: CreateSkillDTO, campaignId: string) {
    try {
      const skill = await this.skillService.createSkill(data);

      return await this.dataBaseService.campaign.update({
        where: { id: campaignId },
        data: {
          customSkills: {
            connect: { name: skill.name },
          },
        },
      });
    } catch (error) {
      throw new Error('Error creating skill');
    }
  }

  async getCampaignCustomSkills(campaignId: string) {
    try {
      return await this.dataBaseService.campaign.findUnique({
        where: { id: campaignId },
        select: {
          customSkills: true,
        },
      });
    } catch (error) {
      throw new Error('Error getting custom skills');
    }
  }

  async deleteCustomSkill(skillName: string, campaignId: string) {
    try {
      const campaignCharacters = await this.dataBaseService.campaign.findUnique({
        where: { id: campaignId },
        select: {
          characters: true,
        },
      });

      const characters = campaignCharacters.characters;

      for (const character of characters) {
        const characterSkills = this.removeCustomSkillFromCharacter(skillName, character.skills as SkillJson[]);

        await this.dataBaseService.character.update({
          where: { id: character.id },
          data: {
            skills: {
              set: characterSkills,
            },
          },
        });
      }

      await this.dataBaseService.campaign.update({
        where: { id: campaignId },
        data: {
          customSkills: {
            disconnect: { name: skillName },
          },
        },
      });

      await this.dataBaseService.skill.delete({
        where: { name: skillName },
      });
      return;
    } catch (error) {
      throw new Error('Error removing skill and updating characters');
    }
  }

  removeCustomSkillFromCharacter(skillName: string, characterSkills: SkillJson[]) {
    return characterSkills.filter((skill) => skill.name !== skillName);
  }
}
