import { Controller, Get, Query, Patch, HttpException, HttpStatus, Post, Body } from '@nestjs/common';
import { InventoryService } from './inventory.service';
import { CharacterSlotService } from './aux-services/character.slot.service';
import { UpdateSlotDTO } from './dto/updata.slot.dto';

@Controller('inventory')
export class InventoryController {
  constructor(
    private readonly inventoryService: InventoryService,
    private readonly characterSlotsService: CharacterSlotService,
  ) {}

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

  @Patch('/equip-item')
  async equipItem(@Query('slotId') slotId: string, @Query('characterId') characterId: string) {
    try {
      return await this.inventoryService.equipItem(characterId, slotId);
    } catch (error) {
      throw new HttpException(`Error equipping item: ${error}`, HttpStatus.BAD_REQUEST);
    }
  }

  @Patch('/unequip-item')
  async unequipItem(@Query('slotId') slotId: string, @Query('characterId') characterId: string) {
    try {
      return await this.inventoryService.unequipItem(characterId, slotId);
    } catch (error) {
      throw new HttpException(`Error unequipping item: ${error}`, HttpStatus.BAD_REQUEST);
    }
  }

  @Post('/create-empty-slot')
  async createEmptySlot(@Query('characterId') characterId: string) {
    try {
      return await this.characterSlotsService.createInventorySlotNoItem(characterId);
    } catch (error) {
      throw new HttpException(`Error creating empty slot: ${error}`, HttpStatus.BAD_REQUEST);
    }
  }

  @Post('/update-slot')
  async updateSlot(@Body() data: UpdateSlotDTO) {
    try {
      return await this.characterSlotsService.updateSlot(data);
    } catch (error) {
      console.log(error);
      throw new HttpException(`Error updating slot: ${error}`, HttpStatus.BAD_REQUEST);
    }
  }
}
