/*
  Warnings:

  - Added the required column `resistence` to the `Ritual` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
ALTER TYPE "DamageType" ADD VALUE 'ELETRIC';

-- AlterTable
ALTER TABLE "Ritual" ADD COLUMN     "resistence" TEXT NOT NULL;
