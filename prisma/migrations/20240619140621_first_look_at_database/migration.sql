-- CreateEnum
CREATE TYPE "ModificationType" AS ENUM ('MELEE_WEAPON', 'BULLET_WEAPON', 'BOLT_WEAPON', 'ARMOR', 'AMMO', 'ACESSORY');

-- CreateEnum
CREATE TYPE "Atribute" AS ENUM ('STRENGTH', 'DEXTERITY', 'CONSTITUTION', 'INTELLIGENCE', 'PRESENCE');

-- CreateEnum
CREATE TYPE "Credit" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'UNLIMITED');

-- CreateEnum
CREATE TYPE "HandType" AS ENUM ('LIGHT', 'ONE_HANDED', 'TWO_HANDED');

-- CreateEnum
CREATE TYPE "WeaponType" AS ENUM ('MELEE', 'BOLT', 'BULLET');

-- CreateEnum
CREATE TYPE "WeaponCategory" AS ENUM ('SIMPLE', 'TATICAL', 'HEAVY');

-- CreateEnum
CREATE TYPE "Element" AS ENUM ('REALITY', 'FEAR', 'BLOOD', 'DEATH', 'ENERGY', 'KNOWLEDGE');

-- CreateEnum
CREATE TYPE "ItemType" AS ENUM ('WEAPON', 'ARMOR', 'AMMO', 'ACESSORY', 'EXPLOSIVE', 'OPERATIONAL_EQUIPMENT', 'PARANORMAL_EQUIPMENT', 'CURSED_ITEM', 'DEFAULT');

-- CreateEnum
CREATE TYPE "Range" AS ENUM ('MELEE', 'SHORT', 'MEDIUM', 'LONG');

-- CreateEnum
CREATE TYPE "DamageType" AS ENUM ('PIERCING', 'BALISTIC', 'IMPACT', 'SLASHING', 'FIRE');

-- CreateEnum
CREATE TYPE "FeatType" AS ENUM ('CLASS', 'SUBCLASS', 'GENERAL');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "username" VARCHAR(50) NOT NULL,
    "password" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
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
    "addedEquipment" TEXT[],
    "addedRituals" TEXT[],
    "addedModifications" TEXT[],
    "addedFeats" TEXT[],

    CONSTRAINT "Campaign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Character" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "level" INTEGER NOT NULL,
    "owner_id" TEXT NOT NULL,
    "campaign_id" TEXT NOT NULL,
    "class_id" TEXT NOT NULL,
    "subclass_id" TEXT NOT NULL,
    "health_info" JSONB NOT NULL,
    "effort_info" JSONB NOT NULL,
    "sanity_info" JSONB NOT NULL,
    "atributes" JSONB NOT NULL,
    "skills" JSONB[],
    "attacks" JSONB[],

    CONSTRAINT "Character_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Inventory" (
    "character_id" TEXT NOT NULL,
    "max_carry_weight" INTEGER NOT NULL DEFAULT 2,
    "current_carry_weight" INTEGER NOT NULL DEFAULT 0,
    "credit" "Credit" NOT NULL DEFAULT 'LOW',
    "equipment" JSONB[],

    CONSTRAINT "Inventory_pkey" PRIMARY KEY ("character_id")
);

