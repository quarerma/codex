import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateSkillDTO } from './dto/create.skill.dto';

@Injectable()
export class SkillService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createSkill(data: CreateSkillDTO) {
    try {
      return await this.dataBaseService.skill.create({
        data,
      });
    } catch (error) {
      throw new Error('Error creating skill');
    }
  }

  async getNonCustomSkills() {
    try {
      return await this.dataBaseService.skill.findMany({
        where: {
          is_custom: false,
        },
      });
    } catch (error) {
      throw new Error('Error getting non custom skills');
    }
  }
}
