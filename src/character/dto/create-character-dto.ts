import { Atribute, Patent } from '@prisma/client';
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
  patent: Patent;

  ownerId: string;
  campaignId: string;
  classId: string;
  subclassId: string;

  strength: number;
  dexterity: number;
  vitality: number;
  intelligence: number;
  presence: number;

  ritualsIds: string[];

  featsId: string[];
  originId: string;
}

export type AtributesJson = {
  strength: number;
  dexterity: number;
  vitality: number;
  intelligence: number;
  presence: number;
  alterations: AlterationObject[];
};

export type AlterationObject = {
  item?: number;
  itemName?: string;
  modificationName?: string;
  modification?: string;
  featName?: string;
  feat?: string;
};

export type StatusJson = {
  valuePerLevel: number;
  alterations: AlterationObject[];
};

export type updateAtributeDTO = {
  characterId: string;
  atribute: Atribute;
  value: number;
};
