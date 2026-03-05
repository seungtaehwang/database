-- Table: public.app_log

-- DROP TABLE IF EXISTS public.app_log;

CREATE TABLE IF NOT EXISTS public.app_log
(
    log_id bigint NOT NULL DEFAULT nextval('app_log_log_id_seq'::regclass),
    log_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    user_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    user_name character varying(255) COLLATE pg_catalog."default",
    session_id character varying(255) COLLATE pg_catalog."default",
    user_ip character varying(255) COLLATE pg_catalog."default",
    user_agent character varying(255) COLLATE pg_catalog."default",
    module_nm character varying(255) COLLATE pg_catalog."default" NOT NULL,
    action_cd character varying(255) COLLATE pg_catalog."default" NOT NULL,
    screen_url character varying(255) COLLATE pg_catalog."default",
    target_id character varying(255) COLLATE pg_catalog."default",
    prev_data jsonb,
    param_data jsonb,
    result_status character varying(255) COLLATE pg_catalog."default" DEFAULT 'SUCCESS'::character varying,
    err_code character varying(255) COLLATE pg_catalog."default",
    err_msg character varying(255) COLLATE pg_catalog."default",
    exec_time_ms integer,
    app_ver character varying(255) COLLATE pg_catalog."default",
    dept_name character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT pk_app_log PRIMARY KEY (log_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.app_log
    OWNER to postgres;
-- Index: idx_app_log_time

-- DROP INDEX IF EXISTS public.idx_app_log_time;

CREATE INDEX IF NOT EXISTS idx_app_log_time
    ON public.app_log USING btree
    (log_time DESC NULLS FIRST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;
-- Index: idx_app_log_user_action

-- DROP INDEX IF EXISTS public.idx_app_log_user_action;

CREATE INDEX IF NOT EXISTS idx_app_log_user_action
    ON public.app_log USING btree
    (user_id COLLATE pg_catalog."default" ASC NULLS LAST, action_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;
-- Index: idx_app_log_user_name

-- DROP INDEX IF EXISTS public.idx_app_log_user_name;

CREATE INDEX IF NOT EXISTS idx_app_log_user_name
    ON public.app_log USING btree
    (user_name COLLATE pg_catalog."default" ASC NULLS LAST)
    WITH (fillfactor=100, deduplicate_items=True)
    TABLESPACE pg_default;