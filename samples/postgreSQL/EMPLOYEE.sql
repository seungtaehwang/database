-- 1. APP 스키마 생성 (없을 경우)
CREATE SCHEMA IF NOT EXISTS "APP";

-- 2. EMPLOYEE 테이블 생성
CREATE TABLE IF NOT EXISTS "APP"."EMPLOYEE"
(
    "EMP_ID"        VARCHAR(20)  NOT NULL, -- 사번 (PK)
    "LOGIN_ID"      VARCHAR(50)  NOT NULL, -- 로그인 계정 ID
    "PASSWORD"      TEXT         NOT NULL, -- 암호화된 비밀번호
    "EMP_NAME"      VARCHAR(100) NOT NULL, -- 성명
    
    -- [조직 정보]
    "DEPT_CD"       VARCHAR(20),           -- 부서 코드
    "DEPT_NAME"     VARCHAR(100),          -- 부서명
    "POSITION_CD"   VARCHAR(20),           -- 직급 코드 (예: MGR, STF, OPR)
    "JOB_TYPE"      VARCHAR(20),           -- 직무 (예: PRODUCTION, QUALITY, IT)

    -- [연락처 및 개인정보]
    "EMAIL"         VARCHAR(100),          -- 이메일
    "PHONE_NO"      VARCHAR(20),           -- 연락처 (010-3262-8359 형식)
    
    -- [보안 및 상태 - 추천 컬럼]
    "USE_YN"        CHAR(1)      DEFAULT 'Y', -- 계정 사용 여부 (Y/N)
    "AUTH_LEVEL"    INTEGER      DEFAULT 1,   -- 권한 레벨 (1: 일반, 9: 관리자)
    "SEC_LEVEL"     INTEGER      DEFAULT 1,   -- 보안 등급 (반도체 기밀 접근 제어용)
    "STATUS_CD"     VARCHAR(10)  DEFAULT 'JOIN', -- 상태 (JOIN: 재직, LEAVE: 퇴사, LOCK: 잠금)
    
    -- [로그인 관리 - 추천 컬럼]
    "LOGIN_FAIL_CNT" INTEGER     DEFAULT 0,   -- 로그인 실패 횟수 (보안 정책)
    "LAST_LOGIN_TIME" TIMESTAMP,               -- 마지막 로그인 일시
    "PWD_CHG_TIME"   TIMESTAMP,               -- 비밀번호 마지막 변경일
    
    -- [이력 관리]
    "CREATE_TIME"   TIMESTAMP    WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    "UPDATE_TIME"   TIMESTAMP    WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    "CREATE_USER"   VARCHAR(50),
    "UPDATE_USER"   VARCHAR(50),

    CONSTRAINT PK_EMPLOYEE PRIMARY KEY ("EMP_ID"),
    CONSTRAINT UQ_EMPLOYEE_LOGIN_ID UNIQUE ("LOGIN_ID")
)
TABLESPACE pg_default;

ALTER TABLE "APP"."EMPLOYEE" OWNER TO postgres;

-- 3. 검색 성능 최적화를 위한 인덱스
CREATE INDEX IDX_EMPLOYEE_DEPT ON "APP"."EMPLOYEE" ("DEPT_CD");
CREATE INDEX IDX_EMPLOYEE_NAME ON "APP"."EMPLOYEE" ("EMP_NAME");