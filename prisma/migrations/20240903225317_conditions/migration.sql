/*
  Warnings:

  - You are about to drop the `Accessory` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Armor` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Accessory" DROP CONSTRAINT "Accessory_equipmentId_fkey";

-- DropForeignKey
ALTER TABLE "Armor" DROP CONSTRAINT "Armor_equipmentId_fkey";

-- AlterTable
ALTER TABLE "Class" ADD COLUMN     "number_of_skills" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "Equipment" ADD COLUMN     "characterUpgrades" JSONB[];

-- DropTable
DROP TABLE "Accessory";

-- DropTable
DROP TABLE "Armor";

-- CreateTable
CREATE TABLE "Condition" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "description" TEXT NOT NULL,
    "is_custom" BOOLEAN NOT NULL,

    CONSTRAINT "Condition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RitualCondition" (
    "ritual_id" TEXT NOT NULL,
    "condition_id" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "CharacterCondition" (
    "character_id" TEXT NOT NULL,
    "condition_id" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "RitualCondition_ritual_id_condition_id_key" ON "RitualCondition"("ritual_id", "condition_id");

-- CreateIndex
CREATE UNIQUE INDEX "CharacterCondition_character_id_condition_id_key" ON "CharacterCondition"("character_id", "condition_id");

-- AddForeignKey
ALTER TABLE "RitualCondition" ADD CONSTRAINT "RitualCondition_ritual_id_fkey" FOREIGN KEY ("ritual_id") REFERENCES "Ritual"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RitualCondition" ADD CONSTRAINT "RitualCondition_condition_id_fkey" FOREIGN KEY ("condition_id") REFERENCES "Condition"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterCondition" ADD CONSTRAINT "CharacterCondition_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "Character"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterCondition" ADD CONSTRAINT "CharacterCondition_condition_id_fkey" FOREIGN KEY ("condition_id") REFERENCES "Condition"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
