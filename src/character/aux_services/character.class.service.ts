import { Injectable } from '@nestjs/common';
import { Character, Class, Subclass } from '@prisma/client';
import { DataBaseService } from 'src/database/database.service';
import { CharacterFeatsService } from './character.feats.service';
import { CharacterUpgradesService } from './character.upgrades.service';
import { CharacterUpgrade } from 'src/types/characterUpgrade-type';

@Injectable()
export class CharacterClassService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly characterFeatsService: CharacterFeatsService,
    private readonly upgradesService: CharacterUpgradesService,
  ) {}

  async assignInitialClassAtributes(character_class: Class, character: Character, num_of_origin_skills: number) {
    try {
      await this.dataBaseService.character.update({
        where: { id: character.id },
        data: {
          num_of_skills: character_class.number_of_skills + num_of_origin_skills,
        },
      });

      const classFeats_id = await this.dataBaseService.classFeats.findMany({
        where: {
          AND: [{ classId: character_class.id }, { feat: { afinityUpgrades: { isEmpty: false } } }],
        },
        select: {
          feat: true,
        },
      });

      for (const feat of classFeats_id) {
        for (const upgrade of feat.feat.characterUpgrades) {
          await this.upgradesService.applyUpgrade(character.id, upgrade as CharacterUpgrade, feat.feat, 'feat');
        }
      }
    } catch (error) {
      throw new Error(error.message);
    }
  }

  async applySubclassFeats(character_subclass: Subclass, character: Character) {
    try {
      const subclassFeats = await this.dataBaseService.subclassFeats.findMany({
        where: {
          AND: [{ subclassId: character_subclass.id }, { feat: { afinityUpgrades: { isEmpty: false } } }, { levelRequired: { lte: character.level } }],
        },
        select: {
          feat: true,
        },
      });

      for (const feat of subclassFeats) {
        for (const upgrade of feat.feat.characterUpgrades) {
          await this.upgradesService.applyUpgrade(character.id, upgrade as CharacterUpgrade, feat.feat, 'feat');
        }
      }
    } catch (error) {
      throw new Error(error.message);
    }
  }
}
