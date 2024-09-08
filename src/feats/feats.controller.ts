import { Body, Controller, Get, HttpException, Post } from '@nestjs/common';
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
}
