import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateItemDto } from './dto/create.equipment.dto';

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
          equipment = await this.createGeneralequipment(data);
          break;
        case 'WEAPON':
          equipment = await this.createWeaponequipment(data);
          break;
        case 'ARMOR':
          equipment = await this.createArmorequipment(data);
          break;
        case 'ACESSORY':
          equipment = await this.createAccessoryequipment(data);
          break;
        case 'CURSED_ITEM':
          equipment = await this.createAccessoryequipment(data);
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
        case 'ARMOR':
          equipment = this.dataBaseService.equipment.findUnique({
            where: { id },
            include: {
              Armor: true,
            },
          });
          break;
        case 'ACESSORY':
          equipment = this.dataBaseService.equipment.findUnique({
            where: { id },
            include: {
              Accessory: true,
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
      throw new Error('Error to get equipment');
    }
  }

  //
  //
  //
  // Auxiliary functions
  async createAccessoryequipment(data: CreateItemDto) {
    return this.dataBaseService.equipment.create({
      data: {
        name: data.name,
        description: data.description,
        weight: data.weight,
        category: data.category,
        type: data.type,
        is_custom: data.is_custom,
        Accessory: {
          create: {
            skill_check: data.skill_check,
            characterUpgrades: data.characterUpgrades,
          },
        },
      },
    });
  }

  async createCursedequipment(data: CreateItemDto) {
    return this.dataBaseService.equipment.create({
      data: {
        name: data.name,
        description: data.description,
        weight: data.weight,
        category: data.category,
        type: data.type,
        is_custom: data.is_custom,
        CursedItem: {
          create: {
            element: data.element,
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

  async createArmorequipment(data: CreateItemDto) {
    return this.dataBaseService.equipment.create({
      data: {
        name: data.name,
        description: data.description,
        weight: data.weight,
        category: data.category,
        type: data.type,
        is_custom: data.is_custom,
        Armor: {
          create: {
            defense: data.defense,
            damage_reduction: data.damage_reduction,
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
      },
    });
  }
}
