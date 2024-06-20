import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateFeatDto } from './dto/create-feat-dto';

@Injectable()
export class FeatsService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createGeneralFeat(data: CreateFeatDto) {
    try {
      return await this.dataBaseService.generalFeat.create({
        data: {
          element: data.element,
          feat: {
            create: {
              name: data.name,
              description: data.description,
              prerequisites: data.prerequisites,
              characterUpgrades: data.characterUpgrade,
              type: 'GENERAL',
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
      return await this.dataBaseService.classFeat.create({
        data: {
          feat: {
            create: {
              name: data.name,
              description: data.description,
              prerequisites: data.prerequisites,
              characterUpgrades: data.characterUpgrade,
              type: 'CLASS',
            },
          },
          class: {
            connect: { id: classId },
          },
        },
      });
    } catch (error) {
      throw new Error('Error creating class feat');
    }
  }

  async createSubClassFeat(data: CreateFeatDto, subclassId: string) {
    try {
      return await this.dataBaseService.subclassFeat.create({
        data: {
          feat: {
            create: {
              name: data.name,
              description: data.description,
              prerequisites: data.prerequisites,
              characterUpgrades: data.characterUpgrade,
              type: 'SUBCLASS',
            },
          },
          subclass: {
            connect: { id: subclassId },
          },
        },
      });
    } catch (error) {
      throw new Error('Error creating subclass feat');
    }
  }
}
