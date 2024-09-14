/*
  Warnings:

  - Added the required column `normalCost` to the `Ritual` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Ritual" ADD COLUMN     "normalCost" INTEGER NOT NULL,
ALTER COLUMN "discentCastDescription" DROP NOT NULL,
ALTER COLUMN "trueCastDescription" DROP NOT NULL,
ALTER COLUMN "discentCost" DROP NOT NULL,
ALTER COLUMN "trueCost" DROP NOT NULL;
