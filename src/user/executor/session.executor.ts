import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';

@Injectable()
export class UserSessionExecutor {
  constructor(private readonly dataBaseService: DataBaseService) {}

  execute(userId: string) {
    return this.dataBaseService.user.findFirst({
      where: {
        id: userId,
      },
    });
  }
}
