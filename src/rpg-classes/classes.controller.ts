import { Body, Controller, Get, Param, Patch, Post } from '@nestjs/common';
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

  @Patch('assign-feat/:classId/:featId')
  async assignClassFeat(@Param('classId') classId: string, @Param('featId') featId: string) {
    try {
      return await this.classesService.assignClassFeat(classId, featId);
    } catch (error) {
      throw new Error(error);
    }
  }

  @Get('get-feats/:classId')
  async getClassFeats(@Param('classId') classId: string) {
    try {
      return await this.classesService.getClassFeats(classId);
    } catch (error) {
      throw new Error(error);
    }
  }
}
