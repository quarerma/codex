import { Injectable } from '@nestjs/common';
import { Character } from '@prisma/client';
import { DataBaseService } from 'src/database/database.service';
import { CharacterUpgradesService } from './character.upgrades.service';
import { CharacterUnUpgradesService } from './character.unupgrade.service';
import { CharacterUpgrade } from 'src/types/characterUpgrade-type';
import { StatusJson } from '../dto/create-character-dto';

@Injectable()
export class CharacterLevelService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly upgradeService: CharacterUpgradesService,
    private readonly unUpgradeService: CharacterUnUpgradesService,
  ) {}

  async updateCharacterLevel(characterId: string, newLevel: number) {
    try {
      const character = await this.dataBaseService.character.findUnique({
        where: { id: characterId },
        include: {
          class: true,
        },
      });

      if (!character) {
        throw new Error('Character not found');
      }

      if (newLevel > character.level) {
        await this.levelUp(character, newLevel);
      } else if (newLevel < character.level) {
        await this.levelDown(character, newLevel);
      }

      return await this.updateStats(characterId, newLevel);
    } catch (error) {
      throw error;
    }
  }

  async levelUp(character: Character, newLevel: number) {
    try {
      const subclassFeatsToApply = await this.dataBaseService.subclassFeats.findMany({
        where: {
          AND: [
            {
              subclassId: character.subclassId,
              levelRequired: { gt: character.level, lte: newLevel },
              feat: { afinityUpgrades: { isEmpty: false } },
            },
          ],
        },
        select: {
          feat: true,
        },
      });

      for (const feat of subclassFeatsToApply) {
        for (const upgrade of feat.feat.characterUpgrades) {
          await this.upgradeService.applyUpgrade(character.id, upgrade as CharacterUpgrade, feat.feat, 'feat');
        }
      }
    } catch (error) {
      throw error;
    }
  }

  async levelDown(characterId: Character, newLevel: number) {
    try {
      const subclassFeatsToUnapply = await this.dataBaseService.subclassFeats.findMany({
        where: {
          AND: [
            {
              subclassId: characterId.subclassId,
              levelRequired: { gt: newLevel, lte: characterId.level },
              feat: { afinityUpgrades: { isEmpty: false } },
            },
          ],
        },
        select: {
          feat: true,
        },
      });

      for (const feat of subclassFeatsToUnapply) {
        for (const upgrade of feat.feat.characterUpgrades) {
          await this.unUpgradeService.unApplyUpgrades(characterId.id, upgrade as CharacterUpgrade, feat.feat, 'feat');
        }
      }
    } catch (error) {
      throw error;
    }
  }

  async updateStats(characterId: string, newLevel: number) {
    try {
      const character = await this.dataBaseService.character.findUnique({
        where: { id: characterId },
        include: {
          class: true,
        },
      });

      const healthInfo = character.healthInfo as StatusJson;
      const effortInfo = character.effortInfo as StatusJson;
      const sanityInfo = character.sanityInfo as StatusJson;

      console.log(healthInfo, effortInfo, sanityInfo);

      return await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          max_health: healthInfo.valuePerLevel * (newLevel - 1) + (character.class.initialHealth + character.atributes['vitality']),
          max_effort: effortInfo.valuePerLevel * (newLevel - 1) + (character.class.initialEffort + character.atributes['presence']),
          max_sanity: sanityInfo.valuePerLevel * (newLevel - 1) + character.class.initialSanity,
          current_health: {
            increment: healthInfo.valuePerLevel * (newLevel - character.level),
          },
          current_effort: {
            increment: effortInfo.valuePerLevel * (newLevel - character.level),
          },
          current_sanity: {
            increment: sanityInfo.valuePerLevel * (newLevel - character.level),
          },

          level: newLevel,
        },
      });
    } catch (error) {
      throw error;
    }
  }
}
