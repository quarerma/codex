import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CharacterUpgrade } from 'src/types/characterUpgrade-type';
import { CharacterUpgradesService } from './character.upgrades.service';
import { CharacterUnUpgradesService } from './character.unupgrade.service';

@Injectable()
export class CharacterFeatsService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly upgradesService: CharacterUpgradesService,
    private readonly unUpgradeService: CharacterUnUpgradesService,
  ) {}

  async assignFeat(featId: string, characterId: string) {
    try {
      const createdFeat = await this.dataBaseService.characterFeat.create({
        data: {
          character: {
            connect: { id: characterId },
          },
          feat: {
            connect: { id: featId },
          },
        },
        select: {
          feat: true,
          character: true,
        },
      });

      console.log(createdFeat);
      // check if feat has upgrades
      const upgrades = createdFeat.feat.characterUpgrades as CharacterUpgrade[];

      if (upgrades.length <= 0) {
        return;
      }

      // apply upgrades
      for (const upgrade of upgrades) {
        await this.upgradesService.applyUpgrade(characterId, upgrade, createdFeat.feat, 'feat');
      }
    } catch (error) {
      throw error;
    }
  }

  async removeFeat(characterId: string, featId: string) {
    try {
      const deletedFeat = await this.dataBaseService.characterFeat.delete({
        where: { characterId_featId: { characterId, featId } },
        select: {
          feat: true,
          usingAfinity: true,
        },
      });

      if (!deletedFeat || deletedFeat.feat.characterUpgrades.length <= 0) {
        return;
      }

      if (deletedFeat.usingAfinity) {
        for (const upgrade of deletedFeat.feat.afinityUpgrades as CharacterUpgrade[]) {
          await this.unUpgradeService.unApplyUpgrades(characterId, upgrade, deletedFeat.feat, 'feat');
        }
      }

      for (const upgrade of deletedFeat.feat.characterUpgrades as CharacterUpgrade[]) {
        await this.unUpgradeService.unApplyUpgrades(characterId, upgrade, deletedFeat.feat, 'feat');
      }
    } catch (error) {
      console.log(error);
      throw error;
    }
  }

  async useFeatAfinity(characterId: string, featId: string) {
    try {
      console.log(featId, characterId);
      const feat = await this.dataBaseService.characterFeat.update({
        where: { characterId_featId: { characterId, featId } },
        data: {
          usingAfinity: true,
        },
        select: {
          feat: true,
        },
      });

      console.log(feat);
      if (!feat || feat.feat.afinityUpgrades.length <= 0) {
        return;
      }

      for (const upgrade of feat.feat.afinityUpgrades as CharacterUpgrade[]) {
        await this.upgradesService.applyUpgrade(characterId, upgrade, feat.feat, 'feat');
      }
    } catch (error) {
      console.log(error);
      throw error;
    }
  }

  async unCheckFeatAfinity(characterId: string, featId: string) {
    try {
      const feat = await this.dataBaseService.characterFeat.update({
        where: { characterId_featId: { characterId, featId } },
        data: {
          usingAfinity: false,
        },
        select: {
          feat: true,
        },
      });

      if (!feat || feat.feat.afinityUpgrades.length <= 0) {
        return;
      }

      for (const upgrade of feat.feat.afinityUpgrades as CharacterUpgrade[]) {
        await this.unUpgradeService.unApplyUpgrades(characterId, upgrade, feat.feat, 'feat');
      }
    } catch (error) {
      throw error;
    }
  }
}
