-- TRS-IBP 2026-10-08: 프로젝트 등록자 메타데이터 보존
-- 운영 DB에 적용하기 전 백업 후 실행하세요. (MariaDB 10.6+)
-- 원본 biz_info에는 등록자 컬럼이 없으므로 신규 등록 건부터 RGTR_ID를 직접 기록합니다.
ALTER TABLE biz_info ADD COLUMN RGTR_ID VARCHAR(50) NULL COMMENT '사업 원등록자 아이디' AFTER BIZ_STTS_CD;
CREATE INDEX IDX_BIZ_INFO_RGTR ON biz_info (CO_ID, RGTR_ID);

-- 정확한 등록 시각과 자동/등록자 투입 기록이 일치하는 유일한 경우에만 과거 등록자 복구.
-- 투입인력의 USE_YN=N 여부와 관계없이 원등록자 기록은 복원합니다.
-- 직접 재작성된 투입인력/비슷한 시각에 여럿 등록된 이력은 자동 처리하지 않습니다.
UPDATE biz_info B
JOIN biz_mnpw M ON M.BIZ_ID=B.BIZ_ID
JOIN user_info U ON U.USER_ID=M.RGTR_ID AND U.CO_ID=B.CO_ID
SET B.RGTR_ID=M.RGTR_ID
WHERE B.RGTR_ID IS NULL
  AND M.RGTR_ID IS NOT NULL
  AND M.REG_DT=B.REG_DT
  AND (M.ROLE_NM='사업 등록자' OR M.RMRK_CN='사업 등록 시 자동 추가')
  AND NOT EXISTS (
    SELECT 1 FROM biz_mnpw M2
     WHERE M2.BIZ_ID=B.BIZ_ID
       AND M2.RGTR_ID IS NOT NULL
       AND M2.REG_DT=B.REG_DT
       AND (M2.ROLE_NM='사업 등록자' OR M2.RMRK_CN='사업 등록 시 자동 추가')
       AND M2.RGTR_ID <> M.RGTR_ID
  );

-- 미복원 행은 임의로 등록자를 지정하지 않고 점검 대상으로만 출력합니다.
SELECT B.BIZ_ID,B.BIZ_CD,B.BIZ_NM,B.REG_DT,B.RGTR_ID
FROM biz_info B WHERE B.RGTR_ID IS NULL ORDER BY B.REG_DT;
-- expense_claim 및 biz_cst 데이터 변경 없음 (중복 청구/손익 방지)
