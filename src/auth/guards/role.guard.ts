import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { JwtAuthGuard } from './jwt.guards';
import { UserRequest } from 'src/user/dto/user-request';
import { Role } from '@prisma/client';
import { ROLES_KEY } from '../dto/role.decorator';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    private jwtAuthGuard: JwtAuthGuard,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const isJwtValid = await this.jwtAuthGuard.canActivate(context);
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
      throw new UnauthorizedException("You don't have access to this resource");
    }

    const hasAccess = requiredRoles.some((role) => user.role === role);

    if (!hasAccess) {
      throw new UnauthorizedException("You don't have access to this resource");
    }

    return hasAccess;
  }
}
