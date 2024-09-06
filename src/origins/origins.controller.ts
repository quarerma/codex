import { Body, Controller, Get, Post, UseGuards } from '@nestjs/common';
import { OriginsService } from './origins.service';
import { JwtAuthGuards } from 'src/auth/guards/jwt.guards';
import { CreateOriginDTO } from './dto/crete.origin.dto';

@Controller('origins')
export class OriginsController {
  constructor(private readonly originsService: OriginsService) {}

  @Post()
  @UseGuards(JwtAuthGuards)
  async createOrigin(@Body() data: CreateOriginDTO) {
    try {
      console.log(data);
      return await this.originsService.createOrigin(data);
    } catch (error) {
      throw new Error('Error creating origin');
    }
  }

  @Get()
  @UseGuards(JwtAuthGuards)
  async getOrigins() {
    try {
      console.log('get origins');
      return await this.originsService.getOrigins();
    } catch (error) {
      throw new Error('Error getting origins');
    }
  }
}
