import { Body, Controller, Post, Get } from '@nestjs/common';
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
}
