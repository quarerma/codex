import { Body, Controller, Get, Param, Post, UseGuards } from '@nestjs/common';
import { ClassesService } from './classes.service';
import { CreateClassDTO } from './dto/create-class-dto';
import { JwtAuthGuards } from 'src/auth/guards/jwt.guards';
import { CreateFeatDto } from 'src/feats/dto/create-feat-dto';

@Controller('classes')
export class ClassesController {
  constructor(private readonly classesService: ClassesService) {}

  @Get()
  @UseGuards(JwtAuthGuards)
  async getClasses() {
    try {
      return await this.classesService.getClasses();
    } catch (error) {
      throw new Error('Error getting classes');
    }
  }

  @Post()
  @UseGuards(JwtAuthGuards)
  async createClass(@Body() data: CreateClassDTO) {
    try {
      return await this.classesService.createClass(data);
    } catch (error) {
      throw new Error('Error creating class');
    }
  }

  @Post('assign-initial-feat/:classId')
  async assignClassFeat(@Param('classId') classId: string, @Body() feat: CreateFeatDto) {
    try {
      return await this.classesService.createInitialClassFeat(classId, feat);
    } catch (error) {
      throw new Error(error);
    }
  }

  @Post('assign-feat/:classId')
  async assignFeat(@Param('classId') classId: string, @Body() feat: CreateFeatDto) {
    try {
      return await this.classesService.createClassFeat(feat, classId);
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

  @Get('initial-feats/:classId')
  async getInitialFeats(@Param('classId') classId: string) {
    try {
      return await this.classesService.getInitialFeats(classId);
    } catch (error) {
      throw new Error(error);
    }
  }

  @Get('/subclasses/:classId')
  @UseGuards(JwtAuthGuards)
  async getSubClasses(@Param('classId') classId: string) {
    try {
      return await this.classesService.getSubClasses(classId);
    } catch (error) {
      throw new Error(error);
    }
  }
}
