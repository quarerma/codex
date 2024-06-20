import { Module } from '@nestjs/common';
import { FeatsService } from './feats.service';
import { FeatsController } from './feats.controller';
import { DataBaseService } from 'src/database/database.service';

@Module({
  controllers: [FeatsController],
  providers: [FeatsService, DataBaseService],
})
export class FeatsModule {}
