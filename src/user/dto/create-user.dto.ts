import { Role } from '@prisma/client';
import { IsEmail, IsNotEmpty } from 'class-validator';

export class CreateUserDto {
  username: string;

  @IsNotEmpty()
  password: string;

  @IsEmail()
  email: string;

  role: Role;
}
