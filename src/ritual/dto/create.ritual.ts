import { DamageType, Element, Range, RitualType } from '@prisma/client';

export type CreateRitualDto = {
  name: string;

  normalCost: number;
  ritualLevel: number;
  exectutionTime: string;
  range: Range;
  target: string;
  duration: string;
  element: Element;
  resistance: string;
  is_custom: boolean;
  type: RitualType;

  normalCastDescription: string;
  discentCastDescription?: string;
  discentCost?: number;
  trueCastDescription?: string;
  trueCost?: number;
  conditions: string[];

  // DamageRitual attributes
  normalCastDamageType?: DamageType;
  discentCastDamageType?: DamageType;
  trueCastDamageType?: DamageType;

  normalCastDamage?: string;
  discentCastDamage?: string;
  trueCastDamage?: string;
};
