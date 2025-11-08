import { Role } from '@prisma/client';

export type UserRequest = {
  id: string;
  role: Role;
};
