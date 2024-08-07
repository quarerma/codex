import { Injectable } from '@nestjs/common';
import { CreateClassDTO } from './dto/create-class-dto';
import { DataBaseService } from 'src/database/database.service';

@Injectable()
export class ClassesService {
  constructor(private readonly dataBaseService: DataBaseService) {}
  async createClass(data: CreateClassDTO) {
    try {
      console.log(data);
      return await this.dataBaseService.class.create({ data });
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
}
