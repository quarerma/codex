import { Proficiency } from '@prisma/client';

export class CreateSubClassDto {
  name: string;
  classId: string;
  description: string;
  profiiciencies: Proficiency[];
}
