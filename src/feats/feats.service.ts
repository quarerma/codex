import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { CreateFeatDto } from './dto/create-feat-dto';

@Injectable()
export class FeatsService {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async createGeneralFeat(data: CreateFeatDto) {
    try {
      const created = await this.dataBaseService.generalFeats.create({
        data: {
          feat: {
            create: {
              afinityUpgrades: data.afinityUpgrades,
              afinity: data.afinity,
              name: data.name,
              description: data.description,
              prerequisites: data.prerequisites,
              characterUpgrades: data.characterUpgrade,
              type: 'GENERAL',
              element: data.element,
            },
          },
        },
        select: {
          feat: {
            select: {
              id: true,
              name: true,
              description: true,
              prerequisites: true,
              element: true,
              afinity: true,
              type: true,
            },
          },
        },
      });

      return created.feat;
    } catch (error) {
      throw new Error('Error creating general feat');
    }
  }

  async getGeneralFeats() {
    try {
      const general_feats = await this.dataBaseService.generalFeats.findMany({
        select: {
          feat: {
            select: {
              id: true,
              name: true,
              description: true,
              prerequisites: true,
              element: true,
              afinity: true,
              type: true,
            },
          },
        },
        orderBy: {
          feat: {
            name: 'asc',
          },
        },
      });

      return general_feats.map((feat) => feat.feat);
    } catch (error) {
      throw new Error('Error getting general feats');
    }
  }

  async getClassesFeats() {
    try {
      return await this.dataBaseService.feat.findMany({
        where: {
          type: 'CLASS',
          classFeats: {
            none: {
              isStarterFeat: true,
            },
          },
        },
        select: {
          id: true,
          name: true,
          description: true,
          prerequisites: true,
          element: true,
          type: true,
        },
        orderBy: {
          name: 'asc',
        },
      });
    } catch (error) {
      throw new Error('Error getting class feats');
    }
  }

  async getSubClassesFeats() {
    try {
      return await this.dataBaseService.feat.findMany({
        where: {
          type: 'SUBCLASS',
        },
        select: {
          id: true,
          name: true,
          description: true,
          prerequisites: true,
          element: true,
          type: true,
        },
        orderBy: {
          name: 'asc',
        },
      });
    } catch (error) {
      throw new Error('Error getting subclass feats');
    }
  }

  async filterSubClassesFeats(subclassId: string) {
    try {
      const feats = await this.dataBaseService.subclassFeats.findMany({
        where: {
          subclassId,
        },
        select: {
          feat: true,
        },
        orderBy: {
          feat: {
            name: 'asc',
          },
        },
      });

      return feats.map((feat) => feat.feat);
    } catch (error) {
      throw new Error('Error getting subclass feats');
    }
  }

  async filterClassFeats(classId: string) {
    try {
      const feats = await this.dataBaseService.classFeats.findMany({
        where: {
          classId,
          isStarterFeat: false,
        },
        select: {
          feat: true,
        },
        orderBy: {
          feat: {
            name: 'asc',
          },
        },
      });

      return feats.map((feat) => feat.feat);
    } catch (error) {
      throw new Error('Error getting class feats');
    }
  }
  async getNonCustomFeats() {
    try {
      return await this.dataBaseService.feat.findMany({
        where: {
          type: {
            not: 'CUSTOM',
          },
          classFeats: {
            none: {
              isStarterFeat: true,
            },
          },
        },
        select: {
          id: true,
          name: true,
          description: true,
          prerequisites: true,
          element: true,
          type: true,
        },
        orderBy: {
          name: 'asc',
        },
      });
    } catch (error) {
      throw new Error('Error getting non custom feats');
    }
  }

  async getPossibleCampaignFeats(campaignId: string) {
    try {
      return await this.dataBaseService.feat.findMany({
        where: {
          OR: [
            {
              type: 'CUSTOM',
              campaignFeats: {
                some: {
                  campaignId: campaignId,
                },
              },
            },
            {
              type: {
                not: 'CUSTOM',
              },
            },
          ],
          AND: {
            classFeats: {
              none: {
                isStarterFeat: true,
              },
            },
          },
        },
        select: {
          id: true,
          name: true,
          description: true,
          prerequisites: true,
          element: true,
          type: true,
        },
      });
    } catch (error) {
      throw new Error('Error getting possible campaign feats');
    }
  }
}
