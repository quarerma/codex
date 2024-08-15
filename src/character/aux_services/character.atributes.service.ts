import { Injectable } from '@nestjs/common';
import { AtributesJson, StatusJson, updateAtributeDTO } from '../dto/create-character-dto';
import { DataBaseService } from 'src/database/database.service';

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
      return await this.dataBaseService.inventory.update({
        where: { characterId: characterId },
        data: {
          maxValue: carry_weight,
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
      const previewMaxValue = character.max_health;
      const initialHealth = character.max_health - previewValue - (character.level - 1) * healthInfo.valuePerLevel;

      healthInfo.valuePerLevel += value - previewValue;

      character.max_health = initialHealth + value + (character.level - 1) * healthInfo.valuePerLevel;

      character.current_health += character.max_health - previewMaxValue;

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          current_health: character.current_health,
          max_health: character.max_health,
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
      const previewMaxValue = character.max_effort;
      const initialHealth = character.max_effort - previewValue - (character.level - 1) * effortInfo.valuePerLevel;

      effortInfo.valuePerLevel += value - previewValue;

      character.max_effort = initialHealth + value + (character.level - 1) * effortInfo.valuePerLevel;

      character.current_effort += character.max_effort - previewMaxValue;

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          current_effort: character.current_effort,
          max_effort: character.max_effort,
          healthInfo: effortInfo,
        },
      });
    } catch (error) {
      throw error;
    }
  }
}
