import { Module } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { CharacterModule } from './character/character.module';
import { ClassesModule } from './rpg-classes/classes.module';

@Module({
  imports: [UserModule, CharacterModule, ClassesModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
