import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { EmptySlotDTO } from '../dto/empty.slot.dto';
import { UpdateSlotDTO } from '../dto/updata.slot.dto';

@Injectable()
export class CharacterSlotService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createInventorySlotNoItem(characterId: string) {
    const data: EmptySlotDTO = {
      category: 0,
      characterId: characterId,
      local_name: '0. Novo Item',
      uses: 0,
      weight: 0,
    };

    return await this.dataBaseService.inventorySlot.create({
      data: {
        category: data.category,
        inventory: {
          connect: {
            characterId: data.characterId,
          },
        },
        local_name: data.local_name,
        uses: data.uses,
        weight: data.weight,
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
        weight: data.new_weight,
        category: data.new_category,
      },
    });
  }
}
