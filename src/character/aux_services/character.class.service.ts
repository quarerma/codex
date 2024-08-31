import { Injectable } from '@nestjs/common';
import { Character, Class, Subclass } from '@prisma/client';
import { DataBaseService } from 'src/database/database.service';
import { CharacterFeatsService } from './character.feats';

@Injectable()
export class CharacterClassService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly characterFeatsService: CharacterFeatsService,
  ) {}

  async assignInitialClassAtributes(character_class: Class, character: Character) {
    try {
      for (const classFeats of character_class.initialFeats) {
        await this.characterFeatsService.assignFeat(character.id, classFeats);
      }
    } catch (error) {
      throw new Error(error.message);
    }
  }

  async assignInitialSubClassFeats(character_subclass: Subclass, character: Character) {
    try {
      const subclassFeats = await this.dataBaseService.subclassFeats.findMany({
        where: { subclassId: character_subclass.id },
        select: {
          feat: true,
          levelRequired: true,
        },
      });

      for (const subclassFeat of subclassFeats) {
        if (subclassFeat.levelRequired <= character.level) {
          await this.characterFeatsService.assignFeat(character.id, subclassFeat.feat.id);
        }
      }
    } catch (error) {
      throw new Error(error.message);
    }
  }
}
