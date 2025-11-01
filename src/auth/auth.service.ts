import { Injectable } from '@nestjs/common';
import { DataBaseService } from 'src/database/database.service';
import { LoginDto } from './dto/login.dto';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import { EmailService } from 'src/email/email.service';

@Injectable()
export class AuthService {
  constructor(
    private readonly dataBaseService: DataBaseService,
    private readonly jwtService: JwtService,
    private readonly emailService: EmailService,
  ) {}

  async login(body: LoginDto, ip: string) {
    try {
      const user = await this.dataBaseService.user.findUnique({
        where: {
          username: body.username,
        },
        select: {
          id: true,
          password: true,
          ipTracks: {
            select: {
              ip: true,
            },
          },
        },
      });

      if (!user) {
        return { error: 'User not found' };
      }

      if (await bcrypt.compare(body.password, user.password)) {
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        const { password, email, ...result } = user;
        // On sucessful Login, add the IP to the database
        await this.dataBaseService.ipTrack.create({
          data: {
            ip,
            userId: user.id,
          },
        });

        return this.jwtService.sign(result);
      }
    } catch (error) {
      console.log(error);
      return { error: 'Error' };
    }
  }
}
