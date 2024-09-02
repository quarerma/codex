/*
  Warnings:

  - Added the required column `defense` to the `Character` table without a default value. This is not possible if the table is not empty.
  - Added the required column `speed` to the `Character` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ritual_cost` to the `CharacterRitual` table without a default value. This is not possible if the table is not empty.
  - Added the required column `discentCost` to the `Ritual` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ritualLevel` to the `Ritual` table without a default value. This is not possible if the table is not empty.
  - Added the required column `trueCost` to the `Ritual` table without a default value. This is not possible if the table is not empty.
  - Added the required column `levelRequired` to the `SubclassFeats` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Character" ADD COLUMN     "defense" INTEGER NOT NULL,
ADD COLUMN     "speed" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "CharacterRitual" ADD COLUMN     "alterations" JSONB[],
ADD COLUMN     "isUsingAfinity" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "ritual_cost" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Origin" ADD COLUMN     "skills" TEXT[];

-- AlterTable
ALTER TABLE "Ritual" ADD COLUMN     "discentCost" INTEGER NOT NULL,
ADD COLUMN     "ritualLevel" INTEGER NOT NULL,
ADD COLUMN     "trueCost" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "SubclassFeats" ADD COLUMN     "levelRequired" INTEGER NOT NULL;
