import { Injectable } from '@nestjs/common';
import { CreateClassDTO } from './dto/create-class-dto';
import { DataBaseService } from 'src/database/database.service';
import { Class, Proficiency } from '@prisma/client';

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

          proficiencies: enumProficiencies,
        },
      });
    } catch (error) {
      throw new Error('Error creating class');
    }
  }

  async assignClassFeat(classId: string, featId: string) {
    try {
      return await this.dataBaseService.classFeats.create({
        data: {
          class: {
            connect: { id: classId },
          },
          feat: {
            connect: { id: featId },
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
              feat: true,
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
