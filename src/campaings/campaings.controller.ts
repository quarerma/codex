import { Body, Controller, Get, Post, Query, Req, UseGuards } from '@nestjs/common';
import { CampaingsService } from './campaings.service';
import { JwtAuthGuards } from 'src/auth/guards/jwt.guards';
import { CreateCampaignDTO } from './dto/create-campaign-dto';
import { UserRequest } from 'src/user/dto/user-request';
import { Request } from 'express';
import { CustomFeatService } from './aux_services/custom.feat.service';
import { CreateFeatDto } from 'src/feats/dto/create-feat-dto';
import { CustomItemService } from './aux_services/custom.item.service';
import { CustomRitualService } from './aux_services/custom.ritual.service';
import { CustomSkillService } from './aux_services/custom.skill.service';
import { CreateItemDto } from 'src/equipment/dto/create.equipment.dto';
import { CreateRitualDto } from 'src/ritual/dto/create.ritual';
import { CreateSkillDTO } from 'src/skill/dto/create.skill.dto';

@Controller('campaigns')
export class CampaingsController {
  constructor(
    private readonly campaingsService: CampaingsService,
    private readonly customFeatsService: CustomFeatService,
    private readonly customItemsService: CustomItemService,
    private readonly customRitualsService: CustomRitualService,
    private readonly customSkillService: CustomSkillService,
  ) {}

  @Post('create')
  @UseGuards(JwtAuthGuards)
  async createCampaign(@Body() data: CreateCampaignDTO, @Req() req: Request) {
    const user = req.user as UserRequest;
    return this.campaingsService.createCampaign(data, user.id);
  }

  @Get('players')
  @UseGuards(JwtAuthGuards)
  async getCampaignPlayers(@Query('id') id: string) {
    return this.campaingsService.getCampaignPlayers(id);
  }

  @Post('join')
  @UseGuards(JwtAuthGuards)
  async joinCampaign(@Body() data: { campaignId: string; password: string }, @Req() req: Request) {
    const user = req.user as UserRequest;
    return this.campaingsService.joinCampaign(data, user.id);
  }

  @Get('characters')
  @UseGuards(JwtAuthGuards)
  async getCampaignCharacters(@Query('id') id: string) {
    return this.campaingsService.getCampaignCharacters(id);
  }

  @Get('byId')
  @UseGuards(JwtAuthGuards)
  async getCampaignById(@Query('id') id: string) {
    return this.campaingsService.getCampaignById(id);
  }

  @Get('feats')
  @UseGuards(JwtAuthGuards)
  async getCampaignFeats(@Query('id') id: string) {
    return this.customFeatsService.getCampaignCustomFeats(id);
  }

  @Post('feats')
  @UseGuards(JwtAuthGuards)
  async createCampaignFeat(@Query('id') id: string, @Body() data: CreateFeatDto) {
    return this.customFeatsService.createCustomFeat(data, id);
  }

  @Post('equips')
  @UseGuards(JwtAuthGuards)
  async createCampaignEquip(@Query('id') id: string, @Body() data: CreateItemDto) {
    return this.customItemsService.createCustomCampaignItem(data, id);
  }

  @Get('equips')
  @UseGuards(JwtAuthGuards)
  async getCampaignEquips(@Query('id') id: string) {
    return this.customItemsService.getCampaignCustomItems(id);
  }

  @Post('rituals')
  @UseGuards(JwtAuthGuards)
  async createCampaignRitual(@Query('id') id: string, @Body() data: CreateRitualDto) {
    return this.customRitualsService.createCustomRitual(id, data);
  }

  @Get('rituals')
  @UseGuards(JwtAuthGuards)
  async getCampaignRituals(@Query('id') id: string) {
    return this.customRitualsService.getCampaignCustomRituals(id);
  }

  @Post('skills')
  @UseGuards(JwtAuthGuards)
  async createCampaignSkill(@Query('id') id: string, @Body() data: CreateSkillDTO) {
    return this.customSkillService.createCustomSkill(data, id);
  }

  @Get('skills')
  @UseGuards(JwtAuthGuards)
  async getCampaignSkills(@Query('id') id: string) {
    return this.customSkillService.getCampaignCustomSkills(id);
  }
}