-- CreateTable
CREATE TABLE "Class" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,

    CONSTRAINT "Class_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Subclass" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
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

    CONSTRAINT "Feat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GeneralFeat" (
    "id" TEXT NOT NULL,
    "featId" TEXT NOT NULL,
    "element" "Element" NOT NULL,

    CONSTRAINT "GeneralFeat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClassFeat" (
    "id" TEXT NOT NULL,
    "classId" TEXT NOT NULL,
    "featId" TEXT NOT NULL,

    CONSTRAINT "ClassFeat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SubclassFeat" (
    "id" TEXT NOT NULL,
    "subclassId" TEXT NOT NULL,
    "featId" TEXT NOT NULL,

    CONSTRAINT "SubclassFeat_pkey" PRIMARY KEY ("id")
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

    CONSTRAINT "Skill_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "Ritual" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "element" "Element" NOT NULL,
    "is_custom" BOOLEAN NOT NULL,

    CONSTRAINT "Ritual_pkey" PRIMARY KEY ("id")
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
CREATE TABLE "Equipment" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "weight" INTEGER NOT NULL,
    "category" INTEGER NOT NULL,
    "type" "ItemType" NOT NULL,
    "is_custom" BOOLEAN NOT NULL,

    CONSTRAINT "Equipment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Weapon" (
    "equipmentId" INTEGER NOT NULL,
    "damage" TEXT[],
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
CREATE TABLE "Armor" (
    "equipmentId" INTEGER NOT NULL,
    "defense" INTEGER NOT NULL,
    "damage_reduction" INTEGER NOT NULL,

    CONSTRAINT "Armor_pkey" PRIMARY KEY ("equipmentId")
);

-- CreateTable
CREATE TABLE "Accessory" (
    "equipmentId" INTEGER NOT NULL,
    "skill_check" TEXT NOT NULL,

    CONSTRAINT "Accessory_pkey" PRIMARY KEY ("equipmentId")
);

-- CreateTable
CREATE TABLE "CursedItem" (
    "equipmentId" INTEGER NOT NULL,
    "element" "Element" NOT NULL,

    CONSTRAINT "CursedItem_pkey" PRIMARY KEY ("equipmentId")
);

-- CreateTable
CREATE TABLE "_CharacterToFeat" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_CharacterToRitual" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "PlayerOnCampaign_campaign_id_player_id_key" ON "PlayerOnCampaign"("campaign_id", "player_id");

-- CreateIndex
CREATE UNIQUE INDEX "ClassFeat_classId_featId_key" ON "ClassFeat"("classId", "featId");

-- CreateIndex
CREATE UNIQUE INDEX "SubclassFeat_subclassId_featId_key" ON "SubclassFeat"("subclassId", "featId");

-- CreateIndex
CREATE UNIQUE INDEX "Skill_name_key" ON "Skill"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Ritual_name_key" ON "Ritual"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Modification_name_key" ON "Modification"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Equipment_name_key" ON "Equipment"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_CharacterToFeat_AB_unique" ON "_CharacterToFeat"("A", "B");

-- CreateIndex
CREATE INDEX "_CharacterToFeat_B_index" ON "_CharacterToFeat"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CharacterToRitual_AB_unique" ON "_CharacterToRitual"("A", "B");

-- CreateIndex
CREATE INDEX "_CharacterToRitual_B_index" ON "_CharacterToRitual"("B");

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
ALTER TABLE "Inventory" ADD CONSTRAINT "Inventory_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "Character"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Subclass" ADD CONSTRAINT "Subclass_classId_fkey" FOREIGN KEY ("classId") REFERENCES "Class"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GeneralFeat" ADD CONSTRAINT "GeneralFeat_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassFeat" ADD CONSTRAINT "ClassFeat_classId_fkey" FOREIGN KEY ("classId") REFERENCES "Class"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassFeat" ADD CONSTRAINT "ClassFeat_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubclassFeat" ADD CONSTRAINT "SubclassFeat_subclassId_fkey" FOREIGN KEY ("subclassId") REFERENCES "Subclass"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubclassFeat" ADD CONSTRAINT "SubclassFeat_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Weapon" ADD CONSTRAINT "Weapon_equipmentId_fkey" FOREIGN KEY ("equipmentId") REFERENCES "Equipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Armor" ADD CONSTRAINT "Armor_equipmentId_fkey" FOREIGN KEY ("equipmentId") REFERENCES "Equipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Accessory" ADD CONSTRAINT "Accessory_equipmentId_fkey" FOREIGN KEY ("equipmentId") REFERENCES "Equipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CursedItem" ADD CONSTRAINT "CursedItem_equipmentId_fkey" FOREIGN KEY ("equipmentId") REFERENCES "Equipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CharacterToFeat" ADD CONSTRAINT "_CharacterToFeat_A_fkey" FOREIGN KEY ("A") REFERENCES "Character"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CharacterToFeat" ADD CONSTRAINT "_CharacterToFeat_B_fkey" FOREIGN KEY ("B") REFERENCES "Feat"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CharacterToRitual" ADD CONSTRAINT "_CharacterToRitual_A_fkey" FOREIGN KEY ("A") REFERENCES "Character"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CharacterToRitual" ADD CONSTRAINT "_CharacterToRitual_B_fkey" FOREIGN KEY ("B") REFERENCES "Ritual"("id") ON DELETE CASCADE ON UPDATE CASCADE;
