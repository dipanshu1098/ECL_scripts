ALTER TABLE IF EXISTS public."AnalyticEvents" ADD COLUMN IF NOT EXISTS "AcknowledgeRequired" boolean NOT NULL DEFAULT false;

DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN 
        SELECT table_name
        FROM information_schema.columns
        WHERE table_schema = 'events'
          AND column_name = 'AcknowledgeRequired'
    LOOP
        EXECUTE format(
            'UPDATE events.%I SET "AcknowledgeRequired" = false;',
            r.table_name
        );
    END LOOP;
END $$;





DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN 
        SELECT table_name
        FROM information_schema.columns
        WHERE table_schema = 'events'
          AND column_name = 'IsAcknowledged'
    LOOP
        EXECUTE format(
            'UPDATE events.%I SET "IsAcknowledged" = false;',
            r.table_name
        );
    END LOOP;
END $$;