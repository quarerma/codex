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
}
