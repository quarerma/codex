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

      if (!(await this.handleIpTracking(ip, user.id, user.email))) {
        throw new Error('Unrecognized IP address. Verification code sent to email.');
      }
      // If ip is found
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

  private async handleIpTracking(ip: string, userId: string, userEmail: string) {
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

      // TODO: Add email service to send the code to the user
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
    });

    if (!user) {
      return { error: 'User not found' };
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const { password, email, ...result } = user;

    return this.jwtService.sign(result);
  }
}
