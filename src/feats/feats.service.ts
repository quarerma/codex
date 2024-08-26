import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateFeatDto } from './dto/create-feat-dto';

@Injectable()
export class FeatsService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createGeneralFeat(data: CreateFeatDto) {
    try {
      return await this.dataBaseService.generalFeats.create({
        data: {
          feat: {
            create: {
              name: data.name,
              description: data.description,
              prerequisites: data.prerequisites,
              characterUpgrades: data.characterUpgrade,
              type: 'GENERAL',
              element: data.element,
              afinity: data.afinity,
              afinityUpgrades: data.afinityUpgrades,
            },
          },
        },
      });
    } catch (error) {
      throw new Error('Error creating general feat');
    }
  }

  async createClassFeat(data: CreateFeatDto, classId: string) {
    try {
      return await this.dataBaseService.classFeats.create({
        data: {
          class: {
            connect: { id: classId },
          },
          feat: {
            create: {
              name: data.name,
              description: data.description,
              prerequisites: data.prerequisites,
              characterUpgrades: data.characterUpgrade,
              type: 'CLASS',
              element: data.element,
            },
          },
        },
      });
    } catch (error) {
      throw new Error('Error creating class feat');
    }
  }

  async createSubClassFeat(data: CreateFeatDto, subclassId: string) {
    try {
      return await this.dataBaseService.subclassFeats.create({
        data: {
          subclass: {
            connect: { id: subclassId },
          },
          feat: {
            create: {
              name: data.name,
              description: data.description,
              prerequisites: data.prerequisites,
              characterUpgrades: data.characterUpgrade,
              type: 'SUBCLASS',
              element: data.element,
            },
          },
        },
      });
    } catch (error) {
      throw new Error('Error creating subclass feat');
    }
  }

  async getGeneralFeats() {
    try {
      return await this.dataBaseService.generalFeats.findMany({
        select: {
          feat: true,
        },
      });
    } catch (error) {
      throw new Error('Error getting general feats');
    }
  }
}
