import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
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
import { CacheModule } from './cache/cache.module';
import { ConfigModule } from '@nestjs/config';
import { CacheServiceMiddleware } from './middleware/cache.middleware';
import { UserService } from './user/user.service';
import { UserSessionExecutor } from './user/executor/session.executor';
import { EmailService } from './email/email.service';
import { HashService } from './hash/hash.service';
import { RequireDeviceIdMiddleware } from './middleware/require-device-id';
import { CharacterFetcher } from './character/executor/character.fetcher';
import { CampaignFetcher } from './campaings/executors/campaign.fetcher';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    UserModule,
    CharacterModule,
    ClassesModule,
    SubClassModule,
    FeatsModule,
    CampaingsModule,
    EquipmentModule,
    SkillModule,
    InventoryModule,
    RitualModule,
    AuthModule,
    OriginsModule,
    ConditionsModule,
    NotesModule,
    SocketsModule,
    CacheModule,
  ],
  controllers: [],
  providers: [DataBaseService, UserService, UserSessionExecutor, EmailService, HashService, CharacterFetcher, CampaignFetcher],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(CacheServiceMiddleware, RequireDeviceIdMiddleware).forRoutes('*');
  }
}
