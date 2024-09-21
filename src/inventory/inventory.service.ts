import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { WeapondAddService } from './aux-services/weapond-add-service';
import { CharacterUpgradesService } from 'src/character/aux_services/character.upgrades.service';
import { CharacterUpgrade } from 'src/types/characterUpgrade-type';
import { CharacterUnUpgradesService } from 'src/character/aux_services/character.unupgrade.service';
import { AlterationObject } from 'src/character/dto/create-character-dto';

@Injectable()
export class InventoryService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly weaponService: WeapondAddService,
    private readonly characterUpgradesService: CharacterUpgradesService,
    private readonly unUpgradeService: CharacterUnUpgradesService,
  ) {}

  async getInventory(characterId: string) {
    try {
      const inventory = await this.dataBaseService.inventory.findUnique({
        where: {
          characterId: characterId,
        },
        select: {
          characterId: true,
          credit: true,
          alterations: true,
          currentValue: true,
          maxValue: true,
          patent: true,
          slots: {
            select: {
              equipment: {
                include: {
                  Weapon: true,
                  CursedItem: true,
                },
              },
              category: true,
              alterations: true,
              id: true,
              is_equipped: true,
              local_name: true,
              uses: true,
            },
          },
        },
      });

      return inventory;
    } catch (e) {
      console.error(e);
    }
  }
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
          local_description: item.description,
          alterations: [],
          uses: item.num_of_uses,
          is_equipped: false,
        },
      });

      await this.equipItem(slot.id, characterId);

      return slot;
    } catch (e) {
      console.error(e);
    }
  }

  async removeItemFromInventory(characterId: string, slot_id: string) {
    try {
      await this.unequipItem(slot_id, characterId);

      await this.dataBaseService.inventorySlot.delete({
        where: {
          id: slot_id,
        },
      });
    } catch (e) {
      console.error(e);
    }
  }

  async equipItem(inventory_slot: string, characterId: string) {
    try {
      const slot = await this.dataBaseService.inventorySlot.update({
        where: {
          id: inventory_slot,
        },
        data: {
          is_equipped: true,
        },
        select: {
          id: true,
          equipment: true,
        },
      });

      await this.dataBaseService.inventory.update({
        where: {
          characterId: characterId,
        },
        data: {
          currentValue: {
            increment: slot.equipment.weight,
          },
        },
      });

      // On weapon add -- add attack
      if (slot.equipment.type === 'WEAPON') {
        await this.weaponService.addWeapon(slot.equipment.id, characterId, slot.equipment, slot.id);
      }

      if (slot.equipment.characterUpgrades.length > 0) {
        for (const upgrade of slot.equipment.characterUpgrades as CharacterUpgrade[]) {
          await this.characterUpgradesService.applyUpgrade(characterId, upgrade, slot.equipment, 'equipment');
        }
      }
    } catch (e) {
      throw new Error(e);
    }
  }

  async unequipItem(inventory_slot: string, characterId: string) {
    try {
      const slot = await this.dataBaseService.inventorySlot.update({
        where: {
          id: inventory_slot,
        },
        data: {
          is_equipped: false,
        },
        select: {
          id: true,
          equipment: true,
          alterations: true,
        },
      });

      await this.dataBaseService.inventory.update({
        where: {
          characterId: characterId,
        },
        data: {
          currentValue: {
            decrement: slot.equipment.weight,
          },
        },
      });

      // On weapon remove -- remove attack
      if (slot.equipment.type === 'WEAPON') {
        await this.weaponService.removeWeapon(characterId, inventory_slot);
      }

      if (slot.equipment.characterUpgrades.length > 0) {
        for (const upgrade of slot.equipment.characterUpgrades as CharacterUpgrade[]) {
          await this.unUpgradeService.unApplyUpgrades(characterId, upgrade, slot.equipment, 'equipment');
        }
      }

      console.log('slot', slot);

      // remove modification alterations
      if (slot.alterations.length > 0) {
        for (const alteration of slot.alterations as AlterationObject[]) {
          if (alteration.modification) {
            const modification = await this.dataBaseService.modification.findUnique({
              where: {
                id: alteration.modification,
              },
            });
            for (const upgrade of modification.characterUpgrades as CharacterUpgrade[]) {
              await this.unUpgradeService.unApplyUpgrades(characterId, upgrade, modification, 'modification');
            }
          }
        }
      }
    } catch (e) {
      console.error(e);
      throw new Error(e);
    }
  }

  async addModificationToItem(slot_id: string, modification_id: string) {
    try {
      const modification = await this.dataBaseService.modification.findUnique({
        where: {
          id: modification_id,
        },
      });

      if (!modification) {
        throw new Error('Modification not found');
      }

      const alterationObject: AlterationObject = {
        modificationName: modification.name,
        modification: modification.id,
      };

      await this.dataBaseService.inventorySlot.update({
        where: {
          id: slot_id,
        },
        data: {
          category: {
            increment: 1,
          },
          alterations: {
            push: alterationObject,
          },
        },
      });

      for (const upgrade of modification.characterUpgrades as CharacterUpgrade[]) {
        await this.characterUpgradesService.applyUpgrade(modification_id, upgrade, modification, 'modification');
      }
    } catch (e) {
      console.error(e);
    }
  }

  async removeModificationFromItem(slot_id: string, modification_id: string) {
    try {
      const slot = await this.dataBaseService.inventorySlot.findUnique({
        where: {
          id: slot_id,
        },
        select: {
          alterations: true,
        },
      });

      const alterations = slot.alterations as AlterationObject[];

      // apague a primeira alteração que tiver o modification_id
      const index = alterations.findIndex((alteration) => alteration.modification === modification_id);

      const updated_alterations = index >= 0 ? [...alterations.slice(0, index), ...alterations.slice(index + 1)] : alterations;

      await this.dataBaseService.inventorySlot.update({
        where: {
          id: slot_id,
        },
        data: {
          alterations: {
            set: updated_alterations,
          },
        },
      });

      const modification = await this.dataBaseService.modification.findUnique({
        where: {
          id: modification_id,
        },
      });

      for (const upgrade of modification.characterUpgrades as CharacterUpgrade[]) {
        await this.unUpgradeService.unApplyUpgrades(modification_id, upgrade, modification, 'modification');
      }
    } catch (e) {
      console.error(e);
    }
  }
}
