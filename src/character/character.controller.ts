import { Body, Controller, Delete, Get, Patch, Post, Query } from '@nestjs/common';
import { CharacterService } from './character.service';
import { CreateCharacterDTO } from './dto/create-character-dto';
import { CharacterFeatsService } from './aux_services/character.feats.service';
import { CharacterRitualsService } from './aux_services/character.rituals.service';
import { CharacterLevelService } from './aux_services/character.level.service';

@Controller('character')
export class CharacterController {
  constructor(
    private readonly characterService: CharacterService,
    private readonly characterFeatsService: CharacterFeatsService,
    private readonly characterRitualsService: CharacterRitualsService,
    private readonly characterLevelService: CharacterLevelService,
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

  @Get()
  async getCharacter(@Query('id') id: string) {
    try {
      return await this.characterService.getCharacter(id);
    } catch (error) {
      throw new Error('Error getting character');
    }
  }

  @Delete()
  async deleteCharacter(@Query('id') id: string) {
    try {
      return await this.characterService.deleteCharacter(id);
    } catch (error) {
      throw new Error('Error deleting character');
    }
  }

  @Post('assign-feat')
  async assignFeat(@Query('characterId') characterId: string, @Query('featId') featId: string) {
    try {
      return await this.characterFeatsService.assignFeat(featId, characterId);
    } catch (error) {
      throw new Error('Error assigning feat');
    }
  }

  @Delete('remove-feat')
  async removeFeat(@Query('characterId') characterId: string, @Query('featId') featId: string) {
    try {
      return await this.characterFeatsService.removeFeat(characterId, featId);
    } catch (error) {
      throw new Error('Error removing feat');
    }
  }

  @Patch('use-affinity')
  async useAffinity(@Query('characterId') characterId: string, @Query('featId') featId: string) {
    try {
      return await this.characterFeatsService.useFeatAfinity(characterId, featId);
    } catch (error) {
      throw new Error('Error using affinity');
    }
  }

  @Patch('un-use-affinity')
  async unUseAffinity(@Query('characterId') characterId: string, @Query('featId') featId: string) {
    try {
      return await this.characterFeatsService.unCheckFeatAfinity(characterId, featId);
    } catch (error) {
      throw new Error('Error un-using affinity');
    }
  }

  @Post('assign-ritual')
  async assignRitual(@Query('characterId') characterId: string, @Query('ritualId') ritualId: string) {
    try {
      return await this.characterRitualsService.assignRitual(characterId, ritualId);
    } catch (error) {
      throw new Error('Error assigning ritual');
    }
  }

  @Delete('remove-ritual')
  async removeRitual(@Query('characterId') characterId: string, @Query('ritualId') ritualId: string) {
    try {
      return await this.characterRitualsService.removeRitual(characterId, ritualId);
    } catch (error) {
      throw new Error('Error removing ritual');
    }
  }

  @Patch('update-stat')
  async updateStat(@Query('characterId') characterId: string, @Query('stat') stat: string, @Query('value') value: string) {
    try {
      return await this.characterService.updateStat(characterId, stat, Number(value));
    } catch (error) {
      throw new Error('Error updating stat');
    }
  }

  @Patch('update-level')
  async updateLevel(@Query('characterId') characterId: string, @Query('newLevel') newLevel: string) {
    try {
      return await this.characterLevelService.updateCharacterLevel(characterId, Number(newLevel));
    } catch (error) {
      throw new Error('Error updating level');
    }
  }
}
