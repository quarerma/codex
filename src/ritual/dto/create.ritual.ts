import { DamageType, Element, Range, RitualType } from '@prisma/client';

export type CreateRitualDto = {
  name: string;
  normalCastDescription: string;
  discentCastDescription: string;
  trueCastDescription: string;
  exectutionTime: string;
  range: Range;
  target: string;
  duration: string;
  element: Element;
  is_custom: boolean;
  type: RitualType;

  // DamageRitual attributes
  normalCastDamageType?: DamageType;
  discentCastDamageType?: DamageType;
  trueCastDamageType?: DamageType;

  normalCastDamage?: string;
  discentCastDamage?: string;
  trueCastDamage?: string;
};
