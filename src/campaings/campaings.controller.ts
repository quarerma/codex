import { Controller } from '@nestjs/common';
import { CampaingsService } from './campaings.service';

@Controller('campaings')
export class CampaingsController {
  constructor(private readonly campaingsService: CampaingsService) {}
}
