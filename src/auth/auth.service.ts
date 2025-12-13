import { BadRequestException, HttpException, Injectable, UnauthorizedException } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { LoginDto } from './dto/login.dto';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import { EmailService } from 'src/email/email.service';
import { HashService } from 'src/hash/hash.service';
import { Response, Request } from 'express';
import { computeServerFingerprint } from './services/fingerprimts.aux';
import { CacheService } from 'src/cache/cache.service';

@Injectable()
export class AuthService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly jwtService: JwtService,
    private readonly emailService: EmailService,
    private readonly hashService: HashService,
    private readonly cacheService: CacheService,
  ) {}

  async login(body: LoginDto, req: Request, res: Response) {
    const user = await this.dataBaseService.user.findUnique({
      where: { username: body.username },
      select: { id: true, password: true, email: true, role: true },
    });

    if (!user || !(await bcrypt.compare(body.password, user.password))) {
      throw new BadRequestException('Invalid Credentials');
    }

    const clientDeviceId = req.device_id;
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
      throw new HttpException(
        JSON.stringify({
          message: 'Redirecting for device verification',
          user_id: user.id,
        }),
        307,
        {},
      );
    }

    const { data, fingerprint } = computeServerFingerprint(req);
    const tokens = await this.createSessionTokens(user.id, user.role, clientDeviceId, fingerprint);

    const deviceSecret = this.hashService.generateRandomToken();

    const deviceSecretHash = this.hashService.sha256(deviceSecret);

    await this.dataBaseService.userDevice.update({
      where: {
        userId_device_id: {
          userId: user.id,
          device_id: clientDeviceId,
        },
      },
      data: {
        fingerprint_data: data as any,
        fingerprint_hash: fingerprint,
        user_agent: data.user_agent,
        last_login: new Date(),
        device_secret_hash: deviceSecretHash,
        last_used_at: new Date(),
      },
    });

    this.setAuthCookies(res, tokens, deviceSecret);
    await this.cacheService.deleteSpecificCache('session', [user.id]);
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

    await this.cacheService.deleteSpecificCache('session', [userId]);
    return { message: 'Device trusted', ...tokens };
  }

  async createSessionTokens(userId: string, role: string, device_id: string, current_fingerprint: string) {
    const auth_token = this.jwtService.sign({ sub: userId, role, device_id, fingerprint: current_fingerprint }, { expiresIn: '15m' });

    const refresh_token = this.jwtService.sign({ sub: userId, device_id, type: 'refresh' }, { expiresIn: '90d' });

    return { auth_token, refresh_token };
  }

  setAuthCookies(res: Response, tokens: any, device_secret: string) {
    const opts = { httpOnly: true, secure: true, sameSite: 'strict', path: '/' } as const;

    res.cookie('auth_token', tokens.auth_token, { ...opts, maxAge: 15 * 60 * 1000 });
    res.cookie('refresh_token', tokens.refresh_token, { ...opts, maxAge: 90 * 24 * 60 * 60 * 1000 });
    res.cookie('device_secret', device_secret, { ...opts, maxAge: 90 * 24 * 60 * 60 * 1000 });
  }
}
