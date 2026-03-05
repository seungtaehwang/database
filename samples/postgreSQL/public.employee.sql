-- Table: public.employee

-- DROP TABLE IF EXISTS public.employee;

CREATE TABLE IF NOT EXISTS public.employee
(
    emp_id character varying(20) COLLATE pg_catalog."default" NOT NULL,
    login_id character varying(50) COLLATE pg_catalog."default" NOT NULL,
    password character varying(255) COLLATE pg_catalog."default" NOT NULL,
    emp_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    dept_cd character varying(255) COLLATE pg_catalog."default",
    position_cd character varying(20) COLLATE pg_catalog."default",
    job_type character varying(20) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    phone_no character varying(255) COLLATE pg_catalog."default",
    use_yn character(1) COLLATE pg_catalog."default" DEFAULT 'Y'::bpchar,
    auth_level integer DEFAULT 1,
    sec_level integer DEFAULT 1,
    status_cd character varying(255) COLLATE pg_catalog."default" DEFAULT 'JOIN'::character varying,
    login_fail_cnt integer DEFAULT 0,
    last_login_time timestamp without time zone,
    pwd_chg_time timestamp without time zone,
    create_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    create_user character varying(50) COLLATE pg_catalog."default",
    update_user character varying(50) COLLATE pg_catalog."default",
    emp_name_hash character varying(64) COLLATE pg_catalog."default",
    CONSTRAINT pk_employee PRIMARY KEY (emp_id),
    CONSTRAINT uq_employee_login_id UNIQUE (login_id),
    CONSTRAINT fk83bcvnqfc7k5p017g03rg1k4t FOREIGN KEY (dept_cd)
        REFERENCES public.department (dept_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.employee
    OWNER to postgres;
-- Index: idx_employee_dept

-- DROP INDEX IF EXISTS public.idx_employee_dept;

CREATE INDEX IF NOT EXISTS idx_employee_dept
    ON public.employee USING btree
    (dept_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;
-- Index: idx_employee_name

-- DROP INDEX IF EXISTS public.idx_employee_name;

CREATE INDEX IF NOT EXISTS idx_employee_name
    ON public.employee USING btree
    (emp_name COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;
-- Index: idx_employee_name_hash

-- DROP INDEX IF EXISTS public.idx_employee_name_hash;

CREATE INDEX IF NOT EXISTS idx_employee_name_hash
    ON public.employee USING btree
    (emp_name_hash COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;