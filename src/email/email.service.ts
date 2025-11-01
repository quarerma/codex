import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class EmailService {
  constructor(private readonly configService: ConfigService) {}

  async sendEmail(header: string, body: string) {
    try {
      console.log(header, body);
      const email_url = this.configService.get<string>('N8N_EMAIL_URL');
    } catch (e) {
      console.log('Error on email sending', e);
      throw e;
    }
  }
}
