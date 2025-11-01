import { Body, Controller, Get, HttpException, HttpStatus, Ip, Post, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { JwtAuthGuards } from './guards/jwt.guards';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('/login')
  async login(@Body() body: LoginDto, @Ip() ip: string) {
    try {
      const payload = await this.authService.login(body, ip);

      if (typeof payload === 'object' && payload.error) {
        throw new HttpException(payload.error, HttpStatus.UNAUTHORIZED);
      }

      return payload;
    } catch (error) {
      console.log(error);
      throw error;
    }
  }

  @Get('/auth-token')
  @UseGuards(JwtAuthGuards)
  async auth() {
    return { message: 'User is authenticated' };
  }

  @Post('consume-code')
  async consumeCode(@Body() data: { user_id: string; code: string }, @Ip() ip: string) {
    try {
      return await this.authService.consumeLoginCode(data.user_id, data.code, ip);
    } catch (e) {
      throw e;
    }
  }
}
