import { CreateFeatDto } from 'src/feats/dto/create-feat-dto';

export class AssignFeatDto {
  feat: CreateFeatDto;
  levelRequired: number;
}
