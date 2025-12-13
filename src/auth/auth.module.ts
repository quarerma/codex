import { Global, Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { PassportModule } from '@nestjs/passport';
import { JwtModule } from '@nestjs/jwt';
import { DataBaseService } from 'src/database/database.service';
import { JwtStrategy } from './strat/jwt.strategy';
import { EmailService } from 'src/email/email.service';
import { JwtAuthGuard } from './guards/jwt.guards';
import { HashService } from 'src/hash/hash.service';
import { UserSessionExecutor } from 'src/user/executor/session.executor';
import { RolesGuard } from './guards/role.guard';
import { CampaignCharacterOwnerGuard } from './guards/table.guards';
import * as dotenv from 'dotenv';
dotenv.config();
@Global()
@Module({
  imports: [
    ConfigModule.forRoot(),
    PassportModule,
    PassportModule,
    JwtModule.registerAsync({
      global: true,
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        secret: configService.get<string>('JWT_SECRET'),
      }),
      inject: [ConfigService],
    }),
  ],
  controllers: [AuthController],
  providers: [AuthService, DataBaseService, JwtStrategy, EmailService, JwtAuthGuard, HashService, UserSessionExecutor, RolesGuard, CampaignCharacterOwnerGuard],
  exports: [AuthService, JwtAuthGuard, HashService, UserSessionExecutor, PassportModule, JwtStrategy, RolesGuard, CampaignCharacterOwnerGuard],
})
export class AuthModule {}
