import { Body, Controller, Get, Param, Post, UseGuards } from '@nestjs/common';
import { SubClassService } from './rpg-subclass.service';
import { CreateSubClassDto } from './dto/create-subclass-dto';
import { JwtAuthGuards } from 'src/auth/guards/jwt.guards';
import { AssignFeatDto } from './dto/assign.feat.dto';

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

  @Post('assign-feat/:subclassId')
  async assignSubClassFeat(@Body() data: AssignFeatDto, @Param('subclassId') subclassId: string) {
    try {
      console.log(data);
      return await this.rpgSubclassService.assignSubClassFeat(subclassId, data.feat, data.levelRequired);
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
