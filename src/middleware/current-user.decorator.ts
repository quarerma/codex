import { createParamDecorator, ExecutionContext, UnauthorizedException } from '@nestjs/common';
import { CacheService } from 'src/cache/cache.service';
import { UserRequest } from 'src/user/dto/user-request';
import { UserSessionExecutor } from 'src/user/executor/session.executor';

export const CurrentUser = createParamDecorator(async (data: unknown, ctx: ExecutionContext) => {
  const request = ctx.switchToHttp().getRequest();
  const user: UserRequest = request.user;

  if (!user) {
    return null;
  }

  // Assume CacheService and FunctionExecutorService are attached to the request (via middleware or interceptor)

  const sessionExecutor: UserSessionExecutor = request.sessionExecutor;
  const cacheService: CacheService = request.cacheService;
  if (!sessionExecutor || !cacheService) {
    throw new Error('CacheService or FunctionExecutorService not available in request context');
  }

  const user_id = user.id;
  const fullUserData = await cacheService.getCached('session', [`${user_id}`], async () => await sessionExecutor.execute(user_id), 0.1 * 60 * 1000);

  console.log(fullUserData);
  console.log(user);
  if (fullUserData.id !== user_id || fullUserData.role != user.role) {
    throw new UnauthorizedException();
  }

  const allowedIps = fullUserData.ipTracks.map((t) => t.ip);

  const clientIp: string = ctx.switchToHttp().getRequest().ip;

  console.log('Request IP', clientIp);
  if (!allowedIps.includes(clientIp)) {
    throw new UnauthorizedException('IP not authorized');
  }

  return fullUserData;
});
