import { Body, Controller, Get, Post } from '@nestjs/common';
import { RitualService } from './ritual.service';
import { CreateRitualDto } from './dto/create.ritual';

@Controller('ritual')
export class RitualController {
  constructor(private readonly ritualService: RitualService) {}

  @Post()
  async create(@Body() data: CreateRitualDto) {
    try {
      return this.ritualService.create(data);
    } catch (error) {
      throw new Error('Error creating custom ritual');
    }
  }

  @Get()
  async findAll() {
    return this.ritualService.getCoreRituals();
  }
}
