import { Body, Controller, Get, Query, Post, UseGuards, HttpException, HttpStatus } from '@nestjs/common';
import { ClassesService } from './classes.service';
import { CreateClassDTO } from './dto/create-class-dto';
import { JwtAuthGuard } from 'src/auth/guards/jwt.guards';
import { CreateFeatDto } from 'src/feats/dto/create-feat-dto';

@Controller('classes')
export class ClassesController {
  constructor(private readonly classesService: ClassesService) {}

  @Get()
  @UseGuards(JwtAuthGuard)
  async getClasses() {
    try {
      return await this.classesService.getClasses();
    } catch (error) {
      throw new HttpException('Error getting classes', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  async createClass(@Body() data: CreateClassDTO) {
    try {
      return await this.classesService.createClass(data);
    } catch (error) {
      throw new HttpException('Error creating class', HttpStatus.BAD_REQUEST);
    }
  }

  @Post('assign-initial-feat')
  async assignClassFeat(@Query('classId') classId: string, @Body() feat: CreateFeatDto) {
    try {
      return await this.classesService.createInitialClassFeat(classId, feat);
    } catch (error) {
      throw new HttpException(`Error assigning initial feat: ${error.message}`, HttpStatus.BAD_REQUEST);
    }
  }

  @Post('assign-feat')
  async assignFeat(@Query('classId') classId: string, @Body() feat: CreateFeatDto) {
    try {
      return await this.classesService.createClassFeat(feat, classId);
    } catch (error) {
      throw new HttpException(`Error assigning feat: ${error.message}`, HttpStatus.BAD_REQUEST);
    }
  }

  @Get('get-feats')
  async getClassFeats(@Query('classId') classId: string) {
    try {
      return await this.classesService.getClassFeats(classId);
    } catch (error) {
      throw new HttpException(`Error getting class feats: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @Get('initial-feats')
  async getInitialFeats(@Query('classId') classId: string) {
    try {
      return await this.classesService.getInitialFeats(classId);
    } catch (error) {
      throw new HttpException(`Error getting initial feats: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @Get('/subclasses')
  @UseGuards(JwtAuthGuard)
  async getSubClasses(@Query('classId') classId: string) {
    try {
      return await this.classesService.getSubClasses(classId);
    } catch (error) {
      throw new HttpException(`Error getting subclasses: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }
}
