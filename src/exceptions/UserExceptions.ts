import { HttpException, HttpStatus } from '@nestjs/common';

export class UserNameAlreadyInUseException extends HttpException {
  constructor() {
    super('Username already in use', HttpStatus.CONFLICT);
  }
}

export class EmailAlreadyInUseExcption extends HttpException {
  constructor() {
    super('Email already in use', HttpStatus.CONFLICT);
  }
}
