import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateOriginDTO } from './dto/crete.origin.dto';

@Injectable()
export class OriginsService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createOrigin(data: CreateOriginDTO) {
    try {
      return await this.dataBaseService.origin.create({
        data: {
          name: data.name,
          description: data.description,
          is_custom: false,
          skills: data.skills,
          feats: {
            create: {
              description: data.feat.description,
              name: data.feat.name,
              element: data.feat.element,
              type: 'ORIGIN',
              characterUpgrades: data.feat.characterUpgrade,
            },
          },
        },
      });
    } catch (error) {
      throw new Error('Error creating origin');
    }
  }

  async getOrigins() {
    try {
      return await this.dataBaseService.origin.findMany({
        where: { is_custom: false },
        select: {
          feats: true,
          name: true,
          skills: true,
          description: true,
        },
      });
    } catch (error) {
      throw new Error('Error getting origins');
    }
  }
}
