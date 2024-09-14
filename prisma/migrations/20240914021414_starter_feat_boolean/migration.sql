/*
  Warnings:

  - Added the required column `patent` to the `Inventory` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Patent" AS ENUM ('ROOKIE', 'OPERATOR', 'SPECIAL_AGENT', 'OPERATION_OFFICER', 'ELITE_AGENT');

-- AlterTable
ALTER TABLE "Character" ADD COLUMN     "num_of_skills" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "ClassFeats" ADD COLUMN     "isStarterFeat" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "Inventory" ADD COLUMN     "patent" "Patent" NOT NULL;
