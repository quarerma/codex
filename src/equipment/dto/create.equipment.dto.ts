import { DamageType, Element, HandType, ItemType, Range, WeaponCategory, WeaponType } from '@prisma/client';
import { CharacterUpgrade } from 'src/types/characterUpgrade-type';

export class CreateItemDto {
  name: string;
  description: string;
  weight: number;
  category: number;
  type: ItemType;
  is_custom: boolean;
  num_of_uses: number;
  characterUpgrades: CharacterUpgrade[];
  // Weapon variables
  damage?: string;
  critical_range?: number;
  critical_multiplier?: number;
  range?: Range;
  damage_type?: DamageType;
  weapon_type?: WeaponType;
  weapon_category?: WeaponCategory;
  hand_type?: HandType;

  // Cursed Item variables
  element?: Element;
}
