/*
  Warnings:

  - The `normalCastDamage` column on the `DamageRitual` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `discentCastDamage` column on the `DamageRitual` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `trueCastDamage` column on the `DamageRitual` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Changed the column `normalCastDamageType` on the `DamageRitual` table from a scalar field to a list field. If there are non-null values in that column, this step will fail.
  - Changed the column `discentCastDamageType` on the `DamageRitual` table from a scalar field to a list field. If there are non-null values in that column, this step will fail.
  - Changed the column `trueCastDamageType` on the `DamageRitual` table from a scalar field to a list field. If there are non-null values in that column, this step will fail.

*/
-- AlterTable
ALTER TABLE "DamageRitual"
ALTER COLUMN "normalCastDamageType" SET DATA TYPE "DamageType"[] USING ARRAY["normalCastDamageType"],
ALTER COLUMN "discentCastDamageType" SET DATA TYPE "DamageType"[] USING ARRAY["discentCastDamageType"],
ALTER COLUMN "trueCastDamageType" SET DATA TYPE "DamageType"[] USING ARRAY["trueCastDamageType"],

-- Drop and re-add the damage columns as TEXT arrays
DROP COLUMN "normalCastDamage",
ADD COLUMN "normalCastDamage" TEXT[],

DROP COLUMN "discentCastDamage",
ADD COLUMN "discentCastDamage" TEXT[],

DROP COLUMN "trueCastDamage",
ADD COLUMN "trueCastDamage" TEXT[];

