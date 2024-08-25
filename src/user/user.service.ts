import { HttpException, Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import * as bcrypt from 'bcrypt';
import { EmailAlreadyInUseExcption, UserNameAlreadyInUseException } from 'src/exceptions/UserExceptions';
import { DataBaseService } from 'src/database/database.service';
import { UserRequest } from './dto/user-request';

@Injectable()
export class UserService {
  constructor(private dataBaseService: DataBaseService) {}

  async createUser(data: CreateUserDto) {
    try {
      const { password, ...userDataWithoutPassword } = data;
      const hashPassword = await this.hashPassword(password);

      const userData = { ...userDataWithoutPassword };

      await this.checkEmailAlreadyInUse(userData.email);

      console.log('username', userData.username);
      await this.checkExistingUser(userData.username);

      return await this.dataBaseService.user.create({
        data: { ...userData, password: hashPassword },
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
      const user = await this.dataBaseService.user.findUnique({
        where: { id },
        select: {
          username: true,
          id: true,
          role: true,
        },
      });

      console.log('user', user);
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
        },
      });
    } catch (error) {
      console.log('erro ao buscar todos os usuarios');
    }
  }

  async joinCampaign(userId: string, campaignId: string) {
    try {
      return this.dataBaseService.playerOnCampaign.create({
        data: {
          player: {
            connect: { id: userId },
          },
          campaign: {
            connect: { id: campaignId },
          },
        },
      });
    } catch (error) {
      console.log('erro ao conectar usuario a campanha');
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

  async leaveCampaign(userId: string, campaignId: string) {
    // TODO delete character
    try {
      const participation = await this.dataBaseService.playerOnCampaign.findUnique({
        where: {
          campaignId_playerId: {
            campaignId: campaignId,
            playerId: userId,
          },
        },
      });

      if (!participation) {
        throw new Error('User is not in this campaign');
      }
      await this.dataBaseService.playerOnCampaign.delete({
        where: {
          campaignId_playerId: {
            campaignId: campaignId,
            playerId: userId,
          },
        },
      });
    } catch (error) {
      console.log('Error leaving the campaign:', error.message);
    }
  }
}
