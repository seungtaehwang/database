-- Table: SOR.STEP_SEQ

-- DROP TABLE IF EXISTS "SOR"."STEP_SEQ";

CREATE TABLE IF NOT EXISTS "SOR"."STEP_SEQ"
(
    "STEP_KEY" character varying(50) COLLATE pg_catalog."default" NOT NULL,
    "STEP_SEQ" integer NOT NULL,
    "STEP_DESC" text COLLATE pg_catalog."default",
    "LINE_ID" character varying(20) COLLATE pg_catalog."default" NOT NULL,
    "PROCESS_ID" character varying(50) COLLATE pg_catalog."default" NOT NULL,
    "CREATE_TIME" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "UPDATE_TIME" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "STEP_TYPE" character varying(20) COLLATE pg_catalog."default",
    "USE_YN" character(1) COLLATE pg_catalog."default" DEFAULT 'Y'::bpchar,
    "REWORK_STEP_YN" character(1) COLLATE pg_catalog."default" DEFAULT 'N'::bpchar,
    "EAP_SKIP_YN" character(1) COLLATE pg_catalog."default" DEFAULT 'N'::bpchar,
    "CREATE_USER" character varying(50) COLLATE pg_catalog."default",
    "UPDATE_USER" character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT pk_step_seq PRIMARY KEY ("STEP_KEY")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "SOR"."STEP_SEQ"
    OWNER to postgres;
-- Index: idx_step_seq_line_process

-- DROP INDEX IF EXISTS "SOR".idx_step_seq_line_process;

CREATE INDEX IF NOT EXISTS idx_step_seq_line_process
    ON "SOR"."STEP_SEQ" USING btree
    ("LINE_ID" COLLATE pg_catalog."default" ASC NULLS LAST, "PROCESS_ID" COLLATE pg_catalog."default" ASC NULLS LAST, "STEP_SEQ" ASC NULLS LAST, "STEP_TYPE" COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;

-- Trigger: trg_step_seq_modtime

-- DROP TRIGGER IF EXISTS trg_step_seq_modtime ON "SOR"."STEP_SEQ";

CREATE OR REPLACE TRIGGER trg_step_seq_modtime
    BEFORE UPDATE 
    ON "SOR"."STEP_SEQ"
    FOR EACH ROW
    EXECUTE FUNCTION "SOR".update_modified_column();