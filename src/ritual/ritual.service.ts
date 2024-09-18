import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateRitualDto } from './dto/create.ritual';
import { Element } from '@prisma/client';

@Injectable()
export class RitualService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async create(data: CreateRitualDto) {
    try {
      console.log(data);
      const ritual = await this.dataBaseService.ritual.create({
        data: {
          name: data.name,
          normalCastDescription: data.normalCastDescription,
          normalCost: data.normalCost,
          resistence: data.resistance,
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
        for (let i = 0; i < data.conditions.length; i++) {
          await this.dataBaseService.ritualCondition.create({
            data: {
              condition: {
                connect: { id: data.conditions[i] },
              },
              ritual: {
                connect: { id: ritual.id },
              },
            },
          });
        }
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
      console.log(error);
    }
  }

  async getCoreRituals() {
    try {
      return await this.dataBaseService.ritual.findMany({
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
    } catch (error) {
      throw new Error('Error getting core rituals');
    }
  }

  async filterRitualsByElement(element: Element) {
    try {
      return await this.dataBaseService.ritual.findMany({
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
    } catch (error) {
      throw new Error('Error getting rituals by element');
    }
  }
}
