import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateRitualDto } from './dto/create.ritual';
import { Element } from '@prisma/client';

@Injectable()
export class RitualService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async create(data: CreateRitualDto) {
    try {
      const ritual = await this.dataBaseService.ritual.create({
        data: {
          name: data.name,
          normalCastDescription: data.normalCastDescription,
          normalCost: data.normalCost,
          discentCastDescription: data.discentCastDescription,
          discentCost: data.discentCost,
          trueCastDescription: data.trueCastDescription,
          trueCost: data.trueCost,
          ritualLevel: data.ritualLevel,
          exectutionTime: data.exectutionTime,
          range: data.range,
          target: data.target,
          duration: data.duration,
          element: data.element,
          is_custom: false,
          type: data.type,
        },
      });

      if (data.conditions.length > 0) {
        this.dataBaseService.ritualCondition.createMany({
          data: data.conditions.map((condition) => ({
            conditionId: condition,
            ritualId: ritual.id,
          })),
        });
      }
      if (data.type === 'DAMAGE') {
        await this.dataBaseService.damageRitual.create({
          data: {
            ritual: {
              connect: { id: ritual.id },
            },
            normalCastDamageType: data.normalCastDamageType,
            discentCastDamageType: data.discentCastDamageType,
            trueCastDamageType: data.trueCastDamageType,
            normalCastDamage: data.normalCastDamage,
            discentCastDamage: data.discentCastDamage,
            trueCastDamage: data.trueCastDamage,
          },
        });
      }
    } catch (error) {
      throw new Error('Error creating custom ritual');
    }
  }

  async getCoreRituals() {
    try {
      const rituals = await this.dataBaseService.ritual.findMany({
        where: { is_custom: false },
        include: {
          damageRitual: true,
          conditions: {
            select: {
              condition: true,
            },
          },
        },
      });

      return rituals.map(({ damageRitual, ...ritual }) => ({
        ...ritual,
        normalCastDamageType: damageRitual.normalCastDamageType,
        discentCastDamageType: damageRitual.discentCastDamageType,
        trueCastDamageType: damageRitual.trueCastDamageType,
        normalCastDamage: damageRitual.normalCastDamage,
        discentCastDamage: damageRitual.discentCastDamage,
        trueCastDamage: damageRitual.trueCastDamage,
        conditions: ritual.conditions.map((c) => c.condition),
      }));
    } catch (error) {
      throw new Error('Error getting core rituals');
    }
  }

  async filterRitualsByElement(element: Element) {
    try {
      const rituals = await this.dataBaseService.ritual.findMany({
        where: { element: element },
        include: {
          damageRitual: true,
          conditions: {
            select: {
              condition: true,
            },
          },
        },
      });

      return rituals.map(({ damageRitual, ...ritual }) => ({
        ...ritual,
        normalCastDamageType: damageRitual.normalCastDamageType,
        discentCastDamageType: damageRitual.discentCastDamageType,
        trueCastDamageType: damageRitual.trueCastDamageType,
        normalCastDamage: damageRitual.normalCastDamage,
        discentCastDamage: damageRitual.discentCastDamage,
        trueCastDamage: damageRitual.trueCastDamage,
        conditions: ritual.conditions.map((c) => c.condition),
      }));
    } catch (error) {
      throw new Error('Error getting rituals by element');
    }
  }
}
