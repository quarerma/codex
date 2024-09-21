import { Controller, Get, Param, Patch } from '@nestjs/common';
import { InventoryService } from './inventory.service';

@Controller('inventory')
export class InventoryController {
  constructor(private readonly inventoryService: InventoryService) {}

  @Patch('/add-item/:characterId/:id')
  async addItemToInventory(@Param('id') id: number, @Param('characterId') characterId: string) {
    try {
      return this.inventoryService.addItemToInventory(Number(id), characterId);
    } catch (error) {
      throw new Error(error);
    }
  }

  @Get('/:characterId')
  async getInventory(@Param('characterId') characterId: string) {
    try {
      return this.inventoryService.getInventory(characterId);
    } catch (error) {
      throw new Error(error);
    }
  }

  @Patch('/remove-item/:characterId/:slotId')
  async removeItemFromInventory(@Param('slotId') slotId: string, @Param('characterId') characterId: string) {
    try {
      console.log('slotId', slotId);
      console.log('characterId', characterId);
      return this.inventoryService.removeItemFromInventory(characterId, slotId);
    } catch (error) {
      throw new Error(error);
    }
  }
}
