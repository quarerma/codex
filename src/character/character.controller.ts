import { Body, Controller, Post } from '@nestjs/common';
import { CharacterService } from './character.service';
import { CreateCharacterDTO } from './dto/create-character-dto';

@Controller('character')
export class CharacterController {
  constructor(private readonly characterService: CharacterService) {}

  @Post('create')
  async createCharacter(@Body() data: CreateCharacterDTO) {
    return await this.characterService.createCharacter(data);
  }
}
