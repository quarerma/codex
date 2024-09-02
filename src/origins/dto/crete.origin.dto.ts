import { CreateFeatDto } from 'src/feats/dto/create-feat-dto';

export class CreateOriginDTO {
  name: string;
  description: string;
  skills: string[];
  feat: CreateFeatDto;
}
