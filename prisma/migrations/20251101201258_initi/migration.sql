-- CreateTable
CREATE TABLE "login_codes" (
    "id" SERIAL NOT NULL,
    "code" VARCHAR(6) NOT NULL,
    "ip" VARCHAR(45) NOT NULL,
    "user_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expires_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "login_codes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "login_codes_user_id_idx" ON "login_codes"("user_id");

-- AddForeignKey
ALTER TABLE "login_codes" ADD CONSTRAINT "login_codes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
