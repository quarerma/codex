import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateSubClassDto } from './dto/create-subclass-dto';
import { CreateFeatDto } from 'src/feats/dto/create-feat-dto';

@Injectable()
export class SubClassService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createSubClass(data: CreateSubClassDto) {
    try {
      console.log(data);
      return await this.dataBaseService.subclass.create({
        data: {
          name: data.name,
          description: data.description,
          class: {
            connect: { id: data.classId },
          },
        },
      });
    } catch (error) {
      throw new Error(error);
    }
  }

  async assignSubClassFeat(subclassId: string, feat: CreateFeatDto, levelRequired: number) {
    try {
      return await this.dataBaseService.subclassFeats.create({
        data: {
          levelRequired: levelRequired,
          subclass: {
            connect: { id: subclassId },
          },
          feat: {
            create: {
              name: feat.name,
              characterUpgrades: feat.characterUpgrade,
              description: feat.description,
              prerequisites: feat.prerequisites,
              element: feat.element,
              type: 'SUBCLASS',
            },
          },
        },
      });
    } catch (error) {
      throw new Error(error);
    }
  }

  async getSubClassesFeats(subclassId: string) {
    try {
      return await this.dataBaseService.subclassFeats.findMany({
        where: { subclassId: subclassId },
        select: {
          levelRequired: true,
          feat: {
            select: {
              id: true,
              name: true,
              description: true,
              prerequisites: true,
              element: true,
            },
          },
        },
        orderBy: {
          levelRequired: 'asc',
        },
      });
    } catch (error) {
      throw new Error(error);
    }
  }

  async getAllSubclasses() {
    try {
      const subclasses = await this.dataBaseService.subclass.findMany({
        select: {
          id: true,
          name: true,
          description: true,
          class: true,
          subclassFeats: {
            select: {
              feat: true,
              levelRequired: true,
            },
          },
        },
        orderBy: {
          name: 'asc',
        },
      });

      return subclasses.map((subclass) => {
        return {
          id: subclass.id,
          name: subclass.name,
          description: subclass.description,
          class: subclass.class,
          subclassFeats: subclass.subclassFeats.map((subclassFeat) => {
            return {
              feat: subclassFeat.feat,
              levelRequired: subclassFeat.levelRequired,
            };
          }),
        };
      });
    } catch (error) {
      throw new Error(error);
    }
  }
}
