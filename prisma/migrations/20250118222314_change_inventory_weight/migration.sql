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
ALTER COLUMN "equipment_id" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Notes" ALTER COLUMN "id" DROP DEFAULT;

-- AddForeignKey
ALTER TABLE "InventorySlot" ADD CONSTRAINT "InventorySlot_equipment_id_fkey" FOREIGN KEY ("equipment_id") REFERENCES "Equipment"("id") ON DELETE SET NULL ON UPDATE CASCADE;
