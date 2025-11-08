import { createHash } from 'crypto';
import { Request } from 'express';

export interface FingerprintData {
  ja3: string;
  http_version: string;
  user_agent: string;
  accept: string;
  encoding: string;
  language: string;
  sec_ch_ua: string;
  sec_ch_ua_platform: string;
}

export function computeServerFingerprint(req: Request): {
  fingerprint: string;
  data: FingerprintData;
} {
  const h = req.headers;

  const data: FingerprintData = {
    ja3: (req as any).ja3?.hash || '',
    http_version: req.httpVersion,
    user_agent: normalize(h['user-agent']),
    accept: normalize(h['accept']),
    encoding: normalize(h['accept-encoding'] as string),
    language: normalize(h['accept-language']?.split(',')[0]),
    sec_ch_ua: normalize(h['sec-ch-ua'] as string),
    sec_ch_ua_platform: normalize(h['sec-ch-ua-platform'] as string),
  };

  const raw = Object.values(data).filter(Boolean).join('|');
  const fingerprint = createHash('sha256').update(raw).digest('hex');

  return { fingerprint, data };
}

function normalize(s?: string): string {
  return (s || '').trim().toLowerCase();
}
