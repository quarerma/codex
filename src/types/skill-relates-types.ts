import { Atribute } from '@prisma/client';

export type TrainingLevel = 'none' | 'trained' | 'veteran' | 'expert';

export type SkillJson = {
  name: string;
  atribute: Atribute;
  trainingLevel: TrainingLevel;
  alterations: SkillAlterationObject[];
};

export type SkillAlterationObject = {
  value: number;
  modification?: string;
  feat?: string;
};
