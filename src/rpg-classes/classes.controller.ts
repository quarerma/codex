import { Body, Controller, Post } from '@nestjs/common';
import { ClassesService } from './classes.service';
import { CreateClassDTO } from './dto/create-class-dto';

@Controller('classes')
export class ClassesController {
  constructor(private readonly classesService: ClassesService) {}

  @Post()
  async createClass(@Body() data: CreateClassDTO) {
    try {
      return await this.classesService.createClass(data);
    } catch (error) {
      throw new Error('Error creating class');
    }
  }
}
