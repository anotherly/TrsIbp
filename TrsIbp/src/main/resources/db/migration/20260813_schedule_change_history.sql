/* =========================================================
 * 일정 변경 이력
 * - 재실행 가능: 테이블이 이미 존재하면 유지한다.
 * - 일정 수정 시 변경 항목별 이전값/변경값과 수정자를 한 번의 저장 단위로 묶어 기록한다.
 * ========================================================= */
CREATE TABLE IF NOT EXISTS schdl_mdfcn_hstry (
    SCHDL_MDFCN_HSTRY_SN BIGINT NOT NULL AUTO_INCREMENT COMMENT '일정수정이력일련번호',
    SCHDL_SN BIGINT NOT NULL COMMENT '일정일련번호',
    MDFCN_GROUP_ID VARCHAR(36) NULL COMMENT '수정그룹아이디',
    CHG_ITM_NM VARCHAR(100) NOT NULL COMMENT '변경항목명',
    BFR_CHG_CN TEXT NULL COMMENT '변경전내용',
    AFTR_CHG_CN TEXT NULL COMMENT '변경후내용',
    MDFCN_DT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
    MDFR_ID VARCHAR(50) NOT NULL COMMENT '수정자아이디',
    PRIMARY KEY (SCHDL_MDFCN_HSTRY_SN),
    KEY IX_SCHDL_MDFCN_HSTRY_01 (SCHDL_SN, MDFCN_DT)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='일정수정이력';

/* 기존에 이력 테이블을 적용한 DB에도 수정 묶음 식별자를 보강한다. */
ALTER TABLE schdl_mdfcn_hstry
    ADD COLUMN IF NOT EXISTS MDFCN_GROUP_ID VARCHAR(36) NULL COMMENT '수정그룹아이디' AFTER SCHDL_SN;
