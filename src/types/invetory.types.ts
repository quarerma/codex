import { AlterationObject } from 'src/character/dto/create-character-dto';

export type carryInfo = {
  currentValue: number;
  maxValue: number;
  alterations: AlterationObject[];
};
