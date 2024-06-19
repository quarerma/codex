import { Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { randomUUID } from 'crypto';
import * as bcrypt from 'bcrypt';
import {
  EmailAlreadyInUseExcption,
  UserNameAlreadyInUseException,
} from 'src/exceptions/UserExceptions';
import { DataBaseService } from 'src/database/database.service';

@Injectable()
export class UserService {
  constructor(private dataBaseService: DataBaseService) {}

  async createUser(data: CreateUserDto) {
    try {
      const id = randomUUID();

      const { password, ...userDataWithoutPassword } = data;
      const hashPassword = await this.hashPassword(password);

      const userData = { ...userDataWithoutPassword, id };

      await this.checkEmailAlreadyInUse(userData.email);

      console.log;
      console.log('username', userData.username);
      await this.checkExistingUser(userData.username);
      console.log('passou2');

      return await this.dataBaseService.user.create({
        data: { ...userData, password: hashPassword },
      });
    } catch (error) {
      if (error instanceof UserNameAlreadyInUseException) {
        throw new UserNameAlreadyInUseException();
      }
      if (error instanceof EmailAlreadyInUseExcption) {
        throw new EmailAlreadyInUseExcption();
      } else {
        console.log('"nao foi possivel criar o usuario"');
      }
    }
  }

  async hashPassword(password: string) {
    const saltOrRounds = await bcrypt.genSalt();
    const hash = await bcrypt.hash(password, saltOrRounds);

    return hash;
  }

  async checkExistingUser(username: string) {
    const user = await this.dataBaseService.user.findUnique({
      where: { username: username },
    });

    if (user) {
      throw new UserNameAlreadyInUseException();
    }
  }

  async checkEmailAlreadyInUse(email: string): Promise<void> {
    const user = await this.dataBaseService.user.findUnique({
      where: { email: email },
    });

    if (user) {
      throw new EmailAlreadyInUseExcption();
    }
  }

  async getUserById(id: string) {
    try {
      return await this.dataBaseService.user.findUnique({
        where: { id },
      });
    } catch (error) {
      console.log('erro ao buscar usuario por id');
    }
  }
}
