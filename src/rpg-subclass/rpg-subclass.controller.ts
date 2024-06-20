import { Controller, Get, Patch, Post } from '@nestjs/common';
import { SubClassService } from './rpg-subclass.service';
import { CreateSubClassDto } from './dto/create-subclass-dto';

@Controller('rpg-subclass')
export class SubClassController {
  constructor(private readonly rpgSubclassService: SubClassService) {}

  @Post()
  async createSubClass(data: CreateSubClassDto) {
    try {
      return await this.rpgSubclassService.createSubClass(data);
    } catch (error) {
      throw new Error('Error creating subclass');
    }
  }

  @Patch('assign-feat/:subclassId/:featId')
  async assignSubClassFeat(subclassId: string, featId: string) {
    try {
      return await this.rpgSubclassService.assignSubClassFeat(subclassId, featId);
    } catch (error) {
      throw new Error(error);
    }
  }

  @Get('get-feats/:subclassId')
  async getSubClassesFeats(subclassId: string) {
    try {
      return await this.rpgSubclassService.getSubClassesFeats(subclassId);
    } catch (error) {
      throw new Error(error);
    }
  }
}
