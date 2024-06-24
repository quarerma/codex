import { AlterationObject } from './create-character-dto';

export type Attack = {
  name: string;
  local_id: string;
  skill: string;
  roll_bonus: number;
  damaga_dies: string[];
  critical_margin: number;
  critical_multiplier: number;
  extra_damage: string[];
  alterations: AlterationObject[];
};
