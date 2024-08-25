import { Controller, Post, Body, HttpException, HttpStatus, Get, UseGuards, Req } from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { EmailAlreadyInUseExcption, UserNameAlreadyInUseException } from 'src/exceptions/UserExceptions';
import { JwtAuthGuards } from 'src/auth/guards/jwt.guards';
import { Request } from 'express';
import { UserRequest } from './dto/user-request';

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

  @Get()
  @UseGuards(JwtAuthGuards)
  async getUserById(@Req() req: Request) {
    try {
      console.log('fez');
      const user = req.user as UserRequest;
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
  @UseGuards(JwtAuthGuards)
  async getAllUsers(@Req() req: Request) {
    try {
      const user = req.user as UserRequest;
      if (user.role !== 'ADMIN') {
        throw new HttpException(
          {
            status: 'userError',
            message: 'Usuário não autorizado',
          },
          HttpStatus.UNAUTHORIZED,
        );
      }
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
}
