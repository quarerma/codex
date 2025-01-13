-- Create the Notes table
CREATE TABLE "Notes" (
  "id" TEXT PRIMARY KEY DEFAULT gen_random_uuid(),
  "title" VARCHAR(100) NOT NULL,
  "description" TEXT,
  "character_id" TEXT NOT NULL REFERENCES "Character"("id") ON DELETE CASCADE ON UPDATE CASCADE,
  "campaign_id" TEXT NOT NULL REFERENCES "Campaign"("id") ON DELETE CASCADE ON UPDATE CASCADE
);
