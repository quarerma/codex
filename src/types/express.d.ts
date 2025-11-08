import 'express';

declare global {
  namespace Express {
    interface Request {
      device_id: string;
    }
  }
}
