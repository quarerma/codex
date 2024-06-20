import { Module } from '@nestjs/common';
import { CampaingsService } from './campaings.service';
import { CampaingsController } from './campaings.controller';
import { DataBaseService } from 'src/database/database.service';

@Module({
  controllers: [CampaingsController],
  providers: [CampaingsService, DataBaseService],
})
export class CampaingsModule {}
