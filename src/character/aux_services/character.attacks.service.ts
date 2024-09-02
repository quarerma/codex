import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { Attack } from '../dto/attacks.dto';
import cuid from 'cuid';

@Injectable()
export class CharacterAttacksService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createAttack(characterId: string, attack: Attack) {
    try {
      if (!attack.local_id) {
        attack.local_id = cuid();
      }

      // TODO: check character feats to see if attack changes

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          attacks: {
            push: attack,
          },
        },
      });
    } catch (error) {
      throw error;
    }
  }

  async delete_attack(characterId: string, attackId: string) {
    try {
      const character_attacks = await this.dataBaseService.character.findUnique({
        where: { id: characterId },
        select: {
          attacks: true,
        },
      });

      const attacks = character_attacks.attacks as Attack[];

      const updated_attacks = attacks.filter((attack) => attack.local_id !== attackId);

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          attacks: {
            set: updated_attacks,
          },
        },
      });
    } catch (error) {
      throw error;
    }
  }

  async updateAttack(characterId: string, body: Attack) {
    try {
      const character_attacks = await this.dataBaseService.character.findUnique({
        where: { id: characterId },
        select: {
          attacks: true,
        },
      });

      const attacks = character_attacks.attacks as Attack[];

      const attackIndex = attacks.findIndex((attack) => attack.local_id === body.local_id);

      if (attackIndex === -1) {
        throw new Error('Attack not found');
      }

      attacks[attackIndex] = body;

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          attacks: {
            set: attacks,
          },
        },
      });
    } catch (error) {
      throw error;
    }
  }

  async getCharacterAttacks(characterId: string) {
    try {
      const character_attacks = await this.dataBaseService.character.findUnique({
        where: { id: characterId },
        select: {
          attacks: true,
        },
      });

      return character_attacks.attacks;
    } catch (error) {
      throw error;
    }
  }
}
