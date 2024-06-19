import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateCharacterDTO } from './dto/create-character-dto';

@Injectable()
export class CharacterService {
  constructor(private readonly dataBaseService: DataBaseService) {}

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
      };

      const healthInfo = {
        // prettier-ignore
        currentValue: characterClass.initialHealth + data.vitality + (data.level - 1) * characterClass.hitPointsPerLevel,
        // prettier-ignore
        maxValue: characterClass.initialHealth + data.vitality + (data.level - 1) * characterClass.hitPointsPerLevel,
        valuePerLevel: characterClass.hitPointsPerLevel,
        alterations: [],
      };

      const effortInfo = {
        // prettier-ignore
        currentValue: characterClass.initialEffort + data.presence + (data.level - 1) * characterClass.effortPointsPerLevel,
        // prettier-ignore
        maxValue: characterClass.initialEffort + data.presence + (data.level - 1) * characterClass.effortPointsPerLevel,
        valuePerLevel: characterClass.effortPointsPerLevel,
        alterations: [],
      };

      const sanityInfo = {
        // prettier-ignore
        currentValue: characterClass.initialSanity +  (data.level - 1) * characterClass.SanityPointsPerLevel,
        // prettier-ignore
        maxValue: characterClass.initialSanity+ (data.level - 1) * characterClass.SanityPointsPerLevel,
        valuePerLevel: characterClass.SanityPointsPerLevel,
        alterations: [],
      };

      const createdCharacter = await this.dataBaseService.character.create({
        data: {
          name: data.name,
          level: data.level,
          atributes: atributes,
          healthInfo: healthInfo,
          effortInfo: effortInfo,
          sanityInfo: sanityInfo,

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
        },
      });

      const carryInfo = {
        // prettier-ignore
        currentValue: data.strenght > 0 ? data.strenght * 5 : 2,
        // prettier-ignore
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

  async getItem(id: number, type: string) {
    try {
      let item;
      switch (type) {
        case 'DEFAULT':
        case 'EXPLOSIVE':
        case 'OPERATIONAL_EQUIPMENT':
        case 'PARANORMAL_EQUIPMENT':
          item = await this.dataBaseService.equipment.findUnique({
            where: { id },
          });
          break;

        case 'WEAPON':
          item = this.dataBaseService.equipment.findUnique({
            where: { id },
            include: {
              Weapon: true,
            },
          });
          break;
        case 'ARMOR':
          item = this.dataBaseService.equipment.findUnique({
            where: { id },
            include: {
              Armor: true,
            },
          });
          break;
        case 'ACESSORY':
          item = this.dataBaseService.equipment.findUnique({
            where: { id },
            include: {
              Accessory: true,
            },
          });
          break;
        case 'CURSED_ITEM':
          item = this.dataBaseService.equipment.findUnique({
            where: { id },
            include: {
              CursedItem: true,
            },
          });
          break;

        default:
          throw new Error('Invalid type');
      }

      return item;
    } catch (error) {
      throw new Error('Error to get item');
    }
  }
}
