import { Controller } from '@nestjs/common';
import { RitualService } from './ritual.service';

@Controller('ritual')
export class RitualController {
  constructor(private readonly ritualService: RitualService) {}
}
