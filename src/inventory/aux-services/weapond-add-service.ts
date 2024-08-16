import { Injectable } from '@nestjs/common';
import { Equipment } from '@prisma/client';
import { Attack } from 'src/character/dto/attacks.dto';
import { DataBaseService } from 'src/database/database.service';

@Injectable()
export class WeapondAddService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async addWeapon(weapon_id: number, characterId: string, item: Equipment, slot_id: string) {
    try {
      const weapon = await this.dataBaseService.weapon.findUnique({
        where: {
          equipmentId: weapon_id,
        },
      });

      if (!weapon) {
        throw new Error('Weapon not found');
      }

      const newAttack: Attack = {
        critical_margin: weapon.critical_range,
        critical_multiplier: weapon.critical_multiplier,
        damaga_dies: weapon.damage,
        extra_damage: [],
        local_id: slot_id,
        name: item.name,
        skill: weapon.range == 'MELEE' ? 'Luta' : 'Pontaria',
        alterations: [],
      };

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          attacks: {
            push: newAttack,
          },
        },
      });
    } catch (e) {
      console.error(e);
    }
  }

  async removeWeapon(characterId: string, slot_id: string) {
    try {
      const character_attacks = await this.dataBaseService.character.findUnique({
        where: { id: characterId },
        select: {
          attacks: true,
        },
      });

      // TODO: remove alterations of the character
      const attacks = character_attacks.attacks as Attack[];

      const updated_attacks = attacks.filter((attack) => attack.local_id !== slot_id);

      await this.dataBaseService.character.update({
        where: { id: characterId },
        data: {
          attacks: {
            set: updated_attacks,
          },
        },
      });
    } catch (e) {
      console.error(e);
    }
  }
}
