/*
  Warnings:

  - Added the required column `normalCost` to the `Ritual` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "Range" ADD VALUE 'SELF';
ALTER TYPE "Range" ADD VALUE 'TOUCH';
ALTER TYPE "Range" ADD VALUE 'EXTREME';
ALTER TYPE "Range" ADD VALUE 'UNLIMITED';

-- AlterTable
ALTER TABLE "Ritual" ADD COLUMN     "normalCost" INTEGER NOT NULL,
ALTER COLUMN "discentCastDescription" DROP NOT NULL,
ALTER COLUMN "trueCastDescription" DROP NOT NULL,
ALTER COLUMN "discentCost" DROP NOT NULL,
ALTER COLUMN "trueCost" DROP NOT NULL;
