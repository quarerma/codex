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

@Global()
@Module({
  imports: [
    ConfigModule.forRoot(), // Load .env file
    PassportModule,
    JwtModule.registerAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: async (configService: ConfigService) => ({
        secret: configService.get<string>('JWT_SECRET'),
      }),
    }),
  ],
  controllers: [AuthController],
  providers: [AuthService, DataBaseService, JwtStrategy, EmailService, JwtAuthGuard, HashService, UserSessionExecutor],
  exports: [AuthService, JwtAuthGuard, HashService, UserSessionExecutor],
})
export class AuthModule {}
