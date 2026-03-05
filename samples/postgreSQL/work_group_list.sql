-- Table: public.work_group

-- DROP TABLE IF EXISTS public.work_group;

CREATE TABLE IF NOT EXISTS public.work_group
(
    group_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1001 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    module_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    folder character varying(255) COLLATE pg_catalog."default" NOT NULL,
    group_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    sort_order integer DEFAULT 0,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT work_group_pkey PRIMARY KEY (group_key),
    CONSTRAINT uk_work_group_name UNIQUE (module_id, group_name)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.work_group
    OWNER to postgres;
-- Index: idx_work_group_module

-- DROP INDEX IF EXISTS public.idx_work_group_module;

CREATE INDEX IF NOT EXISTS idx_work_group_module
    ON public.work_group USING btree
    (module_id COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;


-- Table: public.work_list

-- DROP TABLE IF EXISTS public.work_list;

CREATE TABLE IF NOT EXISTS public.work_list
(
    work_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    group_key bigint NOT NULL,
    work_title character varying(500) COLLATE pg_catalog."default" NOT NULL,
    content jsonb,
    status character varying(255) COLLATE pg_catalog."default" DEFAULT 'READY'::character varying,
    priority integer DEFAULT 3,
    tags text[] COLLATE pg_catalog."default",
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT work_list_pkey PRIMARY KEY (work_key),
    CONSTRAINT fk_work_group FOREIGN KEY (group_key)
        REFERENCES public.work_group (group_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.work_list
    OWNER to postgres;
-- Index: idx_work_list_group_key

-- DROP INDEX IF EXISTS public.idx_work_list_group_key;

CREATE INDEX IF NOT EXISTS idx_work_list_group_key
    ON public.work_list USING btree
    (group_key ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;	