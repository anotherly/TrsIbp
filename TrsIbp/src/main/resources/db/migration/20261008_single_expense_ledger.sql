-- TRS-IBP: 비용청구 + 회계관리 단일 원장 통합 (MariaDB 10.6+)
-- !!! 1회만 실행. 반드시 전체 DB를 백업하고 사이트를 중지한 점검시간에 진행하십시오.
-- 기준: 2026-10-08 14:00 local SQL. 기존 biz_cst 원장 74행 유지, claim은 4건 연결되어 있음.
-- 기존 expense_claim을 지우지 않고 expense_claim_backup_20261008로 보관합니다.
-- 중요: 변경 소스 배포와 본 SQL을 한 번의 점검시간에 적용해야 합니다.

-- [0] 사전 검증: 연결이 누락/중복/타회사인 청구 건이 있으면 이관을 중단합니다.
DELIMITER $$
DROP PROCEDURE IF EXISTS TRS_VERIFY_COST_MIGRATION $$
CREATE PROCEDURE TRS_VERIFY_COST_MIGRATION()
BEGIN
  IF EXISTS(
    SELECT 1 FROM expense_claim E
    LEFT JOIN biz_cst C ON C.BIZ_CST_SN=E.BIZ_CST_SN
    LEFT JOIN biz_info B ON B.BIZ_ID=C.BIZ_ID
    WHERE C.BIZ_CST_SN IS NULL OR C.BIZ_ID<>E.BIZ_ID OR B.CO_ID<>E.CO_ID OR B.CO_ID IS NULL
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='이관 중단: expense_claim에서 일치하는 사업/비용 원장을 찾지 못했습니다.';
  END IF;
  IF EXISTS(SELECT 1 FROM expense_claim GROUP BY BIZ_CST_SN HAVING COUNT(*)>1) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='이관 중단: 동일 biz_cst에 연결된 비용청구가 둘 이상입니다.';
  END IF;
  IF EXISTS(
    SELECT 1 FROM atch_file_info F
    WHERE F.REF_SE_CD='EXPENSE_CLAIM'
      AND NOT EXISTS(SELECT 1 FROM expense_claim E WHERE E.CO_ID=F.CO_ID AND CAST(E.CLAIM_SN AS CHAR)=F.REF_ID)
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='이관 중단: 참조 청구 건이 없는 영수증 파일이 존재합니다.';
  END IF;
END $$
DELIMITER ;
CALL TRS_VERIFY_COST_MIGRATION();
DROP PROCEDURE TRS_VERIFY_COST_MIGRATION;

-- [1] 단일 비용 원장에 비용청구 전용 필드를 통합합니다.
-- 과거 회계원장은 결제수단/카드/사용처가 원래 없었으므로 NULL을 유지합니다.
ALTER TABLE biz_cst
  ADD COLUMN IF NOT EXISTS PMT_MTHD_CD VARCHAR(30) NULL COMMENT '결제수단' AFTER RMRK_CN,
  ADD COLUMN IF NOT EXISTS CARD_LAST4 VARCHAR(4) NULL COMMENT '카드 끝 4자리' AFTER PMT_MTHD_CD,
  ADD COLUMN IF NOT EXISTS MERCHANT_NM VARCHAR(200) NULL COMMENT '사용처' AFTER CARD_LAST4,
  ADD COLUMN IF NOT EXISTS EXPNS_USER_ID VARCHAR(50) NULL COMMENT '비용 실사용자' AFTER MERCHANT_NM,
  ADD COLUMN IF NOT EXISTS LEGACY_CLAIM_SN BIGINT(20) NULL COMMENT '이관 전 비용청구 일련번호' AFTER EXPNS_USER_ID;
ALTER TABLE biz_cst MODIFY COLUMN RMRK_CN VARCHAR(2000) NULL COMMENT '비고내용';

-- [2] 연결된 기존 비용 원장에만 청구 상세정보를 병합합니다. INSERT 하지 않으므로 손익 중복 없음.
START TRANSACTION;
UPDATE biz_cst C
JOIN expense_claim E ON E.BIZ_CST_SN=C.BIZ_CST_SN AND E.BIZ_ID=C.BIZ_ID
SET C.CST_SE_CD=E.EXPNS_SE_CD,
    C.CST_NM=E.EXPNS_NM,
    C.OCRN_CST=E.CLAIM_AMT,
    C.OCRN_YMD=E.USE_YMD,
    C.RMRK_CN=E.RMRK_CN,
    C.PMT_MTHD_CD=E.PMT_MTHD_CD,
    C.CARD_LAST4=E.CARD_LAST4,
    C.MERCHANT_NM=E.MERCHANT_NM,
    C.EXPNS_USER_ID=E.USER_ID,
    C.LEGACY_CLAIM_SN=E.CLAIM_SN,
    C.USE_YN=E.USE_YN;

-- [3] 증빙 파일의 참조는 이전 CLAIM_SN이 아닌 BIZ_CST_SN을 가리킵니다.
UPDATE atch_file_info F
JOIN expense_claim E ON E.CO_ID=F.CO_ID AND F.REF_ID=CAST(E.CLAIM_SN AS CHAR)
SET F.REF_SE_CD='BIZ_COST', F.REF_ID=CAST(E.BIZ_CST_SN AS CHAR)
WHERE F.REF_SE_CD='EXPENSE_CLAIM';
COMMIT;

-- [4] 감사 로그 추적을 위해 기존 번호를 기록하고, 원본 청구 테이블은 백업명으로 보관합니다.
-- 이관 후 서비스의 비용 관련 INSERT/UPDATE/SELECT는 biz_cst만 사용합니다.
RENAME TABLE expense_claim TO expense_claim_backup_20261008;

-- [5] 회계관리의 옛 입력 API는 더 이상 사용하지 않으므로 기능 권한에서도 비활성화합니다.
-- 비용 등록/수정/삭제는 내 업무 > 비용 청구의 권한을 사용합니다.
UPDATE menu_info SET MENU_USE_YN='N'
WHERE MENU_URL_ADDR IN ('/biz/cstSave.ajax', '/biz/cstDelete.ajax');

-- [6] 적용 검증 쿼리: 기존 원장 수, 병합 수, 영수증 참조를 확인합니다.
SELECT COUNT(*) AS ledger_all_count, SUM(USE_YN='Y') AS ledger_active_count,
       SUM(LEGACY_CLAIM_SN IS NOT NULL) AS migrated_claim_count FROM biz_cst;
SELECT COUNT(*) AS backup_claim_count FROM expense_claim_backup_20261008;
SELECT COUNT(*) AS remaining_old_receipt_ref_count FROM atch_file_info WHERE REF_SE_CD='EXPENSE_CLAIM';
SELECT BIZ_CST_SN, LEGACY_CLAIM_SN, BIZ_ID, CST_NM, OCRN_CST, PMT_MTHD_CD, CARD_LAST4, MERCHANT_NM
FROM biz_cst WHERE LEGACY_CLAIM_SN IS NOT NULL ORDER BY LEGACY_CLAIM_SN;
