import { Injectable, Logger } from '@nestjs/common';
import { Cron } from '@nestjs/schedule';

@Injectable()
export class AppService {
  private readonly logger = new Logger(AppService.name);

  @Cron('*/5 * * * * *') // Every 5 minutes
  handleCron() {
    this.logger.log('Ping to keep the server active.');
    // Add your keep-alive logic here
  }
}
