import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';

@Injectable()
export class CharacterRitualsService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async assignRitualsOnCreate(characterId: string, ritualsId: string[]) {
    try {
      if (!ritualsId) {
        return;
      }
      const rituals = await this.dataBaseService.ritual.findMany({
        where: { id: { in: ritualsId } },
      });

      for (const ritual of rituals) {
        let ritual_cost;

        switch (ritual.ritualLevel) {
          case 1:
            ritual_cost = 1;
            break;
          case 2:
            ritual_cost = 3;
            break;
          case 3:
            ritual_cost = 6;
            break;
          case 4:
            ritual_cost = 9;
            break;
        }

        await this.dataBaseService.characterRitual.create({
          data: {
            character: {
              connect: { id: characterId },
            },
            ritual: {
              connect: { id: ritual.id },
            },
            ritual_cost,
          },
        });
      }
    } catch (error) {
      throw new Error('Error assigning rituals');
    }
  }

  async assignRitual(characterId: string, ritualId: string) {
    try {
      const ritual = await this.dataBaseService.ritual.findUnique({
        where: { id: ritualId },
      });

      let ritual_cost;

      switch (ritual.ritualLevel) {
        case 1:
          ritual_cost = 1;
          break;
        case 2:
          ritual_cost = 3;
          break;
        case 3:
          ritual_cost = 6;
          break;
        case 4:
          ritual_cost = 9;
          break;
      }

      await this.dataBaseService.characterRitual.create({
        data: {
          character: {
            connect: { id: characterId },
          },
          ritual: {
            connect: { id: ritual.id },
          },
          ritual_cost,
        },
      });
    } catch (error) {
      throw new Error('Error assigning ritual');
    }
  }

  async removeRitual(characterId: string, ritualId: string) {
    try {
      await this.dataBaseService.characterRitual.deleteMany({
        where: { characterId, ritualId },
      });
    } catch (error) {
      throw new Error('Error removing ritual');
    }
  }
}
