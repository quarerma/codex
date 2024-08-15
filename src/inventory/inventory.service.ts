import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';

@Injectable()
export class InventoryService {
  constructor(private readonly dataBaseService: DataBaseService) {}

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

      // TODO: update character stats based on item

      // On weapon add -- add attack
      // On acessory add -- modify skills

      return await this.dataBaseService.inventory.update({
        where: {
          characterId: characterId,
        },
        data: {
          currentValue: {
            increment: item.weight,
          },
          slots: {
            create: {
              equipment: {
                connect: {
                  id: item.id,
                },
              },
              uses: item.num_of_uses,
              local_name: item.name,
              category: item.category,
            },
          },
        },
      });
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
