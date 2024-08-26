import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateSubClassDto } from './dto/create-subclass-dto';

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

  async assignSubClassFeat(subclassId: string, featId: string) {
    try {
      return await this.dataBaseService.subclassFeats.create({
        data: {
          subclass: {
            connect: { id: subclassId },
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

  async getSubClassesFeats(subclassId: string) {
    try {
      return await this.dataBaseService.subclass.findMany({
        where: { id: subclassId },
        select: {
          subclassFeats: {
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
          },
        },
      });
    } catch (error) {
      throw new Error(error);
    }
  }

  async getAllSubclasses() {
    try {
      return await this.dataBaseService.subclass.findMany({
        select: {
          id: true,
          name: true,
          description: true,
          class: true,
        },
      });
    } catch (error) {
      throw new Error(error);
    }
  }
}
