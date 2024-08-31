import { CharacterUpgradeType } from 'src/character/dto/characterUpgrade';

export type CharacterUpgrade = {
  type: CharacterUpgradeType;
  upgradeTarget?: string | number;
  upgradeValue: number;
};
