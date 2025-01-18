import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { EmptySlotDTO } from '../dto/empty.slot.dto';
import { UpdateSlotDTO } from '../dto/updata.slot.dto';

@Injectable()
export class CharacterSlotService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createInventorySlotNoItem(data: EmptySlotDTO) {
    return await this.dataBaseService.inventory.update({
      where: { characterId: data.characterId },
      data: {
        slots: {
          create: {
            category: data.category,
            local_description: data.local_description,
            local_name: data.local_name,
            uses: data.uses,
            is_equipped: true,
            weight: data.weight,
          },
        },
      },
    });
  }

  async updateSlot(data: UpdateSlotDTO) {
    return await this.dataBaseService.inventorySlot.update({
      where: { id: data.id },
      data: {
        local_description: data.new_local_description,
        local_name: data.new_local_name,
        uses: data.new_uses,
        weight: data.weight,
      },
    });
  }
}
