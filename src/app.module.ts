import { Module } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { CharacterModule } from './character/character.module';
import { ClassesModule } from './rpg-classes/classes.module';
import { SubClassModule } from './rpg-subclass/rpg-subclass.module';
import { FeatsModule } from './feats/feats.module';
import { CampaingsModule } from './campaings/campaings.module';
import { DataBaseService } from './database/database.service';

@Module({
  imports: [UserModule, CharacterModule, ClassesModule, SubClassModule, FeatsModule, CampaingsModule],
  controllers: [],
  providers: [DataBaseService],
})
export class AppModule {}
