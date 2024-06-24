import { Atribute } from '@prisma/client';
import { JsonObject } from '@prisma/client/runtime/library';
import { Max, MaxLength, Min } from 'class-validator';

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

export type AtributesJson = {
  strenght: number;
  dexterity: number;
  vitality: number;
  intelligence: number;
  presence: number;
  alterations: AlterationObject[];
};

export type AlterationObject = {
  modificartionName?: string;
  modification?: string;
  featName?: string;
  feat?: string;
};

export type StatusJson = {
  currentValue: number;
  maxValue: number;
  valuePerLevel: number;
  alterations: AlterationObject[];
};

export type updateAtributeDTO = {
  characterId: string;
  atribute: Atribute;
  value: number;
};
