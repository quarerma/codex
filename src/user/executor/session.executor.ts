import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';

@Injectable()
export class UserSessionExecutor {
  constructor(private readonly dataBaseService: DataBaseService) {}

  async execute(userId: string) {
    console.log('Running Session Query', userId);
    return await this.dataBaseService.user.findFirst({
      where: {
        id: userId,
      },
      select: {
        id: true,
        role: true,
        username: true,
        email: true,
        devices: {
          select: {
            device_secret_hash: true,
            device_id: true,
            fingerprint_hash: true,
            fingerprint_data: true,
          },
        },
      },
    });
  }
}
