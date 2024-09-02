import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CharacterUpgrade } from 'src/types/characterUpgrade-type';
import { CharacterUpgradesService } from './character.upgrades.service';

@Injectable()
export class CharacterFeatsService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly upgradesService: CharacterUpgradesService,
  ) {}

  async assignFeat(characterId: string, featId: string) {
    try {
      const createdFeat = await this.dataBaseService.characterFeat.create({
        data: {
          characterId,
          featId,
        },
        select: {
          feat: true,
          character: true,
        },
      });

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

  async useFeatAfinity(characterId: string, featId: string) {
    try {
      const feat = await this.dataBaseService.characterFeat.update({
        where: { characterId_featId: { characterId, featId } },
        data: {
          usingAfinity: true,
        },
        select: {
          feat: true,
        },
      });

      if (!feat || feat.feat.afinityUpgrades.length <= 0) {
        return;
      }

      for (const upgrade of feat.feat.afinityUpgrades as CharacterUpgrade[]) {
        await this.upgradesService.applyUpgrade(characterId, upgrade, feat.feat, 'feat');
      }
    } catch (error) {
      throw error;
    }
  }
}
