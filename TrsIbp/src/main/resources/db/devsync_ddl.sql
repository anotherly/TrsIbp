-- ============================================================
-- DevSync IT 그룹웨어 - MariaDB 10.6 DDL 스크립트
-- 작성일: 2026-05-28
-- DB명: airhub (context-datasource.xml 기준)
-- ============================================================

-- ============================================================
-- 1. 권한코드 테이블 (SYS_AUTH)
-- ============================================================
CREATE TABLE IF NOT EXISTS SYS_AUTH (
    AUTH_CODE   VARCHAR(10)  NOT NULL COMMENT '권한코드',
    AUTH_NAME   VARCHAR(50)  NOT NULL COMMENT '권한명',
    AUTH_DESC   VARCHAR(200)     NULL COMMENT '권한설명',
    PRIMARY KEY (AUTH_CODE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='권한코드 테이블';

-- ============================================================
-- 2. 지역코드 테이블 (CODE_AREACODE)
-- ============================================================
CREATE TABLE IF NOT EXISTS CODE_AREACODE (
    AREA_CODE   VARCHAR(10)  NOT NULL COMMENT '지역코드',
    AREA_NAME   VARCHAR(100) NOT NULL COMMENT '지역명',
    AREA_DESC   VARCHAR(200)     NULL COMMENT '지역설명',
    FLAG_USE    CHAR(1)      NOT NULL DEFAULT 'Y' COMMENT '사용여부(Y/N)',
    PRIMARY KEY (AREA_CODE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='지역코드 테이블';

-- ============================================================
-- 3. 사용자 테이블 (SYS_USER)
-- ============================================================
CREATE TABLE IF NOT EXISTS SYS_USER (
    USER_ID     VARCHAR(50)  NOT NULL COMMENT '사용자ID',
    USER_PW     VARCHAR(200) NOT NULL COMMENT '비밀번호(BCrypt 해시)',
    USER_NAME   VARCHAR(100) NOT NULL COMMENT '사용자명',
    REGION_ID   VARCHAR(10)      NULL COMMENT '소속지역코드 (CODE_AREACODE.AREA_CODE)',
    USER_TEL    VARCHAR(20)      NULL COMMENT '연락처',
    AUTH_CODE   VARCHAR(10)      NULL COMMENT '권한코드 (SYS_AUTH.AUTH_CODE)',
    FLAG_USE    CHAR(1)      NOT NULL DEFAULT 'Y' COMMENT '사용여부(Y/N)',
    MEMO        VARCHAR(500)     NULL COMMENT '메모',
    IN_TEL      VARCHAR(20)      NULL COMMENT '내선번호',
    REG_DT      DATETIME         NULL DEFAULT NOW() COMMENT '가입일시',
    PRIMARY KEY (USER_ID),
    CONSTRAINT FK_SYS_USER_AUTH    FOREIGN KEY (AUTH_CODE) REFERENCES SYS_AUTH(AUTH_CODE),
    CONSTRAINT FK_SYS_USER_REGION  FOREIGN KEY (REGION_ID) REFERENCES CODE_AREACODE(AREA_CODE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='사용자 테이블';

-- ============================================================
-- 4. 로그인 이력 테이블 (LOGIN_HISTORY)
-- ============================================================
CREATE TABLE IF NOT EXISTS LOGIN_HISTORY (
    SEQ         BIGINT       NOT NULL AUTO_INCREMENT COMMENT '이력번호',
    USER_ID     VARCHAR(50)  NOT NULL COMMENT '사용자ID',
    ST_TIME     DATETIME         NULL COMMENT '로그인시간',
    FN_TIME     DATETIME         NULL COMMENT '로그아웃시간',
    LOGIN_IP    VARCHAR(50)      NULL COMMENT '접속IP',
    PRIMARY KEY (SEQ),
    INDEX IDX_LOGIN_HISTORY_USER (USER_ID),
    INDEX IDX_LOGIN_HISTORY_ST   (ST_TIME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='로그인 이력 테이블';

-- ============================================================
-- 5. 근태 이력 테이블 (ATTEND_HISTORY)
-- ============================================================
CREATE TABLE IF NOT EXISTS ATTEND_HISTORY (
    SEQ             BIGINT       NOT NULL AUTO_INCREMENT COMMENT '이력번호',
    USER_ID         VARCHAR(50)  NOT NULL COMMENT '사용자ID',
    WORK_DT         DATE         NOT NULL COMMENT '근무일자',
    CHECK_IN_TIME   DATETIME         NULL COMMENT '출근시간',
    CHECK_OUT_TIME  DATETIME         NULL COMMENT '퇴근시간',
    WORK_LOCATION   VARCHAR(20)      NULL DEFAULT 'OFFICE' COMMENT '근무지(OFFICE/HOME/OUTSIDE)',
    WORK_MEMO       VARCHAR(500)     NULL COMMENT '비고',
    REG_DT          DATETIME         NULL DEFAULT NOW() COMMENT '등록일시',
    UPD_DT          DATETIME         NULL COMMENT '수정일시',
    PRIMARY KEY (SEQ),
    UNIQUE KEY UQ_ATTEND_USER_DT (USER_ID, WORK_DT),
    INDEX IDX_ATTEND_HISTORY_DT  (WORK_DT)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='근태 이력 테이블';

-- ============================================================
-- 6. 초기 데이터 (권한코드)
-- ============================================================
INSERT IGNORE INTO SYS_AUTH (AUTH_CODE, AUTH_NAME, AUTH_DESC) VALUES
('999', '시스템관리자', '전체 시스템 관리 권한'),
('100', '일반사용자',   '기본 사용 권한');

-- ============================================================
-- 7. 초기 데이터 (지역코드)
-- ============================================================
INSERT IGNORE INTO CODE_AREACODE (AREA_CODE, AREA_NAME, AREA_DESC, FLAG_USE) VALUES
('HQ',   '본사',   '서울 본사',      'Y'),
('BR01', '1사업부', '1사업부 개발팀', 'Y'),
('BR02', '2사업부', '2사업부 개발팀', 'Y');

-- ============================================================
-- 8. 초기 데이터 (관리자 계정)
-- 비밀번호: admin1234 → BCrypt 해시
-- BCrypt 해시는 Java에서 생성해야 하므로 아래는 미리 생성된 값 사용
-- BCrypt.hashpw("admin1234", BCrypt.gensalt()) 결과값
-- ============================================================
INSERT IGNORE INTO SYS_USER (USER_ID, USER_PW, USER_NAME, REGION_ID, AUTH_CODE, FLAG_USE, MEMO, REG_DT)
VALUES (
    'admin',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lHmW',
    '시스템관리자',
    'HQ',
    '999',
    'Y',
    '초기 관리자 계정 (비밀번호: admin1234)',
    NOW()
);

-- ============================================================
-- 9. 확인 쿼리
-- ============================================================
-- SELECT * FROM SYS_AUTH;
-- SELECT * FROM CODE_AREACODE;
-- SELECT * FROM SYS_USER;
-- SHOW TABLES;
