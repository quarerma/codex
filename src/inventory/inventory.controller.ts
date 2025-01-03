import { Controller, Get, Query, Patch, HttpException, HttpStatus } from '@nestjs/common';
import { InventoryService } from './inventory.service';

@Controller('inventory')
export class InventoryController {
  constructor(private readonly inventoryService: InventoryService) {}

  @Patch('/add-item')
  async addItemToInventory(@Query('id') id: string, @Query('characterId') characterId: string) {
    try {
      return await this.inventoryService.addItemToInventory(Number(id), characterId);
    } catch (error) {
      throw new HttpException(`Error adding item to inventory: ${error}`, HttpStatus.BAD_REQUEST);
    }
  }

  @Get()
  async getInventory(@Query('characterId') characterId: string) {
    try {
      return await this.inventoryService.getInventory(characterId);
    } catch (error) {
      throw new HttpException(`Error retrieving inventory: ${error}`, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @Patch('/remove-item')
  async removeItemFromInventory(@Query('slotId') slotId: string, @Query('characterId') characterId: string) {
    try {
      return await this.inventoryService.removeItemFromInventory(characterId, slotId);
    } catch (error) {
      throw new HttpException(`Error removing item from inventory: ${error}`, HttpStatus.BAD_REQUEST);
    }
  }
}
