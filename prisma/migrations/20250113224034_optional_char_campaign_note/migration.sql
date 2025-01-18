/*
  Warnings:

  - You are about to drop the column `description` on the `Notes` table. All the data in the column will be lost.
  - You are about to alter the column `title` on the `Notes` table. The data in that column could be lost. The data in that column will be cast from `VarChar(100)` to `VarChar(50)`.

*/
-- Create the Notes table
CREATE TABLE "Notes" (
  "id" TEXT PRIMARY KEY DEFAULT gen_random_uuid(),
  "title" VARCHAR(100) NOT NULL,
  "description" TEXT,
  "character_id" TEXT NOT NULL REFERENCES "Character"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  "campaign_id" TEXT NOT NULL REFERENCES "Campaign"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- DropForeignKey
ALTER TABLE "Notes" DROP CONSTRAINT "Notes_campaign_id_fkey";

-- DropForeignKey
ALTER TABLE "Notes" DROP CONSTRAINT "Notes_character_id_fkey";

-- AlterTable
ALTER TABLE "Notes" DROP COLUMN "description",
ADD COLUMN     "content" TEXT,
ALTER COLUMN "title" SET DATA TYPE VARCHAR(50),
ALTER COLUMN "character_id" DROP NOT NULL,
ALTER COLUMN "campaign_id" DROP NOT NULL;

-- CreateIndex
CREATE INDEX "User_username_idx" ON "User"("username");

-- CreateIndex
CREATE INDEX "User_email_idx" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Notes" ADD CONSTRAINT "Notes_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "Character"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notes" ADD CONSTRAINT "Notes_campaign_id_fkey" FOREIGN KEY ("campaign_id") REFERENCES "Campaign"("id") ON DELETE SET NULL ON UPDATE CASCADE;
