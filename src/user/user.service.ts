import { HttpException, Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import * as bcrypt from 'bcrypt';
import { EmailAlreadyInUseExcption, UserNameAlreadyInUseException } from 'src/exceptions/UserExceptions';
import { DataBaseService } from 'src/database/database.service';
import { UserRequest } from './dto/user-request';
import { UserSessionExecutor } from './executor/session.executor';
import { CacheService } from 'src/cache/cache.service';

@Injectable()
export class UserService {
  constructor(
    private dataBaseService: DataBaseService,
    private readonly cacheService: CacheService,
    private readonly sessionExecutor: UserSessionExecutor,
  ) {}

  async createUser(data: CreateUserDto) {
    try {
      const { password, ...userDataWithoutPassword } = data;
      const hashPassword = await this.hashPassword(password);

      const userData = { ...userDataWithoutPassword };

      await this.checkEmailAlreadyInUse(userData.email);

      await this.checkExistingUser(userData.username);

      return await this.dataBaseService.user.create({
        data: { ...userData, password: hashPassword },
        select: {
          username: true,
          id: true,
          role: true,
        },
      });
    } catch (error) {
      if (error instanceof UserNameAlreadyInUseException) {
        throw new UserNameAlreadyInUseException();
      }
      if (error instanceof EmailAlreadyInUseExcption) {
        throw new EmailAlreadyInUseExcption();
      } else {
        console.log('"nao foi possivel criar o usuario"');
      }
    }
  }

  async hashPassword(password: string) {
    const saltOrRounds = await bcrypt.genSalt();
    const hash = await bcrypt.hash(password, saltOrRounds);

    return hash;
  }

  async checkExistingUser(username: string) {
    const user = await this.dataBaseService.user.findUnique({
      where: { username: username },
    });

    if (user) {
      throw new UserNameAlreadyInUseException();
    }
  }

  async checkEmailAlreadyInUse(email: string): Promise<void> {
    const user = await this.dataBaseService.user.findUnique({
      where: { email: email },
    });

    if (user) {
      throw new EmailAlreadyInUseExcption();
    }
  }

  async getUserById(id: string) {
    try {
      const user = await this.cacheService.getCached('session', [`${id}`], async () => await this.sessionExecutor.execute(id), 30 * 60 * 1000);

      if (!user) {
        throw new Error('User not found');
      }

      // eslint-disable-next-line @typescript-eslint/no-unused-vars

      return user;
    } catch (error) {
      console.log('erro ao buscar usuario por id');
    }
  }

  async getAllUsers(user: UserRequest) {
    try {
      const userRole = await this.dataBaseService.user.findUnique({
        where: { id: user.id },
        select: {
          role: true,
        },
      });

      if (userRole.role !== 'ADMIN') {
        throw new HttpException(
          {
            status: 'userError',
            message: 'Usuário não autorizado',
          },
          401,
        );
      }
      return await this.dataBaseService.user.findMany({
        select: {
          username: true,
          id: true,
          role: true,
          email: true,
        },
      });
    } catch (error) {
      console.log('erro ao buscar todos os usuarios');
    }
  }

  async getUserCampaigns(userId: string) {
    try {
      const campaigns = await this.dataBaseService.user.findUnique({
        where: { id: userId },
        select: {
          campaigns_dm: {
            select: {
              id: true,
              createdAt: true,
              name: true,
              description: true,
              owner: {
                select: {
                  id: true,
                  username: true,
                },
              },
            },
          },
          campaigns_player: {
            select: {
              campaign: {
                select: {
                  id: true,
                  createdAt: true,
                  name: true,
                  description: true,
                  owner: {
                    select: {
                      id: true,
                      username: true,
                    },
                  },
                },
              },
            },
          },
        },
      });

      // join campaigns
      const playerCampaigns = campaigns.campaigns_player.map((campaign) => campaign.campaign);
      const dmCampaigns = campaigns.campaigns_dm;

      // concat campaigns
      const allCampaigns = [...playerCampaigns, ...dmCampaigns];

      return allCampaigns;
    } catch (error) {
      console.log('erro ao buscar campanhas do usuario');
    }
  }

  async getUserCampaignsAsPlayer(userId: string) {
    try {
      const campaigns = await this.dataBaseService.user.findUnique({
        where: { id: userId },
        select: {
          campaigns_player: {
            select: {
              campaign: {
                select: {
                  id: true,
                  createdAt: true,
                  name: true,
                  description: true,
                  owner: {
                    select: {
                      id: true,
                      username: true,
                    },
                  },
                },
              },
            },
          },
        },
      });

      return campaigns.campaigns_player.map((campaign) => campaign.campaign);
    } catch (error) {
      console.log('erro ao buscar campanhas do usuario');
    }
  }

  async getUserCharacters(userId: string) {
    try {
      return await this.dataBaseService.character.findMany({
        where: { ownerId: userId },
        include: {
          campaign: {
            select: {
              id: true,
              name: true,
            },
          },
          rituals: {
            select: {
              ritual: true,
              ritual_cost: true,
            },
          },
          class: {
            select: {
              name: true,
              id: true,
            },
          },
          subclass: {
            select: {
              name: true,
              id: true,
            },
          },
          owner: {
            select: {
              id: true,
              username: true,
            },
          },
          feats: {
            select: {
              feat: true,
              usingAfinity: true,
            },
          },
          origin: {
            include: {
              feats: true,
            },
          },
        },
      });
    } catch (error) {
      console.log('erro ao buscar personagens do usuario');
    }
  }
}
