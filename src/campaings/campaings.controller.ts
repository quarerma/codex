import { Body, Controller, Post, Req, UseGuards } from '@nestjs/common';
import { CampaingsService } from './campaings.service';
import { JwtAuthGuards } from 'src/auth/guards/jwt.guards';
import { CreateCampaignDTO } from './dto/create-campaign-dto';
import { UserRequest } from 'src/user/dto/user-request';
import { Request } from 'express';
@Controller('campaigns')
export class CampaingsController {
  constructor(private readonly campaingsService: CampaingsService) {}

  @Post('create')
  @UseGuards(JwtAuthGuards)
  async createCampaign(@Body() data: CreateCampaignDTO, @Req() req: Request) {
    try {
      const user = req.user as UserRequest;
      return await this.campaingsService.createCampaign(data, user.id);
    } catch (error) {
      throw error;
    }
  }

  @Post('join')
  @UseGuards(JwtAuthGuards)
  async joinCampaign(@Body() data: { campaignId: string; password: string }, @Req() req: Request) {
    try {
      const user = req.user as UserRequest;
      return await this.campaingsService.joinCampaign(data, user.id);
    } catch (error) {
      console.log('error', error);
      throw error;
    }
  }
}
