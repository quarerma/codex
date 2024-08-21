import { Controller, Post, Body, HttpException, HttpStatus, Get } from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto } from './dto/create-user.dto';
import { EmailAlreadyInUseExcption, UserNameAlreadyInUseException } from 'src/exceptions/UserExceptions';

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

  @Get(':id')
  async getUserById(@Body() id: string) {
    return await this.userService.getUserById(id);
  }
}
