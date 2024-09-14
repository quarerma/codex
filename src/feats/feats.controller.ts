import { Body, Controller, Get, HttpException, Param, Post } from '@nestjs/common';
import { FeatsService } from './feats.service';
import { CreateFeatDto } from './dto/create-feat-dto';

@Controller('feats')
export class FeatsController {
  constructor(private readonly featsService: FeatsService) {}

  @Post('general-feat')
  async createGeneralFeat(@Body() data: CreateFeatDto) {
    try {
      return await this.featsService.createGeneralFeat(data);
    } catch (error) {
      throw new HttpException(error.message, error.status);
    }
  }

  @Get('general-feat')
  async getGeneralFeats() {
    return await this.featsService.getGeneralFeats();
  }

  @Get('classes-feats')
  async getClassFeats() {
    return await this.featsService.getClassesFeats();
  }

  @Get('subclasses-feats')
  async getSubClassesFeats() {
    return await this.featsService.getSubClassesFeats();
  }

  @Get('filter-subclass-feats/:subclassId')
  async getSubClassFeats(@Param('subclassId') subclassId: string) {
    return await this.featsService.filterSubClassesFeats(subclassId);
  }

  @Get('filter-class-feats/:classId')
  async filterClassFeats(@Param('classId') classId: string) {
    return await this.featsService.filterClassFeats(classId);
  }

  @Get('non-custom-feats')
  async getAllFeats() {
    try {
      const feats = await this.featsService.getNonCustomFeats();
      console.log(feats);
      return feats;
    } catch (error) {
      throw new HttpException(error.message, error.status);
    }
  }
}
