/*
  Warnings:

  - You are about to drop the column `ip` on the `login_codes` table. All the data in the column will be lost.
  - You are about to drop the `ip_track` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `device_id` to the `login_codes` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "ip_track" DROP CONSTRAINT "ip_track_user_id_fkey";

-- AlterTable
ALTER TABLE "login_codes" DROP COLUMN "ip",
ADD COLUMN     "device_id" TEXT NOT NULL;

-- DropTable
DROP TABLE "ip_track";

-- CreateTable
CREATE TABLE "user_devices" (
    "id" SERIAL NOT NULL,
    "user_id" TEXT NOT NULL,
    "fingerprint_hash" TEXT NOT NULL,
    "fingerprint_data" JSONB NOT NULL,
    "device_id" TEXT NOT NULL,
    "user_agent" TEXT NOT NULL,
    "device_secret_hash" TEXT NOT NULL,
    "last_login" TIMESTAMP(3) NOT NULL,
    "last_used_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expires_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_devices_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "user_devices_user_id_idx" ON "user_devices"("user_id");

-- CreateIndex
CREATE INDEX "user_devices_device_id_fingerprint_hash_idx" ON "user_devices"("device_id", "fingerprint_hash");

-- AddForeignKey
ALTER TABLE "user_devices" ADD CONSTRAINT "user_devices_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
