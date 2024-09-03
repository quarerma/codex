import { MaxLength } from 'class-validator';

export class CreateClassDTO {
  @MaxLength(50)
  name: string;

  description: string;

  hitPointsPerLevel: number;
  SanityPointsPerLevel: number;
  effortPointsPerLevel: number;

  number_of_skills: number;

  initialHealth: number;
  initialSanity: number;
  initialEffort: number;
  initialFeats: string[];
  proficiencies: string[];
}
