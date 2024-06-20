/*
  Warnings:

  - You are about to drop the column `addedEquipment` on the `Campaign` table. All the data in the column will be lost.
  - You are about to drop the `ClassFeat` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `GeneralFeat` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SubclassFeat` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[origin_id]` on the table `Character` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `origin_id` to the `Character` table without a default value. This is not possible if the table is not empty.
  - Added the required column `element` to the `Feat` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Proficiency" AS ENUM ('SIMPLE', 'TATICAL', 'HEAVY', 'LIGHT_ARMOR', 'HEAVY_ARMOR');

-- DropForeignKey
ALTER TABLE "ClassFeat" DROP CONSTRAINT "ClassFeat_classId_fkey";

-- DropForeignKey
ALTER TABLE "ClassFeat" DROP CONSTRAINT "ClassFeat_featId_fkey";

-- DropForeignKey
ALTER TABLE "GeneralFeat" DROP CONSTRAINT "GeneralFeat_featId_fkey";

-- DropForeignKey
ALTER TABLE "SubclassFeat" DROP CONSTRAINT "SubclassFeat_featId_fkey";

-- DropForeignKey
ALTER TABLE "SubclassFeat" DROP CONSTRAINT "SubclassFeat_subclassId_fkey";

-- AlterTable
ALTER TABLE "Accessory" ADD COLUMN     "characterUpgrades" JSONB[];

-- AlterTable
ALTER TABLE "Campaign" DROP COLUMN "addedEquipment";

-- AlterTable
ALTER TABLE "Character" ADD COLUMN     "origin_id" TEXT NOT NULL,
ADD COLUMN     "proficiencies" "Proficiency"[];

-- AlterTable
ALTER TABLE "Class" ADD COLUMN     "proficiencies" "Proficiency"[];

-- AlterTable
ALTER TABLE "Equipment" ADD COLUMN     "campaign_id" TEXT;

-- AlterTable
ALTER TABLE "Feat" ADD COLUMN     "classId" TEXT,
ADD COLUMN     "element" "Element" NOT NULL,
ADD COLUMN     "subClassId" TEXT;

-- DropTable
DROP TABLE "ClassFeat";

-- DropTable
DROP TABLE "GeneralFeat";

-- DropTable
DROP TABLE "SubclassFeat";

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
    "featId" TEXT NOT NULL,

    CONSTRAINT "Origin_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "GeneralFeats_featId_key" ON "GeneralFeats"("featId");

-- CreateIndex
CREATE UNIQUE INDEX "Origin_name_key" ON "Origin"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Origin_featId_key" ON "Origin"("featId");

-- CreateIndex
CREATE UNIQUE INDEX "Character_origin_id_key" ON "Character"("origin_id");

-- AddForeignKey
ALTER TABLE "Character" ADD CONSTRAINT "Character_origin_id_fkey" FOREIGN KEY ("origin_id") REFERENCES "Origin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feat" ADD CONSTRAINT "Feat_classId_fkey" FOREIGN KEY ("classId") REFERENCES "Class"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feat" ADD CONSTRAINT "Feat_subClassId_fkey" FOREIGN KEY ("subClassId") REFERENCES "Subclass"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GeneralFeats" ADD CONSTRAINT "GeneralFeats_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Origin" ADD CONSTRAINT "Origin_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Equipment" ADD CONSTRAINT "Equipment_campaign_id_fkey" FOREIGN KEY ("campaign_id") REFERENCES "Campaign"("id") ON DELETE SET NULL ON UPDATE CASCADE;
