import { Atribute } from '@prisma/client';

export class CreateSkillDTO {
  name: string;
  description: string;
  atribute: Atribute;
  only_trained: boolean;
  carry_peanalty: boolean;
  needs_kit: boolean;
  is_custom: boolean;
}
