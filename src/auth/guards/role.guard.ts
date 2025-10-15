import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { JwtAuthGuards } from './jwt.guards';
import { UserRequest } from 'src/user/dto/user-request';
import { Role } from '@prisma/client';
import { ROLES_KEY } from '../dto/role.decorator';

@Injectable()
export class RolesGuard extends JwtAuthGuards implements CanActivate {
  constructor(private reflector: Reflector) {
    super();
  }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const isJwtValid = await super.canActivate(context);
    if (!isJwtValid) {
      return false;
    }

    const requiredRoles = this.reflector.getAllAndOverride<Role[]>(ROLES_KEY, [context.getHandler(), context.getClass()]);

    if (!requiredRoles) {
      return true;
    }

    const request = context.switchToHttp().getRequest();
    const user: UserRequest = request.user;

    if (!user) {
      return false; // No user found, deny access
    }

    return requiredRoles.some((role) => user.role === role);
  }
}
