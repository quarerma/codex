import { Body, Controller, Get, Post, Req, Res, UnauthorizedException, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { Request, Response } from 'express';
import { JwtAuthGuard } from './guards/jwt.guards';
import { CurrentUser } from 'src/middleware/current-user.decorator';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  async login(@Body() body: LoginDto, @Req() req: Request, @Res({ passthrough: true }) res: Response) {
    try {
      return this.authService.login(body, req, res);
    } catch (e) {
      console.log(e);
      throw e;
    }
  }

  @Post('consume-code')
  async consumeCode(@Body() data: { user_id: string; code: string }, @Req() req: Request, @Res({ passthrough: true }) res: Response) {
    return this.authService.consumeLoginCode(data.user_id, data.code, req.device_id, req, res);
  }

  @Get('protected')
  @UseGuards(JwtAuthGuard)
  async protected() {
    return { message: 'Authenticated' };
  }

  @Get('auth-token')
  @UseGuards(JwtAuthGuard)
  async checkAuth(@CurrentUser() user: any) {
    if (!user) {
      throw new UnauthorizedException('Session not found');
    }
    return true;
  }

  @Post('logout')
  logout(@Res({ passthrough: true }) res: Response) {
    res.clearCookie('auth_token', { path: '/' });
    res.clearCookie('refresh_token', { path: '/' });
    res.clearCookie('device_secret', { path: '/' });

    return { message: 'Logged out successfully' };
  }
}
