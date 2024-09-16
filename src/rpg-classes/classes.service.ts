import { Injectable } from '@nestjs/common';
import { CreateClassDTO } from './dto/create-class-dto';
import { DataBaseService } from 'src/database/database.service';
import { Class, Feat, Proficiency } from '@prisma/client';
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

  async createInitialClassFeat(classId: string, feat: CreateFeatDto) {
    try {
      return await this.dataBaseService.classFeats.create({
        data: {
          class: {
            connect: { id: classId },
          },
          isStarterFeat: true,
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
    } catch (error) {
      throw new Error(error);
    }
  }

  async getClassFeats(classId: string) {
    try {
      const classFeats = await this.dataBaseService.class.findUnique({
        where: {
          id: classId,
          classFeats: {
            none: {
              isStarterFeat: true,
            },
          },
        },
        select: {
          initialFeats: true,
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

      return classFeats.classFeats.map((feat) => feat.feat);
    } catch (error) {
      throw new Error(error);
    }
  }

  async getSubClasses(classId: string) {
    try {
      const subclass = await this.dataBaseService.class.findUnique({
        where: { id: classId },
        select: {
          subclasses: {
            select: {
              id: true,
              name: true,
              description: true,
              subclassFeats: {
                select: {
                  levelRequired: true,
                  feat: true,
                },
              },
            },
          },
        },
      });

      return subclass.subclasses;
    } catch (error) {
      throw new Error(error);
    }
  }

  async getClasses() {
    try {
      return await this.dataBaseService.class.findMany({
        orderBy: {
          name: 'asc',
        },
      });
    } catch (error) {
      throw new Error(error);
    }
  }

  async getInitialFeats(classId: string) {
    try {
      const feats = await this.dataBaseService.classFeats.findMany({
        where: {
          classId: classId,
          isStarterFeat: true,
        },
        select: {
          feat: true,
        },
      });

      return feats.map((feat) => feat.feat) as Feat[];
    } catch (error) {
      throw new Error(error);
    }
  }
}
