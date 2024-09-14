import { DamageType, Element, Range, RitualType } from '@prisma/client';

export type CreateRitualDto = {
  name: string;
  normalCastDescription: string;
  normalCost: number;
  discentCastDescription?: string;
  discentCost?: number;
  trueCastDescription?: string;
  trueCost?: number;
  ritualLevel: number;
  exectutionTime: string;
  range: Range;
  target: string;
  duration: string;
  element: Element;
  is_custom: boolean;
  type: RitualType;
  conditions: string[];

  // DamageRitual attributes
  normalCastDamageType?: DamageType[];
  discentCastDamageType?: DamageType[];
  trueCastDamageType?: DamageType[];

  normalCastDamage?: string[];
  discentCastDamage?: string[];
  trueCastDamage?: string[];
};
