/*
  Warnings:

  - The values [CONSTITUTION] on the enum `Atribute` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `addedModifications` on the `Campaign` table. All the data in the column will be lost.
  - You are about to drop the column `addedRituals` on the `Campaign` table. All the data in the column will be lost.
  - You are about to drop the column `campaign_id` on the `Equipment` table. All the data in the column will be lost.
  - You are about to drop the column `campaignId` on the `Feat` table. All the data in the column will be lost.
  - You are about to drop the column `classId` on the `Feat` table. All the data in the column will be lost.
  - You are about to drop the column `subClassId` on the `Feat` table. All the data in the column will be lost.
  - You are about to drop the column `carry_info` on the `Inventory` table. All the data in the column will be lost.
  - You are about to drop the column `equipment` on the `Inventory` table. All the data in the column will be lost.
  - You are about to drop the column `featId` on the `Origin` table. All the data in the column will be lost.
  - You are about to drop the column `description` on the `Ritual` table. All the data in the column will be lost.
  - You are about to drop the `_CharacterToRitual` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `current_effort` to the `Character` table without a default value. This is not possible if the table is not empty.
  - Added the required column `current_health` to the `Character` table without a default value. This is not possible if the table is not empty.
  - Added the required column `current_sanity` to the `Character` table without a default value. This is not possible if the table is not empty.
  - Added the required column `max_effort` to the `Character` table without a default value. This is not possible if the table is not empty.
  - Added the required column `max_health` to the `Character` table without a default value. This is not possible if the table is not empty.
  - Added the required column `max_sanity` to the `Character` table without a default value. This is not possible if the table is not empty.
  - Added the required column `num_of_uses` to the `Equipment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `currentValue` to the `Inventory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `maxValue` to the `Inventory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `feat_id` to the `Origin` table without a default value. This is not possible if the table is not empty.
  - Added the required column `discentCastDescription` to the `Ritual` table without a default value. This is not possible if the table is not empty.
  - Added the required column `duration` to the `Ritual` table without a default value. This is not possible if the table is not empty.
  - Added the required column `exectutionTime` to the `Ritual` table without a default value. This is not possible if the table is not empty.
  - Added the required column `normalCastDescription` to the `Ritual` table without a default value. This is not possible if the table is not empty.
  - Added the required column `range` to the `Ritual` table without a default value. This is not possible if the table is not empty.
  - Added the required column `target` to the `Ritual` table without a default value. This is not possible if the table is not empty.
  - Added the required column `trueCastDescription` to the `Ritual` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `Ritual` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "RitualType" AS ENUM ('EFFECT', 'DAMAGE');

-- AlterEnum
BEGIN;
CREATE TYPE "Atribute_new" AS ENUM ('STRENGTH', 'DEXTERITY', 'VITALITY', 'INTELLIGENCE', 'PRESENCE');
ALTER TABLE "Skill" ALTER COLUMN "atribute" TYPE "Atribute_new" USING ("atribute"::text::"Atribute_new");
ALTER TYPE "Atribute" RENAME TO "Atribute_old";
ALTER TYPE "Atribute_new" RENAME TO "Atribute";
DROP TYPE "Atribute_old";
COMMIT;

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "DamageType" ADD VALUE 'CHEMICAL';
ALTER TYPE "DamageType" ADD VALUE 'POISON';
ALTER TYPE "DamageType" ADD VALUE 'BLOOD';
ALTER TYPE "DamageType" ADD VALUE 'FEAR';
ALTER TYPE "DamageType" ADD VALUE 'KNOWLEDGE';
ALTER TYPE "DamageType" ADD VALUE 'DEATH';
ALTER TYPE "DamageType" ADD VALUE 'ENERGY';

-- DropForeignKey
ALTER TABLE "Equipment" DROP CONSTRAINT "Equipment_campaign_id_fkey";

-- DropForeignKey
ALTER TABLE "Feat" DROP CONSTRAINT "Feat_campaignId_fkey";

-- DropForeignKey
ALTER TABLE "Feat" DROP CONSTRAINT "Feat_classId_fkey";

-- DropForeignKey
ALTER TABLE "Feat" DROP CONSTRAINT "Feat_subClassId_fkey";

-- DropForeignKey
ALTER TABLE "Origin" DROP CONSTRAINT "Origin_featId_fkey";

-- DropForeignKey
ALTER TABLE "_CharacterToRitual" DROP CONSTRAINT "_CharacterToRitual_A_fkey";

-- DropForeignKey
ALTER TABLE "_CharacterToRitual" DROP CONSTRAINT "_CharacterToRitual_B_fkey";

-- DropIndex
DROP INDEX "Character_origin_id_key";

-- DropIndex
DROP INDEX "Modification_name_key";

-- DropIndex
DROP INDEX "Origin_featId_key";

-- DropIndex
DROP INDEX "Origin_name_key";

-- DropIndex
DROP INDEX "Ritual_name_key";

-- DropIndex
DROP INDEX "Skill_name_key";

-- AlterTable
ALTER TABLE "Campaign" DROP COLUMN "addedModifications",
DROP COLUMN "addedRituals";

-- AlterTable
ALTER TABLE "Character" ADD COLUMN     "current_effort" INTEGER NOT NULL,
ADD COLUMN     "current_health" INTEGER NOT NULL,
ADD COLUMN     "current_sanity" INTEGER NOT NULL,
ADD COLUMN     "max_effort" INTEGER NOT NULL,
ADD COLUMN     "max_health" INTEGER NOT NULL,
ADD COLUMN     "max_sanity" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Equipment" DROP COLUMN "campaign_id",
ADD COLUMN     "num_of_uses" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Feat" DROP COLUMN "campaignId",
DROP COLUMN "classId",
DROP COLUMN "subClassId";

-- AlterTable
ALTER TABLE "Inventory" DROP COLUMN "carry_info",
DROP COLUMN "equipment",
ADD COLUMN     "alterations" JSONB[],
ADD COLUMN     "currentValue" INTEGER NOT NULL,
ADD COLUMN     "maxValue" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Origin" DROP COLUMN "featId",
ADD COLUMN     "feat_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Ritual" DROP COLUMN "description",
ADD COLUMN     "discentCastDescription" TEXT NOT NULL,
ADD COLUMN     "duration" TEXT NOT NULL,
ADD COLUMN     "exectutionTime" TEXT NOT NULL,
ADD COLUMN     "normalCastDescription" TEXT NOT NULL,
ADD COLUMN     "range" "Range" NOT NULL,
ADD COLUMN     "target" TEXT NOT NULL,
ADD COLUMN     "trueCastDescription" TEXT NOT NULL,
ADD COLUMN     "type" "RitualType" NOT NULL;

-- DropTable
DROP TABLE "_CharacterToRitual";

-- CreateTable
CREATE TABLE "InventorySlot" (
    "id" TEXT NOT NULL,
    "inventory_id" TEXT NOT NULL,
    "equipment_id" INTEGER NOT NULL,
    "uses" INTEGER NOT NULL DEFAULT 0,
    "category" INTEGER NOT NULL,
    "local_name" TEXT NOT NULL,
    "alterations" JSONB[],

    CONSTRAINT "InventorySlot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClassFeats" (
    "featId" TEXT NOT NULL,
    "classId" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "SubclassFeats" (
    "featId" TEXT NOT NULL,
    "subclassId" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "CampaignFeats" (
    "featId" TEXT NOT NULL,
    "campaignId" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "CampaignOrigin" (
    "id" TEXT NOT NULL,
    "campaign_id" TEXT NOT NULL,
    "origin_id" TEXT NOT NULL,

    CONSTRAINT "CampaignOrigin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterRitual" (
    "character_id" TEXT NOT NULL,
    "ritual_id" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "DamageRitual" (
    "ritualId" TEXT NOT NULL,
    "normalCastDamageType" "DamageType" NOT NULL,
    "discentCastDamageType" "DamageType" NOT NULL,
    "trueCastDamageType" "DamageType" NOT NULL,
    "normalCastDamage" TEXT NOT NULL,
    "discentCastDamage" TEXT NOT NULL,
    "trueCastDamage" TEXT NOT NULL,

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
CREATE TABLE "CampaignModifications" (
    "id" TEXT NOT NULL,
    "campaign_id" TEXT NOT NULL,
    "modification_id" TEXT NOT NULL,

    CONSTRAINT "CampaignModifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CampaignEquipment" (
    "id" TEXT NOT NULL,
    "campaign_id" TEXT NOT NULL,
    "equipment_id" INTEGER NOT NULL,

    CONSTRAINT "CampaignEquipment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ClassFeats_featId_classId_key" ON "ClassFeats"("featId", "classId");

-- CreateIndex
CREATE UNIQUE INDEX "SubclassFeats_featId_subclassId_key" ON "SubclassFeats"("featId", "subclassId");

-- CreateIndex
CREATE UNIQUE INDEX "CampaignFeats_featId_campaignId_key" ON "CampaignFeats"("featId", "campaignId");

-- CreateIndex
CREATE UNIQUE INDEX "CampaignOrigin_campaign_id_origin_id_key" ON "CampaignOrigin"("campaign_id", "origin_id");

-- CreateIndex
CREATE UNIQUE INDEX "CharacterRitual_character_id_ritual_id_key" ON "CharacterRitual"("character_id", "ritual_id");

-- CreateIndex
CREATE UNIQUE INDEX "CampaignRitual_campaign_id_ritual_id_key" ON "CampaignRitual"("campaign_id", "ritual_id");

-- CreateIndex
CREATE UNIQUE INDEX "CampaignModifications_campaign_id_modification_id_key" ON "CampaignModifications"("campaign_id", "modification_id");

-- CreateIndex
CREATE UNIQUE INDEX "CampaignEquipment_campaign_id_equipment_id_key" ON "CampaignEquipment"("campaign_id", "equipment_id");

-- AddForeignKey
ALTER TABLE "InventorySlot" ADD CONSTRAINT "InventorySlot_inventory_id_fkey" FOREIGN KEY ("inventory_id") REFERENCES "Inventory"("character_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventorySlot" ADD CONSTRAINT "InventorySlot_equipment_id_fkey" FOREIGN KEY ("equipment_id") REFERENCES "Equipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

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
ALTER TABLE "Origin" ADD CONSTRAINT "Origin_feat_id_fkey" FOREIGN KEY ("feat_id") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CampaignOrigin" ADD CONSTRAINT "CampaignOrigin_campaign_id_fkey" FOREIGN KEY ("campaign_id") REFERENCES "Campaign"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CampaignOrigin" ADD CONSTRAINT "CampaignOrigin_origin_id_fkey" FOREIGN KEY ("origin_id") REFERENCES "Origin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

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
