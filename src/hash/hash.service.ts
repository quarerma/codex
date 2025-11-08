import { Injectable } from '@nestjs/common';
import * as crypto from 'crypto';

@Injectable()
export class HashService {
  sha256(data: string): string {
    return crypto.createHash('sha256').update(data).digest('hex');
  }

  hmac(data: string, secret: string): string {
    return crypto.createHmac('sha256', secret).update(data).digest('hex');
  }

  generateRandomToken(length = 64): string {
    return crypto.randomBytes(length).toString('hex');
  }

  compareHash(a: string, b: string): boolean {
    const bufferA = Buffer.from(a);
    const bufferB = Buffer.from(b);
    if (bufferA.length !== bufferB.length) return false;
    return crypto.timingSafeEqual(bufferA, bufferB);
  }

  createFingerprintHash(device_info: Record<string, any>): string {
    const fingerprintString = Object.values(device_info)
      .filter((v) => typeof v !== 'object')
      .join('|');

    return this.sha256(fingerprintString);
  }

  createDeviceHash(device_id: string, fingerprint_hash: string): string {
    return this.sha256(`${device_id}:${fingerprint_hash}`);
  }
}
