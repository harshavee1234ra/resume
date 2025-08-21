/*
  # Add missing columns to resumes table

  1. New Columns
    - `personal_info` (jsonb) - stores personal information like name, email, phone
    - `summary` (text) - professional summary section
    - `experience` (jsonb) - work experience data
    - `education` (jsonb) - education information
    - `skills` (jsonb) - skills and competencies
    - `projects` (jsonb) - project information
    - `custom_sections` (jsonb) - additional custom sections
    - `template_id` (text) - template identifier
    - `ats_score` (integer) - ATS compatibility score
    - `is_published` (boolean) - publication status

  2. Updates
    - Set default values for new columns
    - Update existing records with empty defaults
*/

-- Add missing columns to resumes table
DO $$
BEGIN
  -- Add personal_info column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'resumes' AND column_name = 'personal_info'
  ) THEN
    ALTER TABLE resumes ADD COLUMN personal_info jsonb DEFAULT '{}';
  END IF;

  -- Add summary column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'resumes' AND column_name = 'summary'
  ) THEN
    ALTER TABLE resumes ADD COLUMN summary text;
  END IF;

  -- Add experience column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'resumes' AND column_name = 'experience'
  ) THEN
    ALTER TABLE resumes ADD COLUMN experience jsonb DEFAULT '{"items": []}';
  END IF;

  -- Add education column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'resumes' AND column_name = 'education'
  ) THEN
    ALTER TABLE resumes ADD COLUMN education jsonb DEFAULT '{"items": []}';
  END IF;

  -- Add skills column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'resumes' AND column_name = 'skills'
  ) THEN
    ALTER TABLE resumes ADD COLUMN skills jsonb DEFAULT '{"items": []}';
  END IF;

  -- Add projects column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'resumes' AND column_name = 'projects'
  ) THEN
    ALTER TABLE resumes ADD COLUMN projects jsonb DEFAULT '{"items": []}';
  END IF;

  -- Add custom_sections column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'resumes' AND column_name = 'custom_sections'
  ) THEN
    ALTER TABLE resumes ADD COLUMN custom_sections jsonb DEFAULT '[]';
  END IF;

  -- Add template_id column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'resumes' AND column_name = 'template_id'
  ) THEN
    ALTER TABLE resumes ADD COLUMN template_id text DEFAULT 'default';
  END IF;

  -- Add ats_score column
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'resumes' AND column_name = 'ats_score'
  ) THEN
    ALTER TABLE resumes ADD COLUMN ats_score integer;
  END IF;

  -- Add is_published column if it doesn't exist
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'resumes' AND column_name = 'is_published'
  ) THEN
    ALTER TABLE resumes ADD COLUMN is_published boolean DEFAULT false;
  END IF;

  -- Ensure created_at has proper default
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'resumes' AND column_name = 'created_at' AND column_default IS NULL
  ) THEN
    ALTER TABLE resumes ALTER COLUMN created_at SET DEFAULT now();
  END IF;

  -- Ensure updated_at has proper default
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'resumes' AND column_name = 'updated_at' AND column_default IS NULL
  ) THEN
    ALTER TABLE resumes ALTER COLUMN updated_at SET DEFAULT now();
  END IF;
END $$;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_resumes_user_id ON resumes(user_id);
CREATE INDEX IF NOT EXISTS idx_resumes_created_at ON resumes(created_at DESC);

-- Ensure the update trigger exists for resumes
CREATE TRIGGER IF NOT EXISTS update_resumes_updated_at
  BEFORE UPDATE ON resumes
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();