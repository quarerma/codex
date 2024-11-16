import { Body, Controller, Get, Query, Post, HttpException, HttpStatus } from '@nestjs/common';
import { RitualService } from './ritual.service';
import { CreateRitualDto } from './dto/create.ritual';

@Controller('ritual')
export class RitualController {
  constructor(private readonly ritualService: RitualService) {}

  @Post()
  async create(@Body() data: CreateRitualDto) {
    try {
      return await this.ritualService.create(data);
    } catch (error) {
      throw new HttpException('Error creating custom ritual', HttpStatus.BAD_REQUEST);
    }
  }

  @Get()
  async findAll() {
    try {
      return await this.ritualService.getCoreRituals();
    } catch (error) {
      throw new HttpException('Error retrieving rituals', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @Get('campaign-possible-rituals')
  async getCampaignPossibleRituals(@Query('id') id: string) {
    try {
      return await this.ritualService.getPossibleCampaignRituals(id);
    } catch (error) {
      throw new HttpException('Error retrieving possible campaign rituals', HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }
}
