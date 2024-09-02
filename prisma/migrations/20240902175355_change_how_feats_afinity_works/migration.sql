/*
  Warnings:

  - You are about to drop the column `afinity` on the `CampaignFeats` table. All the data in the column will be lost.
  - You are about to drop the column `afinityUpgrades` on the `CampaignFeats` table. All the data in the column will be lost.
  - You are about to drop the column `afinity` on the `GeneralFeats` table. All the data in the column will be lost.
  - You are about to drop the column `afinityUpgrades` on the `GeneralFeats` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "CampaignFeats" DROP COLUMN "afinity",
DROP COLUMN "afinityUpgrades";

-- AlterTable
ALTER TABLE "CharacterFeat" ADD COLUMN     "usingAfinity" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "Feat" ADD COLUMN     "afinity" TEXT,
ADD COLUMN     "afinityUpgrades" JSONB[];

-- AlterTable
ALTER TABLE "GeneralFeats" DROP COLUMN "afinity",
DROP COLUMN "afinityUpgrades";
