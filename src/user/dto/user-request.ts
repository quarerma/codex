import { Role } from '@prisma/client';

export type UserRequest = {
  username: string;
  id: string;
  role: Role;
};
