import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { CacheService } from 'src/cache/cache.service';
import { UserRequest } from 'src/user/dto/user-request';
import { UserSessionExecutor } from 'src/user/executor/session.executor';

export const CurrentUser = createParamDecorator(async (data: unknown, ctx: ExecutionContext) => {
  const request = ctx.switchToHttp().getRequest();
  const user: UserRequest = request.user;

  if (!user) {
    return null;
  }

  const sessionExecutor: UserSessionExecutor = request.sessionExecutor;
  const cacheService: CacheService = request.cacheService;
  if (!sessionExecutor || !cacheService) {
    throw new Error('CacheService or FunctionExecutorService not available in request context');
  }

  try {
    const user_id = user.sub;
    const fullUserData = await cacheService.getCached('session', [`${user_id}`], async () => await sessionExecutor.execute(user_id), 30 * 60 * 1000);

    return fullUserData;
  } catch (e) {
    console.log(e);
    throw e;
  }
});
