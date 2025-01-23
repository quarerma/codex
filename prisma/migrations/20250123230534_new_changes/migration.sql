/*
  Warnings:

  - You are about to drop the column `currentValue` on the `Inventory` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "InventorySlot" DROP CONSTRAINT "InventorySlot_equipment_id_fkey";

-- AlterTable
ALTER TABLE "Inventory" DROP COLUMN "currentValue";

-- AlterTable
ALTER TABLE "InventorySlot" ADD COLUMN     "weight" INTEGER NOT NULL DEFAULT 0,
ALTER COLUMN "equipment_id" DROP NOT NULL,
ALTER COLUMN "is_equipped" SET DEFAULT true,
ALTER COLUMN "local_description" DROP NOT NULL,
ALTER COLUMN "local_description" SET DEFAULT '';

-- CreateTable
CREATE TABLE "Notes" (
    "id" TEXT NOT NULL,
    "title" VARCHAR(50) NOT NULL,
    "content" TEXT,
    "character_id" TEXT,
    "campaign_id" TEXT,

    CONSTRAINT "Notes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Notes_id_idx" ON "Notes"("id");

-- CreateIndex
CREATE INDEX "Campaign_owner_id_idx" ON "Campaign"("owner_id");

-- CreateIndex
CREATE INDEX "CampaignEquipment_campaign_id_idx" ON "CampaignEquipment"("campaign_id");

-- CreateIndex
CREATE INDEX "CampaignFeats_campaignId_idx" ON "CampaignFeats"("campaignId");

-- CreateIndex
CREATE INDEX "CampaignModifications_campaign_id_idx" ON "CampaignModifications"("campaign_id");

-- CreateIndex
CREATE INDEX "CampaignOrigin_campaign_id_idx" ON "CampaignOrigin"("campaign_id");

-- CreateIndex
CREATE INDEX "CampaignRitual_campaign_id_idx" ON "CampaignRitual"("campaign_id");

-- CreateIndex
CREATE INDEX "Character_owner_id_idx" ON "Character"("owner_id");

-- CreateIndex
CREATE INDEX "Character_campaign_id_idx" ON "Character"("campaign_id");

-- CreateIndex
CREATE INDEX "Character_class_id_idx" ON "Character"("class_id");

-- CreateIndex
CREATE INDEX "CharacterCondition_character_id_idx" ON "CharacterCondition"("character_id");

-- CreateIndex
CREATE INDEX "CharacterFeat_character_id_idx" ON "CharacterFeat"("character_id");

-- CreateIndex
CREATE INDEX "CharacterRitual_character_id_idx" ON "CharacterRitual"("character_id");

-- CreateIndex
CREATE INDEX "Class_id_idx" ON "Class"("id");

-- CreateIndex
CREATE INDEX "ClassFeats_classId_idx" ON "ClassFeats"("classId");

-- CreateIndex
CREATE INDEX "Condition_id_idx" ON "Condition"("id");

-- CreateIndex
CREATE INDEX "CursedItem_equipmentId_idx" ON "CursedItem"("equipmentId");

-- CreateIndex
CREATE INDEX "DamageRitual_ritualId_idx" ON "DamageRitual"("ritualId");

-- CreateIndex
CREATE INDEX "Equipment_id_idx" ON "Equipment"("id");

-- CreateIndex
CREATE INDEX "Feat_id_idx" ON "Feat"("id");

-- CreateIndex
CREATE INDEX "GeneralFeats_id_idx" ON "GeneralFeats"("id");

-- CreateIndex
CREATE INDEX "Inventory_character_id_idx" ON "Inventory"("character_id");

-- CreateIndex
CREATE INDEX "InventorySlot_id_idx" ON "InventorySlot"("id");

-- CreateIndex
CREATE INDEX "Modification_id_idx" ON "Modification"("id");

-- CreateIndex
CREATE INDEX "Origin_id_idx" ON "Origin"("id");

-- CreateIndex
CREATE INDEX "PlayerOnCampaign_campaign_id_idx" ON "PlayerOnCampaign"("campaign_id");

-- CreateIndex
CREATE INDEX "PlayerOnCampaign_player_id_idx" ON "PlayerOnCampaign"("player_id");

-- CreateIndex
CREATE INDEX "Ritual_id_idx" ON "Ritual"("id");

-- CreateIndex
CREATE INDEX "RitualCondition_ritual_id_idx" ON "RitualCondition"("ritual_id");

-- CreateIndex
CREATE INDEX "Subclass_id_idx" ON "Subclass"("id");

-- CreateIndex
CREATE INDEX "SubclassFeats_subclassId_idx" ON "SubclassFeats"("subclassId");

-- CreateIndex
CREATE INDEX "User_username_idx" ON "User"("username");

-- CreateIndex
CREATE INDEX "User_email_idx" ON "User"("email");

-- CreateIndex
CREATE INDEX "User_id_idx" ON "User"("id");

-- CreateIndex
CREATE INDEX "Weapon_equipmentId_idx" ON "Weapon"("equipmentId");

-- AddForeignKey
ALTER TABLE "Notes" ADD CONSTRAINT "Notes_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "Character"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notes" ADD CONSTRAINT "Notes_campaign_id_fkey" FOREIGN KEY ("campaign_id") REFERENCES "Campaign"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventorySlot" ADD CONSTRAINT "InventorySlot_equipment_id_fkey" FOREIGN KEY ("equipment_id") REFERENCES "Equipment"("id") ON DELETE SET NULL ON UPDATE CASCADE;
