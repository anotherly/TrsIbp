-- TRS-IBP 2026-10-08 / 프로젝트 조회 범위는 기존 co_authrt_info.DATA_SCOPE_CD 사용
-- 사전 조건: 20261008_project_creator_access.sql 적용, biz_info.RGTR_ID 존재
-- COMPANY=소속 회사 전체, SELF=본인 등록 또는 활성 투입 프로젝트
-- 사용자 요청에 따라 COMP001의 PROJECT_PM 초기 범위를 전체 프로젝트로 변경.
-- 다른 회사와 다른 역할은 변경하지 않음. 권한관리 화면에서 이후 변경 가능.
UPDATE co_authrt_info
   SET DATA_SCOPE_CD = 'COMPANY', MDFCN_DT = NOW(), MDFR_ID = 'SYSTEM'
 WHERE CO_ID = 'COMP001' AND AUTHRT_ID = 'PROJECT_PM' AND USE_YN = 'Y';
-- 검증
SELECT CO_ID, AUTHRT_ID, AUTHRT_NM, DATA_SCOPE_CD
  FROM co_authrt_info
 WHERE CO_ID = 'COMP001'
 ORDER BY SORT_SEQ, AUTHRT_ID;
