/*
  Warnings:

  - You are about to drop the column `addedFeats` on the `Campaign` table. All the data in the column will be lost.

*/
-- AlterEnum
ALTER TYPE "FeatType" ADD VALUE 'CUSTOM';

-- AlterTable
ALTER TABLE "Campaign" DROP COLUMN "addedFeats";

-- AlterTable
ALTER TABLE "Feat" ADD COLUMN     "campaignId" TEXT;

-- AlterTable
ALTER TABLE "Skill" ADD COLUMN     "campaign_id" TEXT;

-- AddForeignKey
ALTER TABLE "Feat" ADD CONSTRAINT "Feat_campaignId_fkey" FOREIGN KEY ("campaignId") REFERENCES "Campaign"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Skill" ADD CONSTRAINT "Skill_campaign_id_fkey" FOREIGN KEY ("campaign_id") REFERENCES "Campaign"("id") ON DELETE SET NULL ON UPDATE CASCADE;
