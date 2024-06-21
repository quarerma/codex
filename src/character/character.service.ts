import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { AtributesJson, CreateCharacterDTO, StatusJson } from './dto/create-character-dto';
import { CharacterSkillsService } from './aux_services/character.skills.service';

@Injectable()
export class CharacterService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly characterSkillsService: CharacterSkillsService,
  ) {}

  async createCharacter(data: CreateCharacterDTO) {
    try {
      const characterClass = await this.dataBaseService.class.findUnique({
        where: { id: data.classId },
      });

      const atributes = {
        strenght: data.strenght,
        dexterity: data.dexterity,
        vitality: data.vitality,
        intelligence: data.intelligence,
        presence: data.presence,
        alterations: [],
      } as AtributesJson;

      const healthInfo = {
        currentValue: characterClass.initialHealth + data.vitality + (data.level - 1) * characterClass.hitPointsPerLevel,
        maxValue: characterClass.initialHealth + data.vitality + (data.level - 1) * characterClass.hitPointsPerLevel,
        valuePerLevel: characterClass.hitPointsPerLevel,
        alterations: [],
      } as StatusJson;

      const effortInfo = {
        currentValue: characterClass.initialEffort + data.presence + (data.level - 1) * characterClass.effortPointsPerLevel,
        maxValue: characterClass.initialEffort + data.presence + (data.level - 1) * characterClass.effortPointsPerLevel,
        valuePerLevel: characterClass.effortPointsPerLevel,
        alterations: [],
      } as StatusJson;

      const sanityInfo = {
        currentValue: characterClass.initialSanity + (data.level - 1) * characterClass.SanityPointsPerLevel,
        maxValue: characterClass.initialSanity + (data.level - 1) * characterClass.SanityPointsPerLevel,
        valuePerLevel: characterClass.SanityPointsPerLevel,
        alterations: [],
      } as StatusJson;

      const skills = await this.characterSkillsService.assignBasicSkills();

      const createdCharacter = await this.dataBaseService.character.create({
        data: {
          name: data.name,
          level: data.level,
          atributes: atributes,
          healthInfo: healthInfo,
          effortInfo: effortInfo,
          sanityInfo: sanityInfo,
          proficiencies: characterClass.proficiencies,
          owner: {
            connect: { id: data.ownerId },
          },

          campaign: {
            connect: { id: data.campaignId },
          },

          class: {
            connect: { id: data.classId },
          },

          subclass: {
            connect: { id: data.subClassId },
          },

          feats: {
            connect: data.featsId.map((id) => ({ id })),
          },

          rituals: {
            connect: data.ritualsId.map((id) => ({ id })),
          },
          origin: {
            connect: { id: data.originId },
          },
          skills,
        },
      });

      const carryInfo = {
        currentValue: data.strenght > 0 ? data.strenght * 5 : 2,
        maxValue: data.strenght > 0 ? data.strenght * 5 : 2,
        alterations: [],
      };

      // create inventory
      await this.dataBaseService.inventory.create({
        data: {
          character: {
            connect: { id: createdCharacter.id },
          },
          carryInfo: carryInfo,
        },
      });

      return createdCharacter;
    } catch (error) {}
  }
}
