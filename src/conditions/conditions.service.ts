import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateConditionDTO } from './dto/create.condition.dto';

@Injectable()
export class ConditionsService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createCondition(data: CreateConditionDTO) {
    try {
      return await this.dataBaseService.condition.create({
        data: {
          name: data.name,
          description: data.description,
          is_custom: false,
        },
      });
    } catch (error) {
      throw new Error('Error creating condition');
    }
  }

  async getConditions() {
    try {
      return await this.dataBaseService.condition.findMany();
    } catch (error) {
      throw new Error('Error getting conditions');
    }
  }
}
