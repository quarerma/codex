import { Body, Controller, Get, Post, Req, Res, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { Request, Response } from 'express';
import { computeServerFingerprint } from './services/fingerprimts.aux';
import { JwtAuthGuard } from './guards/jwt.guards';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  async login(@Body() body: LoginDto, @Req() req: Request) {
    return this.authService.login(body, req);
  }

  @Post('consume-code')
  async consumeCode(@Body() data: { user_id: string; code: string; device_id: string }, @Req() req: Request, @Res({ passthrough: true }) res: Response) {
    return this.authService.consumeLoginCode(data.user_id, data.code, data.device_id, req, res);
  }

  @Post('refresh')
  @UseGuards(JwtAuthGuard)
  async refresh(@Req() req: Request, @Res({ passthrough: true }) res: Response) {
    const user = req.user as any;
    const deviceId = req.device_id;
    const { fingerprint } = computeServerFingerprint(req);

    const tokens = await this.authService.createSessionTokens(user.sub, user.role, deviceId, fingerprint);

    res.cookie('auth_token', tokens.auth_token, {
      httpOnly: true,
      secure: true,
      sameSite: 'strict',
      maxAge: 15 * 60 * 1000,
    });

    return;
  }

  @Get('protected')
  @UseGuards(JwtAuthGuard)
  async protected() {
    return { message: 'Authenticated' };
  }
}
