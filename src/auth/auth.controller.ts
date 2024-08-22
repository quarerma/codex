import { Body, Controller, HttpException, HttpStatus, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('/auth-login')
  async login(@Body() body: LoginDto) {
    try {
      const payload = await this.authService.login(body);

      if (typeof payload === 'object' && payload.error) {
        throw new HttpException(payload.error, HttpStatus.UNAUTHORIZED);
      }

      return payload;
    } catch (error) {
      console.log(error);
      throw error;
    }
  }
}
