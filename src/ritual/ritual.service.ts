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
          discentCastDescription: data.discentCastDescription,
          trueCastDescription: data.trueCastDescription,
          exectutionTime: data.exectutionTime,
          range: data.range,
          target: data.target,
          duration: data.duration,
          element: data.element,
          is_custom: true,
          type: data.type,
        },
      });

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
      return await this.dataBaseService.ritual.findMany({
        where: { is_custom: false },
      });
    } catch (error) {
      throw new Error('Error getting core rituals');
    }
  }

  async filterRitualsByElement(element: Element) {
    try {
      return await this.dataBaseService.ritual.findMany({
        where: { element: element },
      });
    } catch (error) {
      throw new Error('Error getting rituals by element');
    }
  }
}
