import { createParamDecorator, ExecutionContext } from '@nestjs/common';
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

  if (!sessionExecutor) {
    throw new Error('CacheService or FunctionExecutorService not available in request context');
  }

  const user_id = user.id;
  const fullUserData = await sessionExecutor.execute(user_id);

  if (fullUserData.id !== user_id) {
    console.warn(`ID mismatch for user_id: ${user_id}. Refetching user data.`);
    const refreshedUserData = await sessionExecutor.execute(user_id);

    // await cacheService.setCached('session', [`${user_id}`], refreshedUserData, 30 * 60 * 1000);
    return refreshedUserData;
  }

  return fullUserData;
});
