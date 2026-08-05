/* ================================================================
 * 회사 직속 사용자와 조직 미배정 사용자를 구분한다.
 * 대상 DB: MariaDB 10.6
 * 재실행 가능: ADD COLUMN IF NOT EXISTS 및 정규화 UPDATE 사용
 * ================================================================ */

ALTER TABLE user_info
    ADD COLUMN IF NOT EXISTS CO_DRCT_YN CHAR(1) NOT NULL DEFAULT 'N'
        COMMENT '회사직속여부' AFTER DEPT_ID;

UPDATE user_info
   SET CO_DRCT_YN = 'N'
 WHERE CO_DRCT_YN IS NULL
    OR CO_DRCT_YN NOT IN ('Y', 'N');
