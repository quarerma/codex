-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'ADMIN');

-- CreateEnum
CREATE TYPE "Patent" AS ENUM ('ROOKIE', 'OPERATOR', 'SPECIAL_AGENT', 'OPERATION_OFFICER', 'ELITE_AGENT');

-- CreateEnum
CREATE TYPE "RitualType" AS ENUM ('EFFECT', 'DAMAGE');

-- CreateEnum
CREATE TYPE "ModificationType" AS ENUM ('MELEE_WEAPON', 'BULLET_WEAPON', 'BOLT_WEAPON', 'ARMOR', 'AMMO', 'ACESSORY');

-- CreateEnum
CREATE TYPE "Atribute" AS ENUM ('STRENGTH', 'DEXTERITY', 'VITALITY', 'INTELLIGENCE', 'PRESENCE');

-- CreateEnum
CREATE TYPE "Credit" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'UNLIMITED');

-- CreateEnum
CREATE TYPE "HandType" AS ENUM ('LIGHT', 'ONE_HANDED', 'TWO_HANDED');

-- CreateEnum
CREATE TYPE "WeaponType" AS ENUM ('MELEE', 'BOLT', 'BULLET');

-- CreateEnum
CREATE TYPE "WeaponCategory" AS ENUM ('SIMPLE', 'TATICAL', 'HEAVY');

-- CreateEnum
CREATE TYPE "Proficiency" AS ENUM ('SIMPLE', 'TATICAL', 'HEAVY', 'LIGHT_ARMOR', 'HEAVY_ARMOR');

-- CreateEnum
CREATE TYPE "Element" AS ENUM ('REALITY', 'FEAR', 'BLOOD', 'DEATH', 'ENERGY', 'KNOWLEDGE');

-- CreateEnum
CREATE TYPE "ItemType" AS ENUM ('WEAPON', 'ARMOR', 'AMMO', 'ACESSORY', 'EXPLOSIVE', 'OPERATIONAL_EQUIPMENT', 'PARANORMAL_EQUIPMENT', 'CURSED_ITEM', 'DEFAULT');

-- CreateEnum
CREATE TYPE "Range" AS ENUM ('SELF', 'TOUCH', 'MELEE', 'SHORT', 'MEDIUM', 'EXTREME', 'UNLIMITED', 'LONG');

-- CreateEnum
CREATE TYPE "DamageType" AS ENUM ('PIERCING', 'BALISTIC', 'IMPACT', 'SLASHING', 'FIRE', 'CHEMICAL', 'POISON', 'BLOOD', 'FEAR', 'KNOWLEDGE', 'DEATH', 'ENERGY', 'ELETRIC');

