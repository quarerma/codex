/*
  Warnings:

  - You are about to drop the `_CharacterToFeat` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_CharacterToFeat" DROP CONSTRAINT "_CharacterToFeat_A_fkey";

-- DropForeignKey
ALTER TABLE "_CharacterToFeat" DROP CONSTRAINT "_CharacterToFeat_B_fkey";

-- AlterTable
ALTER TABLE "CampaignFeats" ADD COLUMN     "afinity" TEXT,
ADD COLUMN     "afinityUpgrades" JSONB[];

-- AlterTable
ALTER TABLE "GeneralFeats" ADD COLUMN     "afinity" TEXT,
ADD COLUMN     "afinityUpgrades" JSONB[];

-- DropTable
DROP TABLE "_CharacterToFeat";

-- CreateTable
CREATE TABLE "CharacterFeat" (
    "character_id" TEXT NOT NULL,
    "feat_id" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "CharacterFeat_character_id_feat_id_key" ON "CharacterFeat"("character_id", "feat_id");

-- AddForeignKey
ALTER TABLE "CharacterFeat" ADD CONSTRAINT "CharacterFeat_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "Character"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterFeat" ADD CONSTRAINT "CharacterFeat_feat_id_fkey" FOREIGN KEY ("feat_id") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
