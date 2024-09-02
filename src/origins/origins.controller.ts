import { Controller } from '@nestjs/common';
import { OriginsService } from './origins.service';

@Controller('origins')
export class OriginsController {
  constructor(private readonly originsService: OriginsService) {}
}
