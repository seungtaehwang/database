-- Table: public.department

-- DROP TABLE IF EXISTS public.department;

CREATE TABLE IF NOT EXISTS public.department
(
    dept_cd character varying(255) COLLATE pg_catalog."default" NOT NULL,
    parent_dept_cd character varying(20) COLLATE pg_catalog."default",
    dept_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    dept_eng_name character varying(255) COLLATE pg_catalog."default",
    mgr_emp_id character varying(20) COLLATE pg_catalog."default",
    dept_level integer DEFAULT 1,
    sort_order integer DEFAULT 0,
    use_yn character(1) COLLATE pg_catalog."default" DEFAULT 'Y'::bpchar,
    location character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    create_user character varying(50) COLLATE pg_catalog."default",
    update_user character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT pk_department PRIMARY KEY (dept_cd),
    CONSTRAINT fk_parent_dept FOREIGN KEY (parent_dept_cd)
        REFERENCES public.department (dept_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE SET NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.department
    OWNER to postgres;
-- Index: idx_dept_name

-- DROP INDEX IF EXISTS public.idx_dept_name;

CREATE INDEX IF NOT EXISTS idx_dept_name
    ON public.department USING btree
    (dept_name COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;
-- Index: idx_dept_parent

-- DROP INDEX IF EXISTS public.idx_dept_parent;

CREATE INDEX IF NOT EXISTS idx_dept_parent
    ON public.department USING btree
    (parent_dept_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;