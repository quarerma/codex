/*
  Warnings:

  - Added the required column `SanityPointsPerLevel` to the `Class` table without a default value. This is not possible if the table is not empty.
  - Added the required column `effortPointsPerLevel` to the `Class` table without a default value. This is not possible if the table is not empty.
  - Added the required column `hitPointsPerLevel` to the `Class` table without a default value. This is not possible if the table is not empty.
  - Added the required column `initialEffort` to the `Class` table without a default value. This is not possible if the table is not empty.
  - Added the required column `initialHealth` to the `Class` table without a default value. This is not possible if the table is not empty.
  - Added the required column `initialSanity` to the `Class` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Class" ADD COLUMN     "SanityPointsPerLevel" INTEGER NOT NULL,
ADD COLUMN     "effortPointsPerLevel" INTEGER NOT NULL,
ADD COLUMN     "hitPointsPerLevel" INTEGER NOT NULL,
ADD COLUMN     "initialEffort" INTEGER NOT NULL,
ADD COLUMN     "initialHealth" INTEGER NOT NULL,
ADD COLUMN     "initialSanity" INTEGER NOT NULL;
