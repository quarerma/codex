import { Body, Controller, Get, Param, Post, Req, UseGuards } from '@nestjs/common';
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
    try {
      const user = req.user as UserRequest;
      return await this.campaingsService.createCampaign(data, user.id);
    } catch (error) {
      throw error;
    }
  }

  @Get('players/:id')
  @UseGuards(JwtAuthGuards)
  async getCampaignPlayers(@Param('id') id: string) {
    try {
      return await this.campaingsService.getCampaignPlayers(id);
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

  @Get('campaign-characters/:id')
  @UseGuards(JwtAuthGuards)
  async getCampaignCharacters(@Param('id') id: string) {
    try {
      return await this.campaingsService.getCampaignCharacters(id);
    } catch (error) {
      throw error;
    }
  }

  @Get('byId/:id')
  @UseGuards(JwtAuthGuards)
  async getCampaignById(@Param('id') id: string) {
    try {
      return await this.campaingsService.getCampaignById(id);
    } catch (error) {
      throw error;
    }
  }
  @Get('campaign-feats/:id')
  @UseGuards(JwtAuthGuards)
  async getCampaignFeats(@Param('id') id: string) {
    try {
      return await this.customFeatsService.getCampaignCustomFeats(id);
    } catch (error) {
      throw error;
    }
  }

  @Post('campaign-feats/:id')
  @UseGuards(JwtAuthGuards)
  async createCampaignFeat(@Param('id') id: string, @Body() data: CreateFeatDto) {
    try {
      return await this.customFeatsService.createCustomFeat(data, id);
    } catch (error) {
      throw error;
    }
  }

  @Post('campaign-equips/:id')
  @UseGuards(JwtAuthGuards)
  async getCampaignEquips(@Param('id') id: string, @Body() data: CreateItemDto) {
    try {
      return await this.customItemsService.createCustomCampaignItem(data, id);
    } catch (error) {
      throw error;
    }
  }

  @Get('campaign-equips/:id')
  @UseGuards(JwtAuthGuards)
  async createCampaignEquip(@Param('id') id: string) {
    try {
      return await this.customItemsService.getCampaignCustomItems(id);
    } catch (error) {
      throw error;
    }
  }

  @Post('campaign-rituals/:id')
  @UseGuards(JwtAuthGuards)
  async createCampaignRitual(@Param('id') id: string, @Body() data: CreateRitualDto) {
    try {
      return await this.customRitualsService.createCustomRitual(id, data);
    } catch (error) {
      throw error;
    }
  }

  @Get('campaign-rituals/:id')
  @UseGuards(JwtAuthGuards)
  async getCampaignRituals(@Param('id') id: string) {
    try {
      return await this.customRitualsService.getCampaignCustomRituals(id);
    } catch (error) {
      throw error;
    }
  }

  @Post('campaign-skills/:id')
  @UseGuards(JwtAuthGuards)
  async createCampaignSkill(@Param('id') id: string, @Body() data: CreateSkillDTO) {
    try {
      return await this.customSkillService.createCustomSkill(data, id);
    } catch (error) {
      throw error;
    }
  }

  @Get('campaign-skills/:id')
  @UseGuards(JwtAuthGuards)
  async getCampaignSkills(@Param('id') id: string) {
    try {
      return await this.customSkillService.getCampaignCustomSkills(id);
    } catch (error) {
      throw error;
    }
  }
}
