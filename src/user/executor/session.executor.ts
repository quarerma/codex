import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';

@Injectable()
export class UserSessionExecutor {
  constructor(private readonly dataBaseService: DataBaseService) {}

  execute(userId: string) {
    console.log('Running Session Query');
    return this.dataBaseService.user.findFirst({
      where: {
        id: userId,
      },
      select: {
        id: true,
        role: true,
        username: true,
        email: true,
        ipTracks: {
          select: {
            ip: true,
          },
        },
      },
    });
  }
}
