import { Role } from '@prisma/client';

export type UserRequest = {
  sub: string;
  id: string;
  role: Role;
};
