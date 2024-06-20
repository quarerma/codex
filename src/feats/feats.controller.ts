import { Body, Controller, Get, Post } from '@nestjs/common';
import { FeatsService } from './feats.service';
import { CreateFeatDto } from './dto/create-feat-dto';

@Controller('feats')
export class FeatsController {
  constructor(private readonly featsService: FeatsService) {}

  @Post('general-feat')
  async createGeneralFeat(@Body() data: CreateFeatDto) {
    return await this.featsService.createGeneralFeat(data);
  }

  @Post('class-feat/:classId')
  async createClassFeat(@Body() data: CreateFeatDto, classId: string) {
    return await this.featsService.createClassFeat(data, classId);
  }

  @Post('subclass-feat/:subclassId')
  async createSubClassFeat(@Body() data: CreateFeatDto, subclassId: string) {
    return await this.featsService.createSubClassFeat(data, subclassId);
  }

  @Get('general-feat')
  async getGeneralFeats() {
    return await this.featsService.getGeneralFeats();
  }
}
