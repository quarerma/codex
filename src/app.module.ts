import { Module } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { CharacterModule } from './character/character.module';
import { ClassesModule } from './rpg-classes/classes.module';
import { SubClassModule } from './rpg-subclass/rpg-subclass.module';
import { FeatsModule } from './feats/feats.module';

@Module({
  imports: [UserModule, CharacterModule, ClassesModule, SubClassModule, FeatsModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
