/*
  Warnings:

  - You are about to drop the column `isUsingAfinity` on the `CharacterRitual` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "CharacterRitual" DROP COLUMN "isUsingAfinity";

-- AlterTable
ALTER TABLE "DamageRitual" ALTER COLUMN "normalCastDamageType" DROP NOT NULL,
ALTER COLUMN "discentCastDamageType" DROP NOT NULL,
ALTER COLUMN "trueCastDamageType" DROP NOT NULL,
ALTER COLUMN "normalCastDamage" DROP NOT NULL,
ALTER COLUMN "discentCastDamage" DROP NOT NULL,
ALTER COLUMN "trueCastDamage" DROP NOT NULL;
