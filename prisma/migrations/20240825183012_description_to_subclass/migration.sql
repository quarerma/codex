/*
  Warnings:

  - Added the required column `description` to the `Subclass` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Subclass" ADD COLUMN     "description" TEXT NOT NULL;
