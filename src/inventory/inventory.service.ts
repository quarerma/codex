import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { WeapondAddService } from './aux-services/weapond-add-service';

@Injectable()
export class InventoryService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly weaponService: WeapondAddService,
  ) {}

  async addItemToInventory(item_id: number, characterId: string) {
    try {
      const item = await this.dataBaseService.equipment.findUnique({
        where: {
          id: item_id,
        },
      });

      if (!item) {
        throw new Error('Item not found');
      }

      await this.dataBaseService.inventory.update({
        where: {
          characterId: characterId,
        },
        data: {
          currentValue: {
            increment: item.weight,
          },
        },
      });

      const slot = await this.dataBaseService.inventorySlot.create({
        data: {
          equipment: {
            connect: {
              id: item_id,
            },
          },
          inventory: {
            connect: {
              characterId: characterId,
            },
          },
          category: item.category,
          local_name: item.name,
          alterations: [],
          uses: item.num_of_uses,
        },
      });
      // TODO: update character stats based on item

      // On weapon add -- add attack
      if (item.type === 'WEAPON') {
        await this.weaponService.addWeapon(item_id, characterId, item, slot.id);
      }
      // On acessory add -- modify skills

      return slot;
    } catch (e) {
      console.error(e);
    }
  }

  async removeItemFromInventory(item_id: number, characterId: string, slot_id: string) {
    try {
      const item = await this.dataBaseService.equipment.findUnique({
        where: {
          id: item_id,
        },
      });

      if (!item) {
        throw new Error('Item not found');
      }

      // On weapon remove -- remove attack
      if (item.type === 'WEAPON') {
        await this.weaponService.removeWeapon(characterId, slot_id);
      }

      // TODO: remove item influence on character stats

      return await this.dataBaseService.inventory.update({
        where: {
          characterId: characterId,
        },
        data: {
          currentValue: {
            decrement: item.weight,
          },
          slots: {
            delete: {
              id: slot_id,
            },
          },
        },
      });
    } catch (e) {
      console.error(e);
    }
  }
}
