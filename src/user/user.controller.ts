import { Controller, Post, Body, HttpException, HttpStatus, Get, UseGuards, Req } from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { EmailAlreadyInUseExcption, UserNameAlreadyInUseException } from 'src/exceptions/UserExceptions';
import { JwtAuthGuards } from 'src/auth/guards/jwt.guards';
import { Request } from 'express';
import { UserRequest } from './dto/user-request';
import { RolesGuard } from 'src/auth/guards/role.guard';
import { Role } from '@prisma/client';
import { Roles } from 'src/auth/dto/role.decorator';
import { CurrentUser } from 'src/middleware/current-user.decorator';

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post('create')
  async createUser(@Body() data: CreateUserDto) {
    try {
      return await this.userService.createUser(data);
    } catch (error) {
      if (error instanceof UserNameAlreadyInUseException) {
        throw new HttpException(
          {
            status: 'nameError',
            message: 'Nome já existente',
          },
          HttpStatus.CONFLICT,
        );
      }
      if (error instanceof EmailAlreadyInUseExcption) {
        throw new HttpException(
          {
            status: 'emailError',
            message: 'Email já conectado a uma conta',
          },
          HttpStatus.CONFLICT,
        );
      }
    }
  }

  @Get('session')
  @UseGuards(JwtAuthGuards)
  async getSession(@CurrentUser() user: UserRequest) {
    try {
      return await this.userService.getUserById(user.id);
    } catch (error) {
      throw new HttpException(
        {
          status: 'userError',
          message: 'Usuário não encontrado',
        },
        HttpStatus.NOT_FOUND,
      );
    }
  }

  @Get('all')
  @UseGuards(JwtAuthGuards, RolesGuard)
  @Roles(Role.ADMIN)
  async getAllUsers(@CurrentUser() user: UserRequest) {
    try {
      return await this.userService.getAllUsers(user);
    } catch (error) {
      throw new HttpException(
        {
          status: 'userError',
          message: 'Usuários não encontrados',
        },
        HttpStatus.NOT_FOUND,
      );
    }
  }

  @Get('campaigns')
  @UseGuards(JwtAuthGuards)
  async getUserCampaigns(@Req() req: Request) {
    try {
      const user = req.user as UserRequest;
      return await this.userService.getUserCampaigns(user.id);
    } catch (error) {
      throw new HttpException(
        {
          status: 'userError',
          message: 'Usuário não encontrado',
        },
        HttpStatus.NOT_FOUND,
      );
    }
  }

  @Get('campaigns-player')
  @UseGuards(JwtAuthGuards)
  async getUserCampaignsPlayer(@Req() req: Request) {
    try {
      const user = req.user as UserRequest;
      return await this.userService.getUserCampaignsAsPlayer(user.id);
    } catch (error) {
      throw new HttpException(
        {
          status: 'userError',
          message: 'Usuário não encontrado',
        },
        HttpStatus.NOT_FOUND,
      );
    }
  }

  @Get('characters')
  @UseGuards(JwtAuthGuards)
  async getUserCharacters(@Req() req: Request) {
    try {
      const user = req.user as UserRequest;
      return await this.userService.getUserCharacters(user.id);
    } catch (error) {
      throw new HttpException(
        {
          status: 'userError',
          message: 'Usuário não encontrado',
        },
        HttpStatus.NOT_FOUND,
      );
    }
  }
}
