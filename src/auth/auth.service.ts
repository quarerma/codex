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
          email: true,
          role: true,
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

      if (!(await this.handleIpTracking(ip, user.id))) {
        throw new Error('Unrecognized IP address. Verification code sent to email.');
      }
      // If ip is found
      if (await bcrypt.compare(body.password, user.password)) {
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        const { password, email, ipTracks, ...result } = user;

        return this.jwtService.sign(result);
      }
    } catch (error) {
      console.log(error);
      return { error: 'Error' };
    }
  }

  private async handleIpTracking(ip: string, userId: string) {
    const hasRegisteredIp = await this.dataBaseService.ipTrack.findFirst({
      where: {
        ip,
        userId,
      },
    });

    if (!hasRegisteredIp) {
      // Send email to user and return expecption with 6 digit code
      const code = Math.floor(100000 + Math.random() * 900000).toString();

      await this.dataBaseService.loginCode.create({
        data: {
          code: code,
          userId: userId,
          expiresAt: new Date(Date.now() + 30 * 60 * 1000), // 30 minutes from now
          ip: ip,
        },
      });

      this.emailService.sendEmail('Confirmation code', 'This code is Valid for 30minutes: ' + code);
      return false;
    }

    return true;
  }

  async consumeLoginCode(userId: string, code: string, ip: string) {
    const loginCode = await this.dataBaseService.loginCode.findFirst({
      where: {
        userId,
        code,
        ip,
        expiresAt: {
          gt: new Date(),
        },
      },
    });

    if (!loginCode) {
      return { error: 'Invalid or expired code' };
    }

    // Delete the used code
    await this.dataBaseService.loginCode.delete({
      where: {
        id: loginCode.id,
      },
    });

    // Add the IP to the user's registered IPs
    await this.dataBaseService.ipTrack.create({
      data: {
        ip,
        userId,
      },
    });

    //  Create and return JWT token
    const user = await this.dataBaseService.user.findUnique({
      where: {
        id: userId,
      },
      select: {
        id: true,
        role: true,
      },
    });

    if (!user) {
      return { error: 'User not found' };
    }

    return this.jwtService.sign(user);
  }
}
