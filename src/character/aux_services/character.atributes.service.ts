import { Injectable } from '@nestjs/common';
import { AtributesJson, StatusJson, updateAtributeDTO } from '../dto/create-character-dto';
import { DataBaseService } from 'src/database/database.service';
import { carryInfo } from 'src/types/invetory.types';

@Injectable()
export class CharacterAtributesService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async updateAtribute(characterId: string, atribute: updateAtributeDTO) {
    try {
      const character = await this.dataBaseService.character.findUnique({
        where: { id: characterId },
        select: {
          atributes: true,
        },
      });

      const atributes = character.atributes as AtributesJson;

      switch (atribute.atribute) {
        case 'STRENGTH':
          this.onStreghthUpdate(characterId, atribute.value);
          atributes.strenght = atribute.value;
          break;
        case 'DEXTERITY':
          atributes.dexterity = atribute.value;
          break;
        case 'VITALITY':
          this.onVitalityUpdate(characterId, atribute.value, atributes.vitality);
          atributes.vitality = atribute.value;
          break;
        case 'INTELLIGENCE':
          atributes.intelligence = atribute.value;
          break;
        case 'PRESENCE':
          this.onPresenceUpdate(characterId, atribute.value, atributes.presence);
          atributes.presence = atribute.value;
          break;
        default:
          throw new Error('Invalid atribute');
      }
      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          atributes: atributes,
        },
      });
    } catch (error) {
      throw error;
    }
  }

  async onStreghthUpdate(characterId: string, value: number) {
    try {
      const carry_weight = 5 * value;
      const inventory = await this.dataBaseService.inventory.findUnique({
        where: { characterId: characterId },
        select: {
          carryInfo: true,
        },
      });

      const carryInfo = inventory.carryInfo as carryInfo;

      carryInfo.maxValue = carry_weight;

      await this.dataBaseService.inventory.update({
        where: { characterId: characterId },
        data: {
          carryInfo: carryInfo,
        },
      });
    } catch (error) {
      throw error;
    }
  }

  async onVitalityUpdate(characterId: string, value: number, previewValue: number) {
    try {
      const character = await this.dataBaseService.character.findUnique({
        where: { id: characterId },
      });

      const healthInfo = character.healthInfo as StatusJson;
      const previewMaxValue = healthInfo.maxValue;
      const initialHealth = healthInfo.maxValue - previewValue - (character.level - 1) * healthInfo.valuePerLevel;

      healthInfo.valuePerLevel += value - previewValue;

      healthInfo.maxValue = initialHealth + value + (character.level - 1) * healthInfo.valuePerLevel;

      healthInfo.currentValue += healthInfo.maxValue - previewMaxValue;

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          healthInfo: healthInfo,
        },
      });
    } catch (error) {
      throw error;
    }
  }

  async onPresenceUpdate(characterId: string, value: number, previewValue: number) {
    try {
      const character = await this.dataBaseService.character.findUnique({
        where: { id: characterId },
      });

      const effortInfo = character.effortInfo as StatusJson;
      const previewMaxValue = effortInfo.maxValue;
      const initialHealth = effortInfo.maxValue - previewValue - (character.level - 1) * effortInfo.valuePerLevel;

      effortInfo.valuePerLevel += value - previewValue;

      effortInfo.maxValue = initialHealth + value + (character.level - 1) * effortInfo.valuePerLevel;

      effortInfo.currentValue += effortInfo.maxValue - previewMaxValue;

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          healthInfo: effortInfo,
        },
      });
    } catch (error) {
      throw error;
    }
  }
}
