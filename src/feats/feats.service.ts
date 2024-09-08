import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateFeatDto } from './dto/create-feat-dto';

@Injectable()
export class FeatsService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createGeneralFeat(data: CreateFeatDto) {
    try {
      const created = await this.dataBaseService.generalFeats.create({
        data: {
          feat: {
            create: {
              afinityUpgrades: data.afinityUpgrades,
              afinity: data.afinity,
              name: data.name,
              description: data.description,
              prerequisites: data.prerequisites,
              characterUpgrades: data.characterUpgrade,
              type: 'GENERAL',
              element: data.element,
            },
          },
        },
        select: {
          feat: {
            select: {
              id: true,
              name: true,
              description: true,
              prerequisites: true,
              element: true,
              afinity: true,
            },
          },
        },
      });

      return created.feat;
    } catch (error) {
      throw new Error('Error creating general feat');
    }
  }

  async getGeneralFeats() {
    try {
      const general_feats = await this.dataBaseService.generalFeats.findMany({
        select: {
          feat: {
            select: {
              id: true,
              name: true,
              description: true,
              prerequisites: true,
              element: true,
              afinity: true,
            },
          },
        },
      });

      return general_feats.map((feat) => feat.feat);
    } catch (error) {
      throw new Error('Error getting general feats');
    }
  }
}
