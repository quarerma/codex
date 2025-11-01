import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { DataBaseService } from 'src/database/database.service';
import { UserSessionExecutor } from './executor/session.executor';

@Module({
  controllers: [UserController],
  providers: [UserService, DataBaseService, UserSessionExecutor],
})
export class UserModule {}
