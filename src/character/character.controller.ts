import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { CharacterService } from './character.service';
import { CreateCharacterDTO } from './dto/create-character-dto';

@Controller('character')
export class CharacterController {
  constructor(private readonly characterService: CharacterService) {}

  @Post('create')
  async createCharacter(@Body() data: CreateCharacterDTO) {
    try {
      console.log(data);
      return await this.characterService.createCharacter(data);
    } catch (error) {
      console.log(error);
      throw new Error('Error creating character');
    }
  }

  @Get('/:id')
  async getCharacter(@Param('id') id: string) {
    try {
      return await this.characterService.getCharacter(id);
    } catch (error) {
      throw new Error('Error getting character');
    }
  }
}
