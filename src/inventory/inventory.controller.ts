import { Controller, Get, Param, Patch } from '@nestjs/common';
import { InventoryService } from './inventory.service';

@Controller('inventory')
export class InventoryController {
  constructor(private readonly inventoryService: InventoryService) {}

  @Patch('/add-item/:characterId/:id')
  async addItemToInventory(@Param('id') id: number, @Param('characterId') characterId: string) {
    try {
      return this.inventoryService.addItemToInventory(id, characterId);
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
}
