/*
  Warnings:

  - You are about to drop the column `current_carry_weight` on the `Inventory` table. All the data in the column will be lost.
  - You are about to drop the column `max_carry_weight` on the `Inventory` table. All the data in the column will be lost.
  - Added the required column `carry_info` to the `Inventory` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Class" ADD COLUMN     "initialFeats" TEXT[];

-- AlterTable
ALTER TABLE "Inventory" DROP COLUMN "current_carry_weight",
DROP COLUMN "max_carry_weight",
ADD COLUMN     "carry_info" JSONB NOT NULL;
