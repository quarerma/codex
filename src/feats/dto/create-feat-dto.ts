import { Element } from '@prisma/client';
import { CharacterUpgrade } from 'src/types/characterUpgrade-type';

export class CreateFeatDto {
  name: string;
  description: string;
  prerequisites?: string;
  characterUpgrade?: CharacterUpgrade[];
  element?: Element;
  afinity?: string;
  afinityUpgrades?: CharacterUpgrade[];
}
