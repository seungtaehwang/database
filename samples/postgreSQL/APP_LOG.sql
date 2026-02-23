-- 1. APP 스키마 생성
CREATE SCHEMA IF NOT EXISTS "APP";

-- 2. APP_LOG 테이블 생성
CREATE TABLE IF NOT EXISTS "APP"."APP_LOG"
(
    "LOG_ID"        BIGSERIAL    NOT NULL, -- 로그 고유 번호 (자동 증가)
    "LOG_TIME"      TIMESTAMP    WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- [사용자 및 세션 정보]
    "USER_ID"       VARCHAR(50)  NOT NULL, -- 작업자 사번/ID
    "SESSION_ID"    VARCHAR(100),          -- 중복 로그인 확인 및 세션 추적용 (추천)
    "USER_IP"       VARCHAR(45),           -- 접속 IP 주소
    "USER_AGENT"    TEXT,                  -- 접속 브라우저/OS 정보 (추천)
    
    -- [위치 및 액션 정보]
    "MODULE_NM"     VARCHAR(100) NOT NULL, -- 메뉴/모듈명 (예: STEP_MGMT, SPEC_VIEW)
    "ACTION_CD"     VARCHAR(20)  NOT NULL, -- LOGIN, LOGOUT, VIEW, RUN, EXEC, CREATE, UPDATE, END
    "SCREEN_URL"    TEXT,                  -- 실제 접속 URL (추천)
    
    -- [데이터 및 실행 상세]
    "TARGET_ID"     VARCHAR(100),          -- 영향 받은 데이터 PK (예: STEP_KEY 'ST-001')
    "PREV_DATA"     JSONB,                 -- 수정 전 데이터 (추천: 데이터 복구용)
    "PARAM_DATA"    JSONB,                 -- 전달 파라미터 또는 수정 후 데이터
    
    -- [결과 및 성능]
    "RESULT_STATUS" VARCHAR(10)  DEFAULT 'SUCCESS', -- SUCCESS, FAIL, ERROR
    "ERR_CODE"      VARCHAR(20),           -- 에러 코드 (추천)
    "ERR_MSG"       TEXT,                  -- 상세 에러 내용
    "EXEC_TIME_MS"  INTEGER,               -- 실행 소요 시간 (성능 모니터링용)
    
    -- [추가 식별자]
    "APP_VER"       VARCHAR(20),           -- 앱 배포 버전 (추천: 버그 추적용)
    
    CONSTRAINT PK_APP_LOG PRIMARY KEY ("LOG_ID")
)
TABLESPACE pg_default;

ALTER TABLE "APP"."APP_LOG" OWNER TO postgres;

-- 3. 인덱스 설정
CREATE INDEX IDX_APP_LOG_TIME ON "APP"."APP_LOG" ("LOG_TIME" DESC);
CREATE INDEX IDX_APP_LOG_USER_ACTION ON "APP"."APP_LOG" ("USER_ID", "ACTION_CD");
CREATE INDEX IDX_APP_LOG_TARGET ON "APP"."APP_LOG" ("TARGET_ID") WHERE "TARGET_ID" IS NOT NULL;