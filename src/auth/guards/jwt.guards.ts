// guards/jwt-auth.guard.ts
import { ExecutionContext, Injectable, UnauthorizedException } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { JwtService } from '@nestjs/jwt';
import { Request } from 'express';
import { DataBaseService } from 'src/database/database.service';
import { HashService } from 'src/hash/hash.service';
import { CacheService } from 'src/cache/cache.service';
import { UserSessionExecutor } from 'src/user/executor/session.executor';
import { computeServerFingerprint, FingerprintData } from '../services/fingerprimts.aux';

@Injectable()
export class JwtAuthGuard extends AuthGuard('jwt') {
  constructor(
    private jwtService: JwtService,
    private db: DataBaseService,
    private hashService: HashService,
    private cacheService: CacheService,
    private sessionExecutor: UserSessionExecutor,
  ) {
    super('jwt');
  }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const req = context.switchToHttp().getRequest<Request>();
    const res = context.switchToHttp().getResponse();

    const deviceId = req.device_id;
    const deviceSecret = req.cookies?.device_secret;
    const authToken = req.cookies?.auth_token;
    const refreshToken = req.cookies?.refresh_token;

    if (!deviceId || !deviceSecret) {
      throw new UnauthorizedException('Missing auth data');
    }

    const { fingerprint: currentFp, data: currentData } = computeServerFingerprint(req);

    //  Validate JWT
    let payload: any;
    let isRefresh = false;

    try {
      if (!authToken) {
        throw new Error();
      }
      payload = this.jwtService.verify(authToken);
      if (payload.device_id !== deviceId) throw new Error();
    } catch {
      // Refresh
      try {
        const rPayload: any = this.jwtService.verify(refreshToken);
        if (rPayload.device_id !== deviceId || rPayload.type !== 'refresh') {
          throw new Error();
        }
        payload = rPayload;
        isRefresh = true;
      } catch (e) {
        throw new UnauthorizedException({
          error: 'session_expired',
          code: 'relogin',
          message: 'Refresh token expired. Re-authenticate.',
        });
      }
    }

    const userId = payload.sub;

    //  Load user from cache
    const fullUser = await this.cacheService.getCached('session', [userId], async () => await this.sessionExecutor.execute(userId), 30 * 60 * 1000);

    const deviceRecord = fullUser.devices?.find((d: any) => d.device_id === deviceId);
    if (!deviceRecord) {
      throw new UnauthorizedException('Device not registered');
    }

    // Handle expired device_secret
    if (!deviceSecret) {
      // Regenerate if device trusted (fingerprint matches with tolerance) - Auth0
      const { critical, nonCritical } = this.compareFingerprintFields(currentData, deviceRecord.fingerprint_data);

      if (critical > 0 || nonCritical > 2) {
        throw new UnauthorizedException('Device mismatch - re-authenticate');
      }

      // Generate new secret + update DB
      const newSecret = this.hashService.generateRandomToken(32);
      const newSecretHash = this.hashService.sha256(newSecret);

      await this.db.userDevice.update({
        where: { userId_device_id: { userId, device_id: deviceId } },
        data: { device_secret_hash: newSecretHash },
      });

      res.cookie('device_secret', newSecret, {
        httpOnly: true,
        secure: true,
        sameSite: 'strict',
        maxAge: 90 * 24 * 60 * 60 * 1000,
      });

      // Invalidate cache
      await this.cacheService.deleteSpecificCache('session', [userId]);
    } else {
      // Validate existing secret
      if (deviceRecord.device_secret_hash !== this.hashService.sha256(deviceSecret)) {
        throw new UnauthorizedException('Invalid device secret');
      }
    }

    // Fingerprint
    const storedFp = deviceRecord.fingerprint_hash;
    const storedData = deviceRecord.fingerprint_data;

    if (currentFp !== storedFp) {
      const { critical, nonCritical } = this.compareFingerprintFields(currentData, storedData);

      if (critical > 0) {
        throw new UnauthorizedException('Critical fingerprint change');
      }

      if (nonCritical > 2) {
        throw new UnauthorizedException('Too many non-critical changes');
      }

      // On small change, update fingerprint on database
      await this.db.userDevice.update({
        where: { userId_device_id: { userId, device_id: deviceId } },
        data: {
          fingerprint_hash: currentFp,
          fingerprint_data: currentData as any,
        },
      });

      // Invalidate cache so next request gets updated data
      await this.cacheService.deleteSpecificCache('session', [userId]);
    }

    //  Refresh: issue new auth_token
    if (isRefresh) {
      const newAuth = this.jwtService.sign(
        {
          sub: userId,
          role: fullUser.role,
          device_id: deviceId,
          fingerprint: currentFp,
        },
        { expiresIn: '15m' },
      );

      res.cookie('auth_token', newAuth, {
        httpOnly: true,
        secure: true,
        sameSite: 'strict',
        maxAge: 15 * 60 * 1000,
      });

      //* Slide session expiration of refresh token
      const newRefresh = this.jwtService.sign(
        {
          sub: userId,
          type: 'refresh',
          device_id: deviceId,
        },
        { expiresIn: '7d' },
      );

      res.cookie('refresh_token', newRefresh, {
        httpOnly: true,
        secure: true,
        sameSite: 'strict',
        maxAge: 7 * 24 * 60 * 60 * 1000,
      });
    }

    req.user = payload;

    return true;
  }

  private compareFingerprintFields(current: any | FingerprintData, stored: any | FingerprintData): { critical: number; nonCritical: number } {
    let critical = 0;
    let nonCritical = 0;

    // CRITICAL: JA3 (TLS stack)
    if (current.ja3 !== stored.ja3) critical++;

    // NON-CRITICAL: Can change
    if (current.http_version !== stored.http_version) nonCritical++;
    if (current.user_agent !== stored.user_agent) nonCritical++;
    if (current.accept !== stored.accept) nonCritical++;
    if (current.encoding !== stored.encoding) nonCritical++;
    if (current.language !== stored.language) nonCritical++;
    if (current.sec_ch_ua !== stored.sec_ch_ua) nonCritical++;
    if (current.sec_ch_ua_platform !== stored.sec_ch_ua_platform) nonCritical++;

    return { critical, nonCritical };
  }
}
