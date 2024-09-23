import { Body, Controller, Post, Get, Query } from '@nestjs/common';
import { SkillService } from './skill.service';
import { CreateSkillDTO } from './dto/create.skill.dto';

@Controller('skill')
export class SkillController {
  constructor(private readonly skillService: SkillService) {}

  @Post()
  async createSkill(@Body() data: CreateSkillDTO) {
    try {
      return await this.skillService.createSkill(data);
    } catch (error) {
      throw new Error('Error creating skill');
    }
  }

  @Get()
  async getNonCustomSkills() {
    try {
      return await this.skillService.getNonCustomSkills();
    } catch (error) {
      throw new Error('Error getting non custom skills');
    }
  }

  @Get('byName')
  async getSkillByName(@Query('name') name: string) {
    try {
      return await this.skillService.getSkillByName(name);
    } catch (error) {
      throw new Error('Error getting skill by name');
    }
  }
}
