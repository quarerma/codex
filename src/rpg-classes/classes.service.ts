import { Injectable } from '@nestjs/common';
import { CreateClassDTO } from './dto/create-class-dto';
import { DataBaseService } from 'src/database/database.service';
import { Class, Proficiency } from '@prisma/client';
import { CreateFeatDto } from 'src/feats/dto/create-feat-dto';

@Injectable()
export class ClassesService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createClass(data: CreateClassDTO): Promise<Class> {
    try {
      const enumProficiencies = data.proficiencies as Proficiency[];

      return await this.dataBaseService.class.create({
        data: {
          name: data.name,
          description: data.description,
          hitPointsPerLevel: data.hitPointsPerLevel,
          SanityPointsPerLevel: data.SanityPointsPerLevel,
          effortPointsPerLevel: data.effortPointsPerLevel,
          initialHealth: data.initialHealth,
          initialSanity: data.initialSanity,
          initialEffort: data.initialEffort,
          number_of_skills: data.number_of_skills,

          proficiencies: enumProficiencies,
        },
      });
    } catch (error) {
      throw new Error('Error creating class');
    }
  }

  async createInitialClassFeat(classId: string, feat: CreateFeatDto) {
    try {
      const createFeat = await this.dataBaseService.classFeats.create({
        data: {
          class: {
            connect: { id: classId },
          },
          feat: {
            create: {
              name: feat.name,
              description: feat.description,
              prerequisites: feat.prerequisites,
              element: feat.element,
              type: 'CLASS',
              afinity: feat.afinity,
              afinityUpgrades: feat.afinityUpgrades,
            },
          },
        },
      });

      await this.dataBaseService.class.update({
        where: { id: classId },
        data: {
          initialFeats: {
            push: createFeat.featId,
          },
        },
      });
    } catch (error) {
      throw new Error(error);
    }
  }

  async getClassFeats(classId: string) {
    try {
      return await this.dataBaseService.class.findMany({
        where: { id: classId },
        select: {
          classFeats: {
            select: {
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
          },
        },
      });
    } catch (error) {
      throw new Error(error);
    }
  }

  async getSubClasses(classId: string) {
    try {
      return await this.dataBaseService.class.findMany({
        where: { id: classId },
        select: {
          subclasses: {
            select: {
              id: true,
              name: true,
              description: true,
            },
          },
        },
      });
    } catch (error) {
      throw new Error(error);
    }
  }
  async getClasses() {
    try {
      return await this.dataBaseService.class.findMany();
    } catch (error) {
      throw new Error(error);
    }
  }
}
