import { Atribute } from '@prisma/client';

export type TrainingLevel = 'none' | 'trained' | 'veteran' | 'expert';

export type SkillJson = {
  name: string;
  atribute: Atribute;
  value: number;
  trainingLevel: TrainingLevel;
  alterations: SkillAlterationObject[];
};

export type SkillAlterationObject = {
  value: number;
  modificationName?: string;
  modification?: string;
  featName?: string;
  feat?: string;
  itemName?: string;
  item?: number;
  otherName?: string;
};
