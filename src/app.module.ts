import { Module } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { CharacterModule } from './character/character.module';

@Module({
  imports: [UserModule, CharacterModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
