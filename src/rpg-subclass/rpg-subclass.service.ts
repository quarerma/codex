import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateSubClassDto } from './dto/create-subclass-dto';

@Injectable()
export class SubClassService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createSubClass(data: CreateSubClassDto) {
    try {
      return await this.dataBaseService.subclass.create({
        data: {
          name: data.name,

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
      return await this.dataBaseService.feat.update({
        where: { id: featId },
        data: {
          subClass: {
            connect: { id: subclassId },
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
          subclassFeats: true,
        },
      });
    } catch (error) {
      throw new Error(error);
    }
  }
}
