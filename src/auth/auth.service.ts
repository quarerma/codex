import { Injectable, UnauthorizedException } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { LoginDto } from './dto/login.dto';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import { EmailService } from 'src/email/email.service';
import { HashService } from 'src/hash/hash.service';
import { Response, Request } from 'express';
import { computeServerFingerprint } from './services/fingerprimts.aux';

@Injectable()
export class AuthService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly jwtService: JwtService,
    private readonly emailService: EmailService,
    private readonly hashService: HashService,
  ) {}

  async login(body: LoginDto, req: Request) {
    const user = await this.dataBaseService.user.findUnique({
      where: { username: body.username },
      select: { id: true, password: true, email: true, role: true },
    });

    if (!user || !(await bcrypt.compare(body.password, user.password))) {
      return { error: 'Invalid credentials' };
    }

    const clientDeviceId = body.device_id;
    const existingDevice = await this.dataBaseService.userDevice.findUnique({
      where: { userId_device_id: { userId: user.id, device_id: clientDeviceId } },
    });

    if (!existingDevice) {
      const code = Math.floor(100000 + Math.random() * 900000).toString();
      await this.dataBaseService.loginCode.create({
        data: {
          code,
          userId: user.id,
          device_id: clientDeviceId,
          expiresAt: new Date(Date.now() + 30 * 60 * 1000),
        },
      });
      await this.emailService.sendEmail('Confirm your device', `Code: ${code}`);
      return { message: 'Verification code sent' };
    }

    const { fingerprint } = computeServerFingerprint(req);
    const tokens = await this.createSessionTokens(user.id, user.role, clientDeviceId, fingerprint);
    return tokens;
  }

  async consumeLoginCode(userId: string, code: string, clientDeviceId: string, req: Request, res: Response) {
    const loginCode = await this.dataBaseService.loginCode.findFirst({
      where: { userId, code, device_id: clientDeviceId, expiresAt: { gt: new Date() } },
    });

    if (!loginCode) throw new UnauthorizedException('Invalid or expired code');

    await this.dataBaseService.loginCode.delete({ where: { id: loginCode.id } });

    const { fingerprint, data } = computeServerFingerprint(req);
    const device_secret = this.hashService.generateRandomToken(32);
    const device_secret_hash = this.hashService.sha256(device_secret);

    await this.dataBaseService.userDevice.create({
      data: {
        userId,
        device_id: clientDeviceId,
        fingerprint_hash: fingerprint,
        fingerprint_data: data as any,
        device_secret_hash,
        user_agent: data.user_agent,
        last_login: new Date(),
        created_at: new Date(),
      },
    });

    const tokens = await this.createSessionTokens(userId, 'user', clientDeviceId, fingerprint);
    this.setAuthCookies(res, tokens, device_secret);

    return { message: 'Device trusted', ...tokens };
  }

  async createSessionTokens(userId: string, role: string, device_id: string, current_fingerprint: string) {
    const auth_token = this.jwtService.sign({ sub: userId, role, device_id, fingerprint: current_fingerprint }, { expiresIn: '15m' });

    const refresh_token = this.jwtService.sign({ sub: userId, device_id, type: 'refresh' }, { expiresIn: '90d' });

    return { auth_token, refresh_token };
  }

  setAuthCookies(res: Response, tokens: any, device_secret: string) {
    const opts = { httpOnly: true, secure: true, sameSite: 'strict' } as const;
    res.cookie('auth_token', tokens.auth_token, { ...opts, maxAge: 15 * 60 * 1000 });
    res.cookie('refresh_token', tokens.refresh_token, { ...opts, maxAge: 90 * 24 * 60 * 60 * 1000 });
    res.cookie('device_secret', device_secret, { ...opts, maxAge: 90 * 24 * 60 * 60 * 1000 });
  }
}