-- CreateEnum
CREATE TYPE "FeatType" AS ENUM ('ORIGIN', 'CUSTOM', 'CLASS', 'SUBCLASS', 'GENERAL');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "username" VARCHAR(50) NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ip_track" (
    "id" SERIAL NOT NULL,
    "ip" VARCHAR(45) NOT NULL,
    "user_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ip_track_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlayerOnCampaign" (
    "campaign_id" TEXT NOT NULL,
    "player_id" TEXT NOT NULL,
    "joined_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "Campaign" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" VARCHAR(50) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "password" TEXT NOT NULL,
    "owner_id" TEXT NOT NULL,

    CONSTRAINT "Campaign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Character" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "level" INTEGER NOT NULL,
    "current_health" INTEGER NOT NULL,
    "current_sanity" INTEGER NOT NULL,
    "current_effort" INTEGER NOT NULL,
    "max_health" INTEGER NOT NULL,
    "max_sanity" INTEGER NOT NULL,
    "max_effort" INTEGER NOT NULL,
    "speed" INTEGER NOT NULL,
    "defense" INTEGER NOT NULL,
    "num_of_skills" INTEGER NOT NULL DEFAULT 0,
    "health_info" JSONB NOT NULL,
    "effort_info" JSONB NOT NULL,
    "sanity_info" JSONB NOT NULL,
    "atributes" JSONB NOT NULL,
    "skills" JSONB[],
    "attacks" JSONB[],
    "owner_id" TEXT NOT NULL,
    "campaign_id" TEXT NOT NULL,
    "class_id" TEXT NOT NULL,
    "subclass_id" TEXT NOT NULL,
    "proficiencies" "Proficiency"[],
    "origin_id" TEXT NOT NULL,

    CONSTRAINT "Character_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterFeat" (
    "character_id" TEXT NOT NULL,
    "feat_id" TEXT NOT NULL,
    "usingAfinity" BOOLEAN NOT NULL DEFAULT false
);

-- CreateTable
CREATE TABLE "Notes" (
    "id" TEXT NOT NULL,
    "title" VARCHAR(50) NOT NULL,
    "content" TEXT,
    "character_id" TEXT,
    "campaign_id" TEXT,

    CONSTRAINT "Notes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Inventory" (
    "character_id" TEXT NOT NULL,
    "maxValue" INTEGER NOT NULL,
    "alterations" JSONB[],
    "patent" "Patent" NOT NULL,
    "credit" "Credit" NOT NULL DEFAULT 'LOW',

    CONSTRAINT "Inventory_pkey" PRIMARY KEY ("character_id")
);

-- CreateTable
CREATE TABLE "InventorySlot" (
    "id" TEXT NOT NULL,
    "inventory_id" TEXT NOT NULL,
    "equipment_id" INTEGER,
    "uses" INTEGER NOT NULL DEFAULT 0,
    "category" INTEGER NOT NULL,
    "weight" INTEGER NOT NULL DEFAULT 0,
    "local_name" TEXT NOT NULL,
    "local_description" TEXT DEFAULT '',
    "is_equipped" BOOLEAN NOT NULL DEFAULT true,
    "alterations" JSONB[],

    CONSTRAINT "InventorySlot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Condition" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "description" TEXT NOT NULL,
    "is_custom" BOOLEAN NOT NULL,

    CONSTRAINT "Condition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RitualCondition" (
    "ritual_id" TEXT NOT NULL,
    "condition_id" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "CharacterCondition" (
    "character_id" TEXT NOT NULL,
    "condition_id" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Class" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "description" TEXT NOT NULL,
    "hitPointsPerLevel" INTEGER NOT NULL,
    "SanityPointsPerLevel" INTEGER NOT NULL,
    "effortPointsPerLevel" INTEGER NOT NULL,
    "initialHealth" INTEGER NOT NULL,
    "initialSanity" INTEGER NOT NULL,
    "initialEffort" INTEGER NOT NULL,
    "number_of_skills" INTEGER NOT NULL DEFAULT 0,
    "proficiencies" "Proficiency"[],

    CONSTRAINT "Class_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Subclass" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "description" TEXT NOT NULL,
    "classId" TEXT NOT NULL,

    CONSTRAINT "Subclass_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Feat" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "description" TEXT NOT NULL,
    "prerequisites" TEXT,
    "characterUpgrades" JSONB[],
    "type" "FeatType" NOT NULL,
    "afinity" TEXT,
    "afinityUpgrades" JSONB[],
    "element" "Element" NOT NULL,

    CONSTRAINT "Feat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClassFeats" (
    "featId" TEXT NOT NULL,
    "classId" TEXT NOT NULL,
    "isStarterFeat" BOOLEAN NOT NULL DEFAULT false
);

-- CreateTable
CREATE TABLE "SubclassFeats" (
    "featId" TEXT NOT NULL,
    "subclassId" TEXT NOT NULL,
    "levelRequired" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "CampaignFeats" (
    "featId" TEXT NOT NULL,
    "campaignId" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "GeneralFeats" (
    "id" TEXT NOT NULL,
    "featId" TEXT NOT NULL,

    CONSTRAINT "GeneralFeats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Origin" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "is_custom" BOOLEAN NOT NULL,
    "feat_id" TEXT NOT NULL,
    "skills" TEXT[],

    CONSTRAINT "Origin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CampaignOrigin" (
    "id" TEXT NOT NULL,
    "campaign_id" TEXT NOT NULL,
    "origin_id" TEXT NOT NULL,

    CONSTRAINT "CampaignOrigin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Skill" (
    "name" TEXT NOT NULL,
    "atribute" "Atribute" NOT NULL,
    "description" TEXT NOT NULL,
    "only_trained" BOOLEAN NOT NULL,
    "carry_peanalty" BOOLEAN NOT NULL,
    "needs_kit" BOOLEAN NOT NULL,
    "is_custom" BOOLEAN NOT NULL,
    "campaign_id" TEXT,

    CONSTRAINT "Skill_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "Ritual" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "normalCastDescription" TEXT NOT NULL,
    "normalCost" INTEGER NOT NULL,
    "discentCastDescription" TEXT,
    "discentCost" INTEGER,
    "trueCastDescription" TEXT,
    "trueCost" INTEGER,
    "ritualLevel" INTEGER NOT NULL,
    "exectutionTime" TEXT NOT NULL,
    "range" "Range" NOT NULL,
    "target" TEXT NOT NULL,
    "duration" TEXT NOT NULL,
    "element" "Element" NOT NULL,
    "resistence" TEXT NOT NULL,
    "is_custom" BOOLEAN NOT NULL,
    "type" "RitualType" NOT NULL,

    CONSTRAINT "Ritual_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterRitual" (
    "character_id" TEXT NOT NULL,
    "ritual_id" TEXT NOT NULL,
    "ritual_cost" INTEGER NOT NULL,
    "alterations" JSONB[]
);

-- CreateTable
CREATE TABLE "DamageRitual" (
    "ritualId" TEXT NOT NULL,
    "normalCastDamageType" "DamageType",
    "discentCastDamageType" "DamageType",
    "trueCastDamageType" "DamageType",
    "normalCastDamage" TEXT,
    "discentCastDamage" TEXT,
    "trueCastDamage" TEXT,

    CONSTRAINT "DamageRitual_pkey" PRIMARY KEY ("ritualId")
);

-- CreateTable
CREATE TABLE "CampaignRitual" (
    "id" TEXT NOT NULL,
    "campaign_id" TEXT NOT NULL,
    "ritual_id" TEXT NOT NULL,

    CONSTRAINT "CampaignRitual_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Modification" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" "ModificationType"[],
    "element" "Element" NOT NULL,
    "characterUpgrades" JSONB[],
    "description" TEXT NOT NULL,
    "is_custom" BOOLEAN NOT NULL,

    CONSTRAINT "Modification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CampaignModifications" (
    "id" TEXT NOT NULL,
    "campaign_id" TEXT NOT NULL,
    "modification_id" TEXT NOT NULL,

    CONSTRAINT "CampaignModifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Equipment" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "num_of_uses" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "weight" INTEGER NOT NULL,
    "category" INTEGER NOT NULL,
    "type" "ItemType" NOT NULL,
    "is_custom" BOOLEAN NOT NULL,
    "characterUpgrades" JSONB[],

    CONSTRAINT "Equipment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CampaignEquipment" (
    "id" TEXT NOT NULL,
    "campaign_id" TEXT NOT NULL,
    "equipment_id" INTEGER NOT NULL,

    CONSTRAINT "CampaignEquipment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Weapon" (
    "equipmentId" INTEGER NOT NULL,
    "damage" TEXT NOT NULL,
    "critical_multiplier" INTEGER NOT NULL,
    "critical_range" INTEGER NOT NULL,
    "range" "Range" NOT NULL,
    "damage_type" "DamageType" NOT NULL,
    "weapon_category" "WeaponCategory" NOT NULL,
    "weapon_type" "WeaponType" NOT NULL,
    "hand_type" "HandType" NOT NULL,

    CONSTRAINT "Weapon_pkey" PRIMARY KEY ("equipmentId")
);

-- CreateTable
CREATE TABLE "CursedItem" (
    "equipmentId" INTEGER NOT NULL,
    "element" "Element" NOT NULL,

    CONSTRAINT "CursedItem_pkey" PRIMARY KEY ("equipmentId")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "User_username_idx" ON "User"("username");

-- CreateIndex
CREATE INDEX "User_email_idx" ON "User"("email");

-- CreateIndex
CREATE INDEX "User_id_idx" ON "User"("id");

-- CreateIndex
CREATE INDEX "ip_track_ip_idx" ON "ip_track"("ip");

-- CreateIndex
CREATE INDEX "ip_track_user_id_idx" ON "ip_track"("user_id");

-- CreateIndex
CREATE INDEX "PlayerOnCampaign_campaign_id_idx" ON "PlayerOnCampaign"("campaign_id");

-- CreateIndex
CREATE INDEX "PlayerOnCampaign_player_id_idx" ON "PlayerOnCampaign"("player_id");

-- CreateIndex
CREATE UNIQUE INDEX "PlayerOnCampaign_campaign_id_player_id_key" ON "PlayerOnCampaign"("campaign_id", "player_id");

-- CreateIndex
CREATE INDEX "Campaign_owner_id_idx" ON "Campaign"("owner_id");

-- CreateIndex
CREATE INDEX "Character_owner_id_idx" ON "Character"("owner_id");

-- CreateIndex
CREATE INDEX "Character_campaign_id_idx" ON "Character"("campaign_id");

-- CreateIndex
CREATE INDEX "Character_class_id_idx" ON "Character"("class_id");

-- CreateIndex
CREATE INDEX "CharacterFeat_character_id_idx" ON "CharacterFeat"("character_id");

-- CreateIndex
CREATE UNIQUE INDEX "CharacterFeat_character_id_feat_id_key" ON "CharacterFeat"("character_id", "feat_id");

-- CreateIndex
CREATE INDEX "Notes_id_idx" ON "Notes"("id");

-- CreateIndex
CREATE INDEX "Inventory_character_id_idx" ON "Inventory"("character_id");

-- CreateIndex
CREATE INDEX "InventorySlot_id_idx" ON "InventorySlot"("id");

-- CreateIndex
CREATE INDEX "Condition_id_idx" ON "Condition"("id");

-- CreateIndex
CREATE INDEX "RitualCondition_ritual_id_idx" ON "RitualCondition"("ritual_id");

-- CreateIndex
CREATE UNIQUE INDEX "RitualCondition_ritual_id_condition_id_key" ON "RitualCondition"("ritual_id", "condition_id");

-- CreateIndex
CREATE INDEX "CharacterCondition_character_id_idx" ON "CharacterCondition"("character_id");

-- CreateIndex
CREATE UNIQUE INDEX "CharacterCondition_character_id_condition_id_key" ON "CharacterCondition"("character_id", "condition_id");

-- CreateIndex
CREATE INDEX "Class_id_idx" ON "Class"("id");

-- CreateIndex
CREATE INDEX "Subclass_id_idx" ON "Subclass"("id");

-- CreateIndex
CREATE INDEX "Feat_id_idx" ON "Feat"("id");

-- CreateIndex
CREATE INDEX "ClassFeats_classId_idx" ON "ClassFeats"("classId");

-- CreateIndex
CREATE UNIQUE INDEX "ClassFeats_featId_classId_key" ON "ClassFeats"("featId", "classId");

-- CreateIndex
CREATE INDEX "SubclassFeats_subclassId_idx" ON "SubclassFeats"("subclassId");

-- CreateIndex
CREATE UNIQUE INDEX "SubclassFeats_featId_subclassId_key" ON "SubclassFeats"("featId", "subclassId");

-- CreateIndex
CREATE INDEX "CampaignFeats_campaignId_idx" ON "CampaignFeats"("campaignId");

-- CreateIndex
CREATE UNIQUE INDEX "CampaignFeats_featId_campaignId_key" ON "CampaignFeats"("featId", "campaignId");

-- CreateIndex
CREATE INDEX "GeneralFeats_id_idx" ON "GeneralFeats"("id");

-- CreateIndex
CREATE UNIQUE INDEX "GeneralFeats_featId_key" ON "GeneralFeats"("featId");

-- CreateIndex
CREATE INDEX "Origin_id_idx" ON "Origin"("id");

-- CreateIndex
CREATE INDEX "CampaignOrigin_campaign_id_idx" ON "CampaignOrigin"("campaign_id");

-- CreateIndex
CREATE UNIQUE INDEX "CampaignOrigin_campaign_id_origin_id_key" ON "CampaignOrigin"("campaign_id", "origin_id");

-- CreateIndex
CREATE INDEX "Ritual_id_idx" ON "Ritual"("id");

-- CreateIndex
CREATE INDEX "CharacterRitual_character_id_idx" ON "CharacterRitual"("character_id");

-- CreateIndex
CREATE UNIQUE INDEX "CharacterRitual_character_id_ritual_id_key" ON "CharacterRitual"("character_id", "ritual_id");

-- CreateIndex
CREATE INDEX "DamageRitual_ritualId_idx" ON "DamageRitual"("ritualId");

-- CreateIndex
CREATE INDEX "CampaignRitual_campaign_id_idx" ON "CampaignRitual"("campaign_id");

-- CreateIndex
CREATE UNIQUE INDEX "CampaignRitual_campaign_id_ritual_id_key" ON "CampaignRitual"("campaign_id", "ritual_id");

-- CreateIndex
CREATE INDEX "Modification_id_idx" ON "Modification"("id");

-- CreateIndex
CREATE INDEX "CampaignModifications_campaign_id_idx" ON "CampaignModifications"("campaign_id");

-- CreateIndex
CREATE UNIQUE INDEX "CampaignModifications_campaign_id_modification_id_key" ON "CampaignModifications"("campaign_id", "modification_id");

-- CreateIndex
CREATE INDEX "Equipment_id_idx" ON "Equipment"("id");

-- CreateIndex
CREATE INDEX "CampaignEquipment_campaign_id_idx" ON "CampaignEquipment"("campaign_id");

-- CreateIndex
CREATE UNIQUE INDEX "CampaignEquipment_campaign_id_equipment_id_key" ON "CampaignEquipment"("campaign_id", "equipment_id");

-- CreateIndex
CREATE INDEX "Weapon_equipmentId_idx" ON "Weapon"("equipmentId");

-- CreateIndex
CREATE INDEX "CursedItem_equipmentId_idx" ON "CursedItem"("equipmentId");

-- AddForeignKey
ALTER TABLE "ip_track" ADD CONSTRAINT "ip_track_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerOnCampaign" ADD CONSTRAINT "PlayerOnCampaign_campaign_id_fkey" FOREIGN KEY ("campaign_id") REFERENCES "Campaign"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerOnCampaign" ADD CONSTRAINT "PlayerOnCampaign_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Campaign" ADD CONSTRAINT "Campaign_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Character" ADD CONSTRAINT "Character_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Character" ADD CONSTRAINT "Character_campaign_id_fkey" FOREIGN KEY ("campaign_id") REFERENCES "Campaign"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Character" ADD CONSTRAINT "Character_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "Class"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Character" ADD CONSTRAINT "Character_subclass_id_fkey" FOREIGN KEY ("subclass_id") REFERENCES "Subclass"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Character" ADD CONSTRAINT "Character_origin_id_fkey" FOREIGN KEY ("origin_id") REFERENCES "Origin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterFeat" ADD CONSTRAINT "CharacterFeat_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "Character"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterFeat" ADD CONSTRAINT "CharacterFeat_feat_id_fkey" FOREIGN KEY ("feat_id") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notes" ADD CONSTRAINT "Notes_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "Character"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notes" ADD CONSTRAINT "Notes_campaign_id_fkey" FOREIGN KEY ("campaign_id") REFERENCES "Campaign"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inventory" ADD CONSTRAINT "Inventory_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "Character"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventorySlot" ADD CONSTRAINT "InventorySlot_inventory_id_fkey" FOREIGN KEY ("inventory_id") REFERENCES "Inventory"("character_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventorySlot" ADD CONSTRAINT "InventorySlot_equipment_id_fkey" FOREIGN KEY ("equipment_id") REFERENCES "Equipment"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RitualCondition" ADD CONSTRAINT "RitualCondition_ritual_id_fkey" FOREIGN KEY ("ritual_id") REFERENCES "Ritual"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RitualCondition" ADD CONSTRAINT "RitualCondition_condition_id_fkey" FOREIGN KEY ("condition_id") REFERENCES "Condition"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterCondition" ADD CONSTRAINT "CharacterCondition_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "Character"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterCondition" ADD CONSTRAINT "CharacterCondition_condition_id_fkey" FOREIGN KEY ("condition_id") REFERENCES "Condition"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Subclass" ADD CONSTRAINT "Subclass_classId_fkey" FOREIGN KEY ("classId") REFERENCES "Class"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassFeats" ADD CONSTRAINT "ClassFeats_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassFeats" ADD CONSTRAINT "ClassFeats_classId_fkey" FOREIGN KEY ("classId") REFERENCES "Class"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubclassFeats" ADD CONSTRAINT "SubclassFeats_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubclassFeats" ADD CONSTRAINT "SubclassFeats_subclassId_fkey" FOREIGN KEY ("subclassId") REFERENCES "Subclass"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CampaignFeats" ADD CONSTRAINT "CampaignFeats_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CampaignFeats" ADD CONSTRAINT "CampaignFeats_campaignId_fkey" FOREIGN KEY ("campaignId") REFERENCES "Campaign"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GeneralFeats" ADD CONSTRAINT "GeneralFeats_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Origin" ADD CONSTRAINT "Origin_feat_id_fkey" FOREIGN KEY ("feat_id") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CampaignOrigin" ADD CONSTRAINT "CampaignOrigin_campaign_id_fkey" FOREIGN KEY ("campaign_id") REFERENCES "Campaign"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CampaignOrigin" ADD CONSTRAINT "CampaignOrigin_origin_id_fkey" FOREIGN KEY ("origin_id") REFERENCES "Origin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Skill" ADD CONSTRAINT "Skill_campaign_id_fkey" FOREIGN KEY ("campaign_id") REFERENCES "Campaign"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterRitual" ADD CONSTRAINT "CharacterRitual_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "Character"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterRitual" ADD CONSTRAINT "CharacterRitual_ritual_id_fkey" FOREIGN KEY ("ritual_id") REFERENCES "Ritual"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DamageRitual" ADD CONSTRAINT "DamageRitual_ritualId_fkey" FOREIGN KEY ("ritualId") REFERENCES "Ritual"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CampaignRitual" ADD CONSTRAINT "CampaignRitual_campaign_id_fkey" FOREIGN KEY ("campaign_id") REFERENCES "Campaign"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CampaignRitual" ADD CONSTRAINT "CampaignRitual_ritual_id_fkey" FOREIGN KEY ("ritual_id") REFERENCES "Ritual"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CampaignModifications" ADD CONSTRAINT "CampaignModifications_campaign_id_fkey" FOREIGN KEY ("campaign_id") REFERENCES "Campaign"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CampaignModifications" ADD CONSTRAINT "CampaignModifications_modification_id_fkey" FOREIGN KEY ("modification_id") REFERENCES "Modification"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CampaignEquipment" ADD CONSTRAINT "CampaignEquipment_campaign_id_fkey" FOREIGN KEY ("campaign_id") REFERENCES "Campaign"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CampaignEquipment" ADD CONSTRAINT "CampaignEquipment_equipment_id_fkey" FOREIGN KEY ("equipment_id") REFERENCES "Equipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Weapon" ADD CONSTRAINT "Weapon_equipmentId_fkey" FOREIGN KEY ("equipmentId") REFERENCES "Equipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursedItem" ADD CONSTRAINT "CursedItem_equipmentId_fkey" FOREIGN KEY ("equipmentId") REFERENCES "Equipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
