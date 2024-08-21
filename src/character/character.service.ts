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

      const currentHealth = characterClass.initialHealth + data.vitality + (data.level - 1) * characterClass.hitPointsPerLevel;
      const maxHealth = characterClass.initialHealth + data.vitality + (data.level - 1) * characterClass.hitPointsPerLevel;
      const healthInfo = {
        valuePerLevel: characterClass.hitPointsPerLevel,
        alterations: [],
      } as StatusJson;

      const currentEffort = characterClass.initialEffort + data.presence + (data.level - 1) * characterClass.effortPointsPerLevel;
      const maxEffort = characterClass.initialEffort + data.presence + (data.level - 1) * characterClass.effortPointsPerLevel;

      const effortInfo = {
        valuePerLevel: characterClass.effortPointsPerLevel,
        alterations: [],
      } as StatusJson;

      const currentSanity = characterClass.initialSanity + (data.level - 1) * characterClass.SanityPointsPerLevel;
      const maxSanity = characterClass.initialSanity + (data.level - 1) * characterClass.SanityPointsPerLevel;

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

          current_effort: currentEffort,
          max_effort: maxEffort,
          current_health: currentHealth,
          max_health: maxHealth,
          current_sanity: currentSanity,
          max_sanity: maxSanity,

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
            create: data.ritualsId.map((ritualId) => ({
              ritual: {
                connect: { id: ritualId },
              },
            })),
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
          maxValue: carryInfo.maxValue,
          currentValue: carryInfo.currentValue,
          alterations: carryInfo.alterations,
        },
      });

      return createdCharacter;
    } catch (error) {}
  }

  async getCharacter(characterId: string) {
    try {
      return await this.dataBaseService.character.findUnique({
        where: { id: characterId },
      });
    } catch (error) {
      throw new Error('Error getting character');
    }
  }

  async deleteCharacter(characterId: string) {
    try {
      await this.dataBaseService.character.delete({
        where: { id: characterId },
      });

      // delete all character inventory
      await this.dataBaseService.inventory.delete({
        where: { characterId },
      });

      // delete all inventory slots
      await this.dataBaseService.inventorySlot.deleteMany({
        where: { inventory: { characterId } },
      });
    } catch (error) {
      throw new Error('Error deleting character');
    }
  }
}
