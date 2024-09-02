import { Module } from '@nestjs/common';
import { OriginsService } from './origins.service';
import { OriginsController } from './origins.controller';
import { DataBaseService } from 'src/database/database.service';

@Module({
  controllers: [OriginsController],
  providers: [OriginsService, DataBaseService],
})
export class OriginsModule {}
