import { Body, Controller, Get, HttpException, HttpStatus } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Get('/auth-login')
  async login(@Body() body: LoginDto) {
    try {
      const payload = await this.authService.login(body);

      if (payload === undefined) {
        throw new HttpException('Unauthorized', HttpStatus.UNAUTHORIZED);
      }

      return payload;
    } catch (error) {
      console.log(error);
      return { error: 'Error' };
    }
  }
}
