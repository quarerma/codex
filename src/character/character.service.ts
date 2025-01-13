import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { AtributesJson, CreateCharacterDTO, StatusJson } from './dto/create-character-dto';
import { CharacterSkillsService } from './aux_services/character.skills.service';
import { CharacterClassService } from './aux_services/character.class.service';
import { InventoryService } from 'src/inventory/inventory.service';
import { CharacterFeatsService } from './aux_services/character.feats.service';
import { Credit } from '@prisma/client';
import { CharacterRitualsService } from './aux_services/character.rituals.service';

@Injectable()
export class CharacterService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly characterSkillsService: CharacterSkillsService,
    private readonly characterClassService: CharacterClassService,
    private readonly inventoryService: InventoryService,
    private readonly characterFeatsService: CharacterFeatsService,
    private readonly characterRitualsService: CharacterRitualsService,
  ) {}

  async createCharacter(data: CreateCharacterDTO) {
    try {
      const characterClass = await this.dataBaseService.class.findUnique({
        where: { id: data.classId },
      });

      const atributes = {
        strength: data.strength,
        dexterity: data.dexterity,
        vitality: data.vitality,
        intelligence: data.intelligence,
        presence: data.presence,
        alterations: [],
      } as AtributesJson;

      const healthInfo = {
        valuePerLevel: characterClass.hitPointsPerLevel + data.vitality,
        alterations: [],
      } as StatusJson;
      const currentHealth = characterClass.initialHealth + data.vitality + (data.level - 1) * healthInfo.valuePerLevel;
      const maxHealth = characterClass.initialHealth + data.vitality + (data.level - 1) * healthInfo.valuePerLevel;

      const effortInfo = {
        valuePerLevel: characterClass.effortPointsPerLevel + data.presence,
        alterations: [],
      } as StatusJson;
      const currentEffort = characterClass.initialEffort + data.presence + (data.level - 1) * effortInfo.valuePerLevel;
      const maxEffort = characterClass.initialEffort + data.presence + (data.level - 1) * effortInfo.valuePerLevel;

      const currentSanity = characterClass.initialSanity + (data.level - 1) * characterClass.SanityPointsPerLevel;
      const maxSanity = characterClass.initialSanity + (data.level - 1) * characterClass.SanityPointsPerLevel;

      const sanityInfo = {
        currentValue: characterClass.initialSanity + (data.level - 1) * characterClass.SanityPointsPerLevel,
        maxValue: characterClass.initialSanity + (data.level - 1) * characterClass.SanityPointsPerLevel,
        valuePerLevel: characterClass.SanityPointsPerLevel,
        alterations: [],
      } as StatusJson;

      const skills = await this.characterSkillsService.assignBasicSkills(data.campaignId);

      const speed = 9;
      const defense = 10 + atributes.dexterity;

      const createdCharacter = await this.dataBaseService.character.create({
        data: {
          name: data.name,
          level: data.level,
          speed,
          defense,
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
            connect: { id: data.subclassId },
          },

          skills,
          origin: {
            connect: { id: data.originId },
          },
        },
        include: {
          class: true,
          subclass: true,
          origin: true,
        },
      });

      const carryInfo = {
        currentValue: 0,
        maxValue: data.strength > 0 ? data.strength * 5 : 2,
        alterations: [],
      };

      // create inventory
      let credit: Credit;

      switch (data.patent) {
        case 'ROOKIE':
          credit = 'LOW';
          break;
        case 'OPERATOR':
          credit = 'MEDIUM';
          break;
        case 'SPECIAL_AGENT':
          credit = 'MEDIUM';
          break;
        case 'OPERATION_OFFICER':
          credit = 'HIGH';
          break;
        case 'ELITE_AGENT':
          credit = 'UNLIMITED';
          break;
      }
      await this.dataBaseService.inventory.create({
        data: {
          character: {
            connect: { id: createdCharacter.id },
          },
          patent: data.patent,
          credit,
          maxValue: carryInfo.maxValue,
          currentValue: carryInfo.currentValue,
          alterations: carryInfo.alterations,
        },
      });

      // TODO: assign rituals
      await this.characterRitualsService.assignRitualsOnCreate(createdCharacter.id, data.ritualsIds);

      // TODO: assign origin on create

      for (const skill of createdCharacter.origin.skills) {
        await this.characterSkillsService.editCharacterSkillTraining(createdCharacter.id, skill, 'trained');
      }
      await this.characterFeatsService.assignFeat(createdCharacter.origin.featId, createdCharacter.id);

      // TODO: assign class, subclass and feats on create
      await this.characterClassService.assignInitialClassAtributes(createdCharacter.class, createdCharacter, createdCharacter.origin.skills.length);
      await this.characterClassService.assignInitialSubClassFeats(createdCharacter.subclass, createdCharacter);

      for (const featId of data.featsId) {
        await this.characterFeatsService.assignFeat(featId, createdCharacter.id);
      }

      return createdCharacter;
    } catch (error) {
      console.log(error);
      throw new Error('Error creating character');
    }
  }

  async getCharacter(characterId: string) {
    try {
      return await this.dataBaseService.character.findUnique({
        where: { id: characterId },
        include: {
          rituals: {
            select: {
              ritual: {
                include: {
                  damageRitual: true,
                  conditions: {
                    select: {
                      condition: {
                        select: {
                          id: true,
                          name: true,
                          description: true,
                        },
                      },
                    },
                  },
                },
              },
              ritual_cost: true,
            },
          },

          campaign: {
            select: {
              id: true,
              name: true,
              ownerId: true,
            },
          },
          class: {
            select: {
              name: true,
              id: true,
            },
          },
          subclass: {
            select: {
              name: true,
              id: true,
            },
          },
          owner: {
            select: {
              id: true,
              username: true,
            },
          },
          feats: {
            select: {
              feat: true,
              usingAfinity: true,
            },
            orderBy: {
              feat: {
                name: 'asc',
              },
            },
          },
          origin: {
            include: {
              feats: true,
            },
          },
        },
      });
    } catch (error) {
      throw new Error('Error getting character');
    }
  }

  async deleteCharacter(characterId: string) {
    try {
      //delete notes
      await this.dataBaseService.notes.deleteMany({
        where: { characterId },
      });

      // delete character feats
      await this.dataBaseService.characterFeat.deleteMany({
        where: { characterId },
      });

      // delete character rituals
      await this.dataBaseService.characterRitual.deleteMany({
        where: { characterId },
      });

      // delete all character inventory
      await this.dataBaseService.inventory.delete({
        where: { characterId },
      });

      // delete all inventory slots
      await this.dataBaseService.inventorySlot.deleteMany({
        where: { inventory: { characterId } },
      });

      // delete all character skills
      await this.dataBaseService.character.delete({
        where: { id: characterId },
      });
    } catch (error) {
      throw new Error('Error deleting character');
    }
  }

  async updateStat(characterId: string, stat: string, value: number) {
    try {
      switch (stat) {
        case 'HP':
          await this.dataBaseService.character.update({
            where: { id: characterId },
            data: {
              current_health: value,
            },
          });
          break;
        case 'PE':
          await this.dataBaseService.character.update({
            where: { id: characterId },
            data: {
              current_effort: value,
            },
          });
          break;
        case 'SAN':
          await this.dataBaseService.character.update({
            where: { id: characterId },
            data: {
              current_sanity: value,
            },
          });
          break;
      }
    } catch (error) {
      throw new Error('Error updating stat');
    }
  }
}
