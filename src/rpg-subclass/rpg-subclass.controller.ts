import { Body, Controller, Get, Patch, Post, UseGuards } from '@nestjs/common';
import { SubClassService } from './rpg-subclass.service';
import { CreateSubClassDto } from './dto/create-subclass-dto';
import { JwtAuthGuards } from 'src/auth/guards/jwt.guards';

@Controller('rpg-subclass')
export class SubClassController {
  constructor(private readonly rpgSubclassService: SubClassService) {}

  @Post()
  async createSubClass(@Body() data: CreateSubClassDto) {
    try {
      return await this.rpgSubclassService.createSubClass(data);
    } catch (error) {
      throw new Error('Error creating subclass');
    }
  }

  @Patch('assign-feat/:subclassId/:featId')
  async assignSubClassFeat(@Body() levelrequired: number, subclassId: string, featId: string) {
    try {
      return await this.rpgSubclassService.assignSubClassFeat(subclassId, featId, levelrequired);
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

  @Get()
  @UseGuards(JwtAuthGuards)
  async getAllSubclasses() {
    try {
      return await this.rpgSubclassService.getAllSubclasses();
    } catch (error) {
      throw new Error(error);
    }
  }
}
