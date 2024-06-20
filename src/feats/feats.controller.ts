import { Controller } from '@nestjs/common';
import { FeatsService } from './feats.service';

@Controller('feats')
export class FeatsController {
  constructor(private readonly featsService: FeatsService) {}
}
