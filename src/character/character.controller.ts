import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { CharacterService } from './character.service';
import { CreateCharacterDTO } from './dto/create-character-dto';
import { CharacterFeatsService } from './aux_services/character.feats.service';
import { CharacterRitualsService } from './aux_services/character.rituals.service';

@Controller('character')
export class CharacterController {
  constructor(
    private readonly characterService: CharacterService,
    private readonly characterFeatsService: CharacterFeatsService,
    private readonly characterRitualsService: CharacterRitualsService,
  ) {}

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

  @Delete('/:id')
  async deleteCharacter(@Param('id') id: string) {
    try {
      return await this.characterService.deleteCharacter(id);
    } catch (error) {
      throw new Error('Error deleting character');
    }
  }

  @Post('assign-feat/:characterId/:featId')
  async assignFeat(@Param('featId') featId: string, @Param('characterId') characterId: string) {
    try {
      return await this.characterFeatsService.assignFeat(featId, characterId);
    } catch (error) {
      throw new Error('Error assigning feat');
    }
  }

  @Delete('remove-feat/:characterId/:featId')
  async removeFeat(@Param('featId') featId: string, @Param('characterId') characterId: string) {
    try {
      return await this.characterFeatsService.removeFeat(characterId, featId);
    } catch (error) {
      throw new Error('Error removing feat');
    }
  }

  @Patch('use-affinity/:characterId/:featId')
  async useAffinity(@Param('featId') featId: string, @Param('characterId') characterId: string) {
    try {
      return await this.characterFeatsService.useFeatAfinity(characterId, featId);
    } catch (error) {
      throw new Error('Error using affinity');
    }
  }

  @Patch('un-use-affinity/:characterId/:featId')
  async unUseAffinity(@Param('featId') featId: string, @Param('characterId') characterId: string) {
    try {
      return await this.characterFeatsService.unCheckFeatAfinity(characterId, featId);
    } catch (error) {
      throw new Error('Error un-using affinity');
    }
  }

  @Post('assign-ritual/:characterId/:ritualId')
  async assignRitual(@Param('ritualId') ritualId: string, @Param('characterId') characterId: string) {
    try {
      return await this.characterRitualsService.assignRitual(characterId, ritualId);
    } catch (error) {
      throw new Error('Error assigning ritual');
    }
  }

  @Delete('remove-ritual/:characterId/:ritualId')
  async removeRitual(@Param('ritualId') ritualId: string, @Param('characterId') characterId: string) {
    try {
      return await this.characterRitualsService.removeRitual(characterId, ritualId);
    } catch (error) {
      throw new Error('Error removing ritual');
    }
  }

  @Patch('update-stat/:characterId/:stat/:value')
  async updateStat(@Param('characterId') characterId: string, @Param('stat') stat: string, @Param('value') value: string) {
    try {
      return await this.characterService.updateStat(characterId, stat, Number(value));
    } catch (error) {
      throw new Error('Error updating stat');
    }
  }
}
