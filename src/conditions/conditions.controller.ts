import { Body, Controller, Get, Post } from '@nestjs/common';
import { ConditionsService } from './conditions.service';
import { CreateConditionDTO } from './dto/create.condition.dto';

@Controller('conditions')
export class ConditionsController {
  constructor(private readonly conditionsService: ConditionsService) {}

  @Post()
  async create(@Body() data: CreateConditionDTO) {
    try {
      return this.conditionsService.createCondition(data);
    } catch (error) {
      throw new Error('Error creating condition');
    }
  }

  @Get()
  async findAll() {
    return this.conditionsService.getConditions();
  }
}
