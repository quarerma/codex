import { Atribute } from '@prisma/client';
import { JsonObject } from '@prisma/client/runtime/library';
import { Max, MaxLength, Min } from 'class-validator';
import { TrainingLevel } from 'src/types/skill-relates-types';

export class CreateCharacterDTO {
  @MaxLength(50, {
    message: 'Name is too long',
  })
  name: string;

  @Min(1, {
    message: 'Level is too low',
  })
  @Max(100, {
    message: 'Level is too high',
  })
  level: number;

  ownerId: string;
  campaignId: string;
  classId: string;
  subClassId: string;

  strenght: number;
  dexterity: number;
  vitality: number;
  intelligence: number;
  presence: number;

  itens: JsonObject;
  ritualsId: string[];

  featsId: string[];
  originId: string;
}

export class AtributesJson {
  strenght: number;
  dexterity: number;
  vitality: number;
  intelligence: number;
  presence: number;
  alterations: string[];
}

export class SkillJson {
  name: string;
  atribute: Atribute;
  trainingLevel: TrainingLevel;
  alterations: SkillAlterationObject[];
}

export type SkillAlterationObject = {
  value: number;
  modification?: string;
  feat?: string;
};

export type AtributeAlterationObject = {
  modification?: string;
  feat?: string;
};
