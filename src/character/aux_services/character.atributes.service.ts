import { Injectable } from '@nestjs/common';
import { AtributesJson, updateAtributeDTO } from '../dto/create-character-dto';
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

      console.log(atribute);
      switch (atribute.atribute) {
        case 'STRENGTH':
          this.onStreghthUpdate(characterId, atribute.value);
          atributes.strength = atribute.value;
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

      const valueToIncrement = (value - previewValue) * character.level;

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          current_health: {
            increment: valueToIncrement,
          },
          max_health: {
            increment: valueToIncrement,
          },
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

      const valueToIncrement = (value - previewValue) * character.level;

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          current_effort: {
            increment: valueToIncrement,
          },
          max_effort: {
            increment: valueToIncrement,
          },
        },
      });
    } catch (error) {
      throw error;
    }
  }

  async onDexterityUpdate(characterId: string, value: number) {
    try {
      // TODO: Implement dexterity update
      console.log(characterId, value);
    } catch (error) {
      throw error;
    }
  }

  async onIntelligenceUpdate(characterId: string, value: number) {
    try {
      // TODO: Implement intelligence update
      console.log(characterId, value);
    } catch (error) {
      throw error;
    }
  }
}
