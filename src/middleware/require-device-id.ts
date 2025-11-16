import { Injectable, NestMiddleware, BadRequestException } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';

@Injectable()
export class RequireDeviceIdMiddleware implements NestMiddleware {
  use(req: Request, res: Response, next: NextFunction) {
    const deviceId = req.headers['x-device-id'];
    if (!deviceId || typeof deviceId !== 'string') {
      throw new BadRequestException('Missing or invalid X-Device-ID header');
    }
    req.device_id = deviceId;
    next();
  }
}
