import { MaxLength } from 'class-validator';

export class CreateClassDTO {
  @MaxLength(50)
  name: string;

  hitPointsPerLevel: number;
  SanityPointsPerLevel: number;
  effortPointsPerLevel: number;

  initialHealth: number;
  initialSanity: number;
  initialEffort: number;
}
