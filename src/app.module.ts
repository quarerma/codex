import { Module } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { CharacterModule } from './character/character.module';
import { ClassesModule } from './rpg-classes/classes.module';
import { SubClassModule } from './rpg-subclass/rpg-subclass.module';
import { FeatsModule } from './feats/feats.module';
import { CampaingsModule } from './campaings/campaings.module';
import { DataBaseService } from './database/database.service';
import { EquipmentModule } from './equipment/equipment.module';
import { SkillModule } from './skill/skill.module';
import { InventoryModule } from './inventory/inventory.module';
import { RitualModule } from './ritual/ritual.module';
import { AuthModule } from './auth/auth.module';
import { OriginsModule } from './origins/origins.module';
import { ConditionsModule } from './conditions/conditions.module';
import { NotesModule } from './notes/notes.module';
import { SocketsModule } from './sockets/sockets.module';

@Module({
  imports: [UserModule, CharacterModule, ClassesModule, SubClassModule, FeatsModule, CampaingsModule, EquipmentModule, SkillModule, InventoryModule, RitualModule, AuthModule, OriginsModule, ConditionsModule, NotesModule, SocketsModule],
  controllers: [],
  providers: [DataBaseService],
})
export class AppModule {}
