/*
  Warnings:

  - Added the required column `local_description` to the `InventorySlot` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "InventorySlot" ADD COLUMN     "local_description" TEXT NOT NULL;
