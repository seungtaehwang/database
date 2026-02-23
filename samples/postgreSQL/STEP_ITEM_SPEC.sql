-- 1. STEP_ITEM_SPEC 테이블 생성 (대문자 식별자 적용)
CREATE TABLE "SOR"."STEP_ITEM_SPEC" (
    "STEP_KEY"      VARCHAR(50)  NOT NULL, -- STEP_SEQ 테이블 참조 (FK)
    "ITEM_ID"       VARCHAR(50)  NOT NULL, -- 항목 식별자 (예: THK, TEMP, PRESS)
    "ITEM_NAME"     VARCHAR(100),          -- 항목명 (예: Thickness, Temperature)
    "TARGET"        NUMERIC(18, 5),        -- 목표치
    "LSL"           NUMERIC(18, 5),        -- Lower Specification Limit (하한규격)
    "USL"           NUMERIC(18, 5),        -- Upper Specification Limit (상한규격)
    "LCL"           NUMERIC(18, 5),        -- Lower Control Limit (하한관리선)
    "UCL"           NUMERIC(18, 5),        -- Upper Control Limit (상한관리선)
    "UNIT"          VARCHAR(20),           -- 측정 단위 (Å, ℃, Pa 등)
    "USE_YN"        CHAR(1)      DEFAULT 'Y', -- 사용 여부 (Y/N)
    "CREATE_TIME"   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    "UPDATE_TIME"   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    
    -- PK: 스텝키와 항목ID의 조합으로 고유성 보장
    CONSTRAINT PK_STEP_ITEM_SPEC PRIMARY KEY ("STEP_KEY", "ITEM_ID"),
    
    -- FK: STEP_SEQ 테이블과의 참조 무결성 유지
    CONSTRAINT FK_STEP_ITEM_SPEC_STEP_KEY FOREIGN KEY ("STEP_KEY") 
        REFERENCES "SOR"."STEP_SEQ" ("STEP_KEY") ON DELETE CASCADE
);

-- 2. 성능 최적화를 위한 인덱스 (ITEM_ID 기준 검색용)
CREATE INDEX IDX_STEP_ITEM_SPEC_ITEM ON "SOR"."STEP_ITEM_SPEC" ("ITEM_ID");

-- 3. UPDATE_TIME 자동 갱신 트리거 적용
CREATE TRIGGER TRG_STEP_ITEM_SPEC_MODTIME
    BEFORE UPDATE ON "SOR"."STEP_ITEM_SPEC"
    FOR EACH ROW
    EXECUTE PROCEDURE "SOR".UPDATE_MODIFIED_COLUMN();