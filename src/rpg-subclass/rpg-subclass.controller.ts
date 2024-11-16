import { Body, Controller, Get, Post, UseGuards, Query, HttpException, HttpStatus } from '@nestjs/common';
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
      throw new HttpException('Error creating subclass', HttpStatus.BAD_REQUEST);
    }
  }

  @Post('assign-feat')
  async assignSubClassFeat(@Body() data: AssignFeatDto, @Query('subclassId') subclassId: string) {
    try {
      console.log(data);
      return await this.rpgSubclassService.assignSubClassFeat(subclassId, data.feat, data.levelRequired);
    } catch (error) {
      throw new HttpException(`Error assigning feat to subclass: ${error.message}`, HttpStatus.BAD_REQUEST);
    }
  }

  @Get('get-feats')
  async getSubClassesFeats(@Query('subclassId') subclassId: string) {
    try {
      return await this.rpgSubclassService.getSubClassesFeats(subclassId);
    } catch (error) {
      throw new HttpException(`Error getting subclass feats: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @Get()
  @UseGuards(JwtAuthGuards)
  async getAllSubclasses() {
    try {
      return await this.rpgSubclassService.getAllSubclasses();
    } catch (error) {
      throw new HttpException(`Error retrieving all subclasses: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }
}
