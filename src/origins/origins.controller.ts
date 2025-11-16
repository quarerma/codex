import { Body, Controller, Get, Post, UseGuards } from '@nestjs/common';
import { OriginsService } from './origins.service';
import { JwtAuthGuard } from 'src/auth/guards/jwt.guards';
import { CreateOriginDTO } from './dto/crete.origin.dto';

@Controller('origins')
export class OriginsController {
  constructor(private readonly originsService: OriginsService) {}

  @Post()
  @UseGuards(JwtAuthGuard)
  async createOrigin(@Body() data: CreateOriginDTO) {
    try {
      return await this.originsService.createOrigin(data);
    } catch (error) {
      throw new Error('Error creating origin');
    }
  }

  @Get()
  @UseGuards(JwtAuthGuard)
  async getOrigins() {
    try {
      return await this.originsService.getOrigins();
    } catch (error) {
      throw new Error('Error getting origins');
    }
  }
}
