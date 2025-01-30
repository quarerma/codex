import { Module } from '@nestjs/common';
import { SocketsService } from './sockets.service';
import { SocketsGateway } from './sockets.gateway';
import { DataBaseService } from 'src/database/database.service';

@Module({
  providers: [SocketsGateway, SocketsService, DataBaseService],
})
export class SocketsModule {}
