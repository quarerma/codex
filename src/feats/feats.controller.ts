import { Body, Controller, Get, HttpException, Query, Post, HttpStatus } from '@nestjs/common';
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
      throw new HttpException(`Error creating general feat: ${error.message}`, HttpStatus.BAD_REQUEST);
    }
  }

  @Get('general-feat')
  async getGeneralFeats() {
    try {
      return await this.featsService.getGeneralFeats();
    } catch (error) {
      throw new HttpException(`Error retrieving general feats: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @Get('classes-feats')
  async getClassFeats() {
    try {
      return await this.featsService.getClassesFeats();
    } catch (error) {
      throw new HttpException(`Error retrieving class feats: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @Get('subclasses-feats')
  async getSubClassesFeats() {
    try {
      return await this.featsService.getSubClassesFeats();
    } catch (error) {
      throw new HttpException(`Error retrieving subclass feats: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @Get('filter-subclass-feats')
  async getSubClassFeats(@Query('subclassId') subclassId: string) {
    try {
      return await this.featsService.filterSubClassesFeats(subclassId);
    } catch (error) {
      throw new HttpException(`Error filtering subclass feats: ${error.message}`, HttpStatus.BAD_REQUEST);
    }
  }

  @Get('filter-class-feats')
  async filterClassFeats(@Query('classId') classId: string) {
    try {
      return await this.featsService.filterClassFeats(classId);
    } catch (error) {
      throw new HttpException(`Error filtering class feats: ${error.message}`, HttpStatus.BAD_REQUEST);
    }
  }

  @Get('non-custom-feats')
  async getAllFeats() {
    try {
      return await this.featsService.getNonCustomFeats();
    } catch (error) {
      throw new HttpException(`Error retrieving non-custom feats: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @Get('campaign-possible-feats')
  async getCampaignPossibleFeats(@Query('id') id: string) {
    try {
      return await this.featsService.getPossibleCampaignFeats(id);
    } catch (error) {
      throw new HttpException(`Error retrieving campaign possible feats: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }
}
