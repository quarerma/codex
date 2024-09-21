import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateItemDto } from './dto/create.equipment.dto';
import { Element } from '@prisma/client';

@Injectable()
export class EquipmentService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createEquipment(data: CreateItemDto) {
    try {
      let equipment;
      switch (data.type) {
        case 'DEFAULT':
        case 'EXPLOSIVE':
        case 'OPERATIONAL_EQUIPMENT':
        case 'PARANORMAL_EQUIPMENT':
        case 'ACESSORY':
        case 'ARMOR':
          equipment = await this.createGeneralequipment(data);
          break;
        case 'WEAPON':
          equipment = await this.createWeaponequipment(data);
          break;
        case 'CURSED_ITEM':
          equipment = await this.createCursedequipment(data);
          break;

        default:
          throw new Error('Invalid type');
      }

      return equipment;
    } catch (error) {
      throw new Error(error);
    }
  }

  async getEquipment(id: number, type: string) {
    try {
      let equipment;
      switch (type) {
        case 'DEFAULT':
        case 'EXPLOSIVE':
        case 'OPERATIONAL_EQUIPMENT':
        case 'PARANORMAL_EQUIPMENT':
        case 'ACESSORY':
        case 'CUSTOM':
        case 'ARMOR':
          equipment = await this.dataBaseService.equipment.findUnique({
            where: { id },
          });
          break;

        case 'WEAPON':
          equipment = this.dataBaseService.equipment.findUnique({
            where: { id },
            include: {
              Weapon: true,
            },
          });
          break;
        case 'CURSED_ITEM':
          equipment = this.dataBaseService.equipment.findUnique({
            where: { id },
            include: {
              CursedItem: true,
            },
          });
          break;

        default:
          throw new Error('Invalid type');
      }

      return equipment;
    } catch (error) {
      console.log(error);
      throw new Error('Error to get equipment');
    }
  }

  //
  //
  //
  // Auxiliary functions

  async createCursedequipment(data: CreateItemDto) {
    return this.dataBaseService.equipment.create({
      data: {
        name: data.name,
        description: data.description,
        weight: data.weight,
        category: data.category,
        type: data.type,
        is_custom: data.is_custom,
        num_of_uses: data.num_of_uses,
        characterUpgrades: data.characterUpgrades,
        CursedItem: {
          create: {
            element: data.element as Element,
          },
        },
      },
    });
  }

  async createWeaponequipment(data: CreateItemDto) {
    return this.dataBaseService.equipment.create({
      data: {
        name: data.name,
        description: data.description,
        weight: data.weight,
        category: data.category,
        type: data.type,
        is_custom: data.is_custom,
        num_of_uses: data.num_of_uses,
        characterUpgrades: data.characterUpgrades,
        Weapon: {
          create: {
            damage: data.damage,
            critical_range: data.critical_range,
            critical_multiplier: data.critical_multiplier,
            range: data.range,
            damage_type: data.damage_type,
            weapon_type: data.weapon_type,
            weapon_category: data.weapon_category,
            hand_type: data.hand_type,
          },
        },
      },
    });
  }

  async createGeneralequipment(data: CreateItemDto) {
    return this.dataBaseService.equipment.create({
      data: {
        name: data.name,
        description: data.description,
        weight: data.weight,
        category: data.category,
        type: data.type,
        is_custom: data.is_custom,
        num_of_uses: data.num_of_uses,
        characterUpgrades: data.characterUpgrades,
      },
    });
  }

  async getPossibleEquipmentsForCampaign(campaignId: string) {
    return await this.dataBaseService.equipment.findMany({
      where: {
        OR: [
          {
            is_custom: false,
          },
          {
            is_custom: true,
            CampaignEquipment: {
              some: {
                campaignId: campaignId,
              },
            },
          },
        ],
      },
      select: {
        Weapon: true,
        CursedItem: true,
        id: true,
        name: true,
        description: true,
        is_custom: true,
        characterUpgrades: true,
        category: true,
        type: true,
        weight: true,
        num_of_uses: true,
      },
    });
  }

  async getAllEquipments() {
    return this.dataBaseService.equipment.findMany({
      select: {
        Weapon: true,
        CursedItem: true,
        id: true,
        name: true,
        description: true,
        is_custom: true,
        characterUpgrades: true,
        category: true,
        type: true,
        weight: true,
        num_of_uses: true,
      },
    });
  }
}
