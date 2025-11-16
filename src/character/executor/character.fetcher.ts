import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';

@Injectable()
export class CharacterFetcher {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async fetchCharacterBasicisById(character_id: string) {
    try {
      return await this.dataBaseService.character.findUnique({
        where: { id: character_id },
        select: {
          id: true,
          name: true,
          ownerId: true,
          campaignId: true,
          privacy_level: true,
        },
      });
    } catch (error) {
      throw error;
    }
  }
}
