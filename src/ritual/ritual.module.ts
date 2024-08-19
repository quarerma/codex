import { Module } from '@nestjs/common';
import { RitualService } from './ritual.service';
import { RitualController } from './ritual.controller';

@Module({
  controllers: [RitualController],
  providers: [RitualService],
})
export class RitualModule {}
