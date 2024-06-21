import { Module } from '@nestjs/common';
import { SkillService } from './skill.service';
import { SkillController } from './skill.controller';
import { DataBaseService } from 'src/database/database.service';

@Module({
  controllers: [SkillController],
  providers: [SkillService, DataBaseService],
})
export class SkillModule {}
