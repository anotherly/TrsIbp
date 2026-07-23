-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.6.4-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- trs_ibp 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `trs_ibp` /*!40100 DEFAULT CHARACTER SET utf8mb3 */;
USE `trs_ibp`;

-- 테이블 trs_ibp.atch_file_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `atch_file_info` (
  `ATCH_FILE_SN` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '첨부파일일련번호',
  `CO_ID` varchar(20) NOT NULL COMMENT '회사ID',
  `REF_SE_CD` varchar(30) NOT NULL COMMENT '참조구분코드',
  `REF_ID` varchar(100) NOT NULL COMMENT '참조ID',
  `FILE_SE_CD` varchar(30) NOT NULL COMMENT '파일구분코드',
  `ORGNL_FILE_NM` varchar(255) NOT NULL COMMENT '원본파일명',
  `ENCPT_FILE_NM` varchar(255) NOT NULL COMMENT '암호화파일명',
  `FILE_PATH_NM` varchar(500) NOT NULL COMMENT '파일경로명',
  `FILE_SZ` bigint(20) NOT NULL COMMENT '파일크기',
  `FILE_EXTN_NM` varchar(20) NOT NULL COMMENT '파일확장자명',
  `SORT_SEQ` int(11) NOT NULL DEFAULT 0 COMMENT '첨부파일순서',
  `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `RGTR_ID` varchar(50) DEFAULT NULL COMMENT '등록자아이디',
  `REG_DT` datetime NOT NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`ATCH_FILE_SN`),
  KEY `IDX_ATCH_FILE_REF` (`CO_ID`,`REF_SE_CD`,`REF_ID`,`FILE_SE_CD`,`USE_YN`),
  CONSTRAINT `FK_ATCH_FILE_CO` FOREIGN KEY (`CO_ID`) REFERENCES `co_info` (`CO_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='첨부파일정보';

-- 테이블 데이터 trs_ibp.atch_file_info:~6 rows (대략적) 내보내기
DELETE FROM `atch_file_info`;
/*!40000 ALTER TABLE `atch_file_info` DISABLE KEYS */;
INSERT INTO `atch_file_info` (`ATCH_FILE_SN`, `CO_ID`, `REF_SE_CD`, `REF_ID`, `FILE_SE_CD`, `ORGNL_FILE_NM`, `ENCPT_FILE_NM`, `FILE_PATH_NM`, `FILE_SZ`, `FILE_EXTN_NM`, `SORT_SEQ`, `USE_YN`, `RGTR_ID`, `REG_DT`, `MDFCN_DT`) VALUES
	(1, 'COMP001', 'USER', 'user12345', 'PROFILE', 'guderian.png', '691a38e4-f86f-42ce-9d19-b84337115864.png', 'user/profile/2026/07/21', 19612, 'png', 1, 'N', 'user12345', '2026-07-21 15:34:17', '2026-07-21 15:35:12'),
	(2, 'COMP001', 'USER', 'user12345', 'PROFILE', 'guderian.png', 'c07767ae-9ed9-4703-95e4-ba90bebe05d2.png', 'user/profile/2026/07/21', 19612, 'png', 1, 'Y', 'user12345', '2026-07-21 15:35:12', NULL),
	(3, 'COMP001', 'USER', 'user12345', 'DOCUMENT', 'HOI4_사령관_제독_특성_아이콘포함.xlsx', '3a963967-6164-4ae0-b627-061aa44c1989.xlsx', 'user/document/2026/07/21', 34099, 'xlsx', 1, 'Y', 'user12345', '2026-07-21 15:35:12', NULL),
	(4, 'COMP001', 'USER', 'user12345', 'DOCUMENT', 'HOI4_사령관_특성_아이콘포함_재작성.xlsx', 'cfc50b90-bf21-4c81-b555-f11e62625e56.xlsx', 'user/document/2026/07/21', 23280, 'xlsx', 2, 'Y', 'user12345', '2026-07-21 15:35:12', NULL),
	(5, 'COMP001', 'USER', 'user12345', 'DOCUMENT', '직장인 업무특성 스킬구성도.pptx', 'ce6ef9cf-84b9-4d46-83dc-b4c5133d49c4.pptx', 'user/document/2026/07/21', 5668927, 'pptx', 3, 'Y', 'user12345', '2026-07-21 15:35:12', NULL),
	(6, 'COMP001', 'USER', 'user12345', 'DOCUMENT', '현대_IT업계_직장인_특성체계.xlsx', '70afe6fb-98c4-4876-9e8c-259c5bfe0727.xlsx', 'user/document/2026/07/21', 32882, 'xlsx', 4, 'Y', 'user12345', '2026-07-21 15:35:12', NULL);
/*!40000 ALTER TABLE `atch_file_info` ENABLE KEYS */;

-- 테이블 trs_ibp.authrt_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `authrt_info` (
  `AUTHRT_ID` varchar(20) NOT NULL COMMENT '권한ID',
  `AUTHRT_NM` varchar(50) NOT NULL COMMENT '권한명',
  `AUTHRT_EXPLN` varchar(200) DEFAULT NULL COMMENT '권한설명',
  `SORT_SEQ` int(11) DEFAULT 0 COMMENT '정렬순서',
  PRIMARY KEY (`AUTHRT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='권한정보';

-- 테이블 데이터 trs_ibp.authrt_info:~3 rows (대략적) 내보내기
DELETE FROM `authrt_info`;
/*!40000 ALTER TABLE `authrt_info` DISABLE KEYS */;
INSERT INTO `authrt_info` (`AUTHRT_ID`, `AUTHRT_NM`, `AUTHRT_EXPLN`, `SORT_SEQ`) VALUES
	('ADMIN', '최고관리자', '프로젝트 개발자. 전체 시스템 최고 권한', 1),
	('MANAGER', '관리자', '경영/회계팀, 팀장/본부장/대표. 팀원 관리 권한', 2),
	('USER', '사용자', '일반 회사원. 본인 일정/연차 조회 및 출근 기록', 3);
/*!40000 ALTER TABLE `authrt_info` ENABLE KEYS */;

-- 테이블 trs_ibp.biz_cst 구조 내보내기
CREATE TABLE IF NOT EXISTS `biz_cst` (
  `BIZ_CST_SN` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '사업비용일련번호',
  `BIZ_ID` varchar(20) NOT NULL COMMENT '사업ID',
  `CST_SE_CD` varchar(30) NOT NULL COMMENT '비용구분코드',
  `CST_NM` varchar(200) NOT NULL COMMENT '비용명',
  `OCRN_CST` decimal(15,0) DEFAULT 0 COMMENT '발생비용',
  `OCRN_YMD` date DEFAULT NULL COMMENT '발생일자',
  `RMRK_CN` varchar(1000) DEFAULT NULL COMMENT '비고내용',
  `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `RGTR_ID` varchar(50) DEFAULT NULL COMMENT '등록자아이디',
  `MDFR_ID` varchar(50) DEFAULT NULL COMMENT '수정자아이디',
  PRIMARY KEY (`BIZ_CST_SN`),
  KEY `IDX_BIZ_CST_BIZ` (`BIZ_ID`),
  CONSTRAINT `FK_BIZ_CST_BIZ` FOREIGN KEY (`BIZ_ID`) REFERENCES `biz_info` (`BIZ_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='사업비용';

-- 테이블 데이터 trs_ibp.biz_cst:~2 rows (대략적) 내보내기
DELETE FROM `biz_cst`;
/*!40000 ALTER TABLE `biz_cst` DISABLE KEYS */;
INSERT INTO `biz_cst` (`BIZ_CST_SN`, `BIZ_ID`, `CST_SE_CD`, `CST_NM`, `OCRN_CST`, `OCRN_YMD`, `RMRK_CN`, `USE_YN`, `REG_DT`, `MDFCN_DT`, `RGTR_ID`, `MDFR_ID`) VALUES
	(1, 'B20260630133620G5XM3', 'TRVL', '출장 석식', 10000, '2026-07-06', NULL, 'Y', '2026-07-09 16:51:06', NULL, 'user12345', NULL),
	(2, 'B20260630133620G5XM3', 'TRVL', '출장 석식', 12000, '2026-07-03', NULL, 'Y', '2026-07-09 16:51:22', NULL, 'user12345', NULL);
/*!40000 ALTER TABLE `biz_cst` ENABLE KEYS */;

-- 테이블 trs_ibp.biz_cust_rel 구조 내보내기
CREATE TABLE IF NOT EXISTS `biz_cust_rel` (
  `BIZ_CUST_REL_SN` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '사업고객관계일련번호',
  `BIZ_ID` varchar(20) NOT NULL COMMENT '사업ID',
  `CUST_SN` bigint(20) NOT NULL COMMENT '고객일련번호',
  `REL_SE_CD` varchar(30) NOT NULL COMMENT '관계구분코드',
  `REL_LVL` int(11) NOT NULL DEFAULT 0 COMMENT '관계단계',
  `DIRECT_CTRT_YN` char(1) NOT NULL DEFAULT 'N' COMMENT '직접계약여부',
  `RMRK_CN` varchar(1000) DEFAULT NULL COMMENT '비고내용',
  `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `RGTR_ID` varchar(50) DEFAULT NULL,
  `MDFR_ID` varchar(50) DEFAULT NULL COMMENT '수정자아이디',
  PRIMARY KEY (`BIZ_CUST_REL_SN`),
  KEY `IDX_BIZ_CUST_REL_BIZ` (`BIZ_ID`),
  KEY `IDX_BIZ_CUST_REL_CUST` (`CUST_SN`),
  CONSTRAINT `FK_BIZ_CUST_REL_BIZ` FOREIGN KEY (`BIZ_ID`) REFERENCES `biz_info` (`BIZ_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_BIZ_CUST_REL_CUST` FOREIGN KEY (`CUST_SN`) REFERENCES `cust_info` (`CUST_SN`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='사업고객관계';

-- 테이블 데이터 trs_ibp.biz_cust_rel:~11 rows (대략적) 내보내기
DELETE FROM `biz_cust_rel`;
/*!40000 ALTER TABLE `biz_cust_rel` DISABLE KEYS */;
INSERT INTO `biz_cust_rel` (`BIZ_CUST_REL_SN`, `BIZ_ID`, `CUST_SN`, `REL_SE_CD`, `REL_LVL`, `DIRECT_CTRT_YN`, `RMRK_CN`, `USE_YN`, `REG_DT`, `MDFCN_DT`, `RGTR_ID`, `MDFR_ID`) VALUES
	(1, 'B20260630133620G5XM3', 2, 'END_USER', 1, 'N', NULL, 'Y', '2026-06-30 13:48:50', '2026-07-09 18:50:04', 'user12345', 'user12345'),
	(2, 'B20260630133620G5XM3', 3, 'PRIME_CTRTR', 2, 'Y', NULL, 'Y', '2026-06-30 13:50:51', '2026-07-09 18:50:15', 'user12345', 'user12345'),
	(3, 'B20260630133620G5XM3', 4, 'SUB_CTRTR', 3, 'N', NULL, 'Y', '2026-06-30 13:51:19', '2026-07-09 18:50:26', 'user12345', 'user12345'),
	(4, 'B2026070916475653M8T', 5, 'END_USER', 1, 'N', NULL, 'Y', '2026-07-09 16:52:20', NULL, 'wiz123', NULL),
	(5, 'B2026070916475653M8T', 6, 'PRIME_CTRTR', 2, 'Y', NULL, 'Y', '2026-07-09 16:52:52', '2026-07-09 18:37:08', 'wiz123', 'wiz123'),
	(6, 'B2026070916475653M8T', 7, 'SUB_CTRTR', 3, 'N', NULL, 'Y', '2026-07-09 16:53:22', NULL, 'wiz123', NULL),
	(7, 'B2026070916475653M8T', 8, 'SUB_CTRTR', 4, 'N', NULL, 'N', '2026-07-09 16:54:11', '2026-07-20 16:01:30', 'wiz123', 'wiz123'),
	(8, 'B20260709170545KI7CG', 9, 'END_USER', 1, 'N', NULL, 'Y', '2026-07-09 17:07:00', NULL, 'wiz123', NULL),
	(9, 'B20260709170545KI7CG', 10, 'PRIME_CTRTR', 2, 'Y', NULL, 'Y', '2026-07-09 17:07:20', NULL, 'wiz123', NULL),
	(10, 'B20260709170545KI7CG', 11, 'SUB_CTRTR', 3, 'N', NULL, 'Y', '2026-07-09 17:07:42', NULL, 'wiz123', NULL),
	(11, 'B20260630133620G5XM3', 12, 'SUB_CTRTR', 3, 'N', NULL, 'Y', '2026-07-09 18:50:49', '2026-07-09 18:51:48', 'user12345', 'user12345');
/*!40000 ALTER TABLE `biz_cust_rel` ENABLE KEYS */;

-- 테이블 trs_ibp.biz_give_mthd 구조 내보내기
CREATE TABLE IF NOT EXISTS `biz_give_mthd` (
  `BIZ_GIVE_MTHD_SN` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '사업지급방법일련번호',
  `BIZ_ID` varchar(20) NOT NULL COMMENT '사업ID',
  `GIVE_MTHD_CD` varchar(30) DEFAULT NULL COMMENT '지급방법코드',
  `GIVE_MTHD_CN` varchar(1000) DEFAULT NULL COMMENT '지급방법상세내용',
  `SORT_SEQ` int(11) DEFAULT 0 COMMENT '정렬순서',
  `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `RGTR_ID` varchar(50) DEFAULT NULL COMMENT '등록자아이디',
  `MDFR_ID` varchar(50) DEFAULT NULL COMMENT '수정자아이디',
  PRIMARY KEY (`BIZ_GIVE_MTHD_SN`),
  KEY `IDX_BIZ_GIVE_MTHD_BIZ` (`BIZ_ID`,`SORT_SEQ`),
  CONSTRAINT `FK_BIZ_GIVE_MTHD_BIZ` FOREIGN KEY (`BIZ_ID`) REFERENCES `biz_info` (`BIZ_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='사업지급방법';

-- 테이블 데이터 trs_ibp.biz_give_mthd:~8 rows (대략적) 내보내기
DELETE FROM `biz_give_mthd`;
/*!40000 ALTER TABLE `biz_give_mthd` DISABLE KEYS */;
INSERT INTO `biz_give_mthd` (`BIZ_GIVE_MTHD_SN`, `BIZ_ID`, `GIVE_MTHD_CD`, `GIVE_MTHD_CN`, `SORT_SEQ`, `USE_YN`, `REG_DT`, `MDFCN_DT`, `RGTR_ID`, `MDFR_ID`) VALUES
	(1, 'B20260630133620G5XM3', 'ETC', '월 단위 500~800만원', 1, 'N', '2026-07-13 16:25:16', '2026-07-14 11:38:05', NULL, 'user12345'),
	(2, 'B2026070916475653M8T', 'ADVANCE', '', 1, 'Y', '2026-07-13 16:25:16', NULL, NULL, NULL),
	(3, 'B20260709170545KI7CG', 'BALANCE', '케이원 2900 위즈브레인 5200 예상', 1, 'Y', '2026-07-13 16:25:16', NULL, NULL, NULL),
	(4, 'B20260709180250W5ILR', 'ETC', '매월 지급 ', 1, 'Y', '2026-07-13 16:25:16', NULL, NULL, NULL),
	(8, 'B20260630133620G5XM3', 'ADVANCE', '10%', 1, 'Y', '2026-07-14 11:38:05', NULL, 'user12345', NULL),
	(9, 'B20260630133620G5XM3', 'INTERIM', '40%', 2, 'Y', '2026-07-14 11:38:05', NULL, 'user12345', NULL),
	(10, 'B20260630133620G5XM3', 'INTERIM', '40%', 3, 'Y', '2026-07-14 11:38:05', NULL, 'user12345', NULL),
	(11, 'B20260630133620G5XM3', 'BALANCE', '10%', 4, 'Y', '2026-07-14 11:38:05', NULL, 'user12345', NULL);
/*!40000 ALTER TABLE `biz_give_mthd` ENABLE KEYS */;

-- 테이블 trs_ibp.biz_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `biz_info` (
  `BIZ_ID` varchar(20) NOT NULL COMMENT '사업ID',
  `CO_ID` varchar(20) NOT NULL COMMENT '회사ID',
  `BIZ_CD` varchar(30) NOT NULL COMMENT '사업코드',
  `CTRT_NO` varchar(50) DEFAULT NULL COMMENT '계약번호',
  `BIZ_NM` varchar(100) NOT NULL COMMENT '사업명',
  `BIZ_ABRV_NM` varchar(100) DEFAULT NULL COMMENT '사업약칭명',
  `INST_SE_CD` varchar(10) DEFAULT NULL COMMENT '기관구분코드',
  `BIZ_KND_CD` varchar(10) DEFAULT NULL COMMENT '사업종류코드',
  `BIZ_SE_CD` varchar(20) DEFAULT NULL COMMENT '사업구분코드',
  `ORDPL_NM` varchar(100) DEFAULT NULL COMMENT '발주처명',
  `CTRT_YMD` date DEFAULT NULL COMMENT '계약일자',
  `OTST_YMD` date DEFAULT NULL COMMENT '착수일자',
  `BIZ_BGNG_YMD` date DEFAULT NULL COMMENT '사업시작일자',
  `BIZ_END_YMD` date DEFAULT NULL COMMENT '사업종료일자',
  `CTRT_AMT` decimal(15,0) DEFAULT NULL COMMENT '계약금액',
  `VAT_INCL_YN` char(1) DEFAULT NULL COMMENT '부가가치세포함여부',
  `GIVE_MTHD_CD` varchar(30) DEFAULT NULL COMMENT '지급방법코드',
  `GIVE_MTHD_CN` varchar(1000) DEFAULT NULL COMMENT '지급방법상세내용',
  `GIVE_DDT_YMD` date DEFAULT NULL COMMENT '지급기일일자',
  `DFRP_GRNTE_BGNG_YMD` date DEFAULT NULL COMMENT '하자보수보증시작일자',
  `DFRP_GRNTE_END_YMD` date DEFAULT NULL COMMENT '하자보수보증종료일자',
  `RMRK_CN` varchar(4000) DEFAULT NULL COMMENT '비고내용',
  `BIZ_STTS_CD` varchar(10) DEFAULT 'READY' COMMENT '사업상태코드',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  PRIMARY KEY (`BIZ_ID`),
  UNIQUE KEY `UK_BIZ_INFO_CO_BIZ_CD` (`CO_ID`,`BIZ_CD`),
  KEY `IDX_BIZ_CO_ID` (`CO_ID`),
  KEY `IDX_BIZ_INFO_ORDPL_NM` (`ORDPL_NM`),
  KEY `IDX_BIZ_INFO_OTST_END` (`OTST_YMD`,`BIZ_END_YMD`),
  CONSTRAINT `FK_BIZ_CO` FOREIGN KEY (`CO_ID`) REFERENCES `co_info` (`CO_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='사업정보';

-- 테이블 데이터 trs_ibp.biz_info:~4 rows (대략적) 내보내기
DELETE FROM `biz_info`;
/*!40000 ALTER TABLE `biz_info` DISABLE KEYS */;
INSERT INTO `biz_info` (`BIZ_ID`, `CO_ID`, `BIZ_CD`, `CTRT_NO`, `BIZ_NM`, `BIZ_ABRV_NM`, `INST_SE_CD`, `BIZ_KND_CD`, `BIZ_SE_CD`, `ORDPL_NM`, `CTRT_YMD`, `OTST_YMD`, `BIZ_BGNG_YMD`, `BIZ_END_YMD`, `CTRT_AMT`, `VAT_INCL_YN`, `GIVE_MTHD_CD`, `GIVE_MTHD_CN`, `GIVE_DDT_YMD`, `DFRP_GRNTE_BGNG_YMD`, `DFRP_GRNTE_END_YMD`, `RMRK_CN`, `BIZ_STTS_CD`, `REG_DT`) VALUES
	('B20260630133620G5XM3', 'COMP001', 'TRS-26-0001', NULL, '26년 데이터공유센터 전산시스템 유지관리 용역', NULL, 'PBL', 'SM', 'MNTC', '한국교통안전공단 자동차안전연구원', '2026-06-10', '2026-06-11', '2026-06-11', '2026-12-31', 60472220, NULL, 'ADVANCE', '10%', NULL, NULL, NULL, '06/10 사업계약\n06/11 사업착수\n06월 유지보수 완료\n07/01 ~ 07/10 집중업무 지원 완료\n07/13 세금계산서 발행\n', 'PRGRS', '2026-06-30 13:36:21'),
	('B2026070916475653M8T', 'COMP002', 'WIZB-21-0001', '322130637-00', 'TBN한국교통방송 제보접수시스템 고도화 사업', 'tbn', 'PBL', 'SI', 'ENHNC', '', '2021-09-10', '2021-09-13', '2021-09-13', '2021-12-31', 164000000, NULL, 'ADVANCE', '', NULL, '2022-01-03', '2022-12-30', '', 'CMPTN', '2026-07-09 16:47:56'),
	('B20260709170545KI7CG', 'COMP002', 'WIZB-26-0001', NULL, '공항철도 혼잡도', '공철', 'PBL', 'SI', 'NEW_DVLP', '공항철도', '2020-09-01', '2020-09-10', '2020-09-10', '2020-12-31', 81000000, NULL, 'BALANCE', '케이원 2900 위즈브레인 5200 예상', NULL, NULL, NULL, '', 'CMPTN', '2026-07-09 17:05:45'),
	('B20260709180250W5ILR', 'COMP001', 'TRS-26-0002', NULL, 'TBN BIS', 'BIS', 'PBL', 'SI', 'NEW_DVLP', '도로교통공단', '2026-07-27', '2026-07-29', '2026-07-29', '2026-08-28', 29000000, NULL, 'ETC', '매월 지급 ', NULL, '2026-09-01', '2027-09-01', '', 'PRGRS', '2026-07-09 18:02:50');
/*!40000 ALTER TABLE `biz_info` ENABLE KEYS */;

-- 테이블 trs_ibp.biz_mnpw 구조 내보내기
CREATE TABLE IF NOT EXISTS `biz_mnpw` (
  `BIZ_MNPW_SN` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '사업투입인력일련번호',
  `BIZ_ID` varchar(20) NOT NULL COMMENT '사업ID',
  `USER_ID` varchar(50) DEFAULT NULL COMMENT '사용자아이디',
  `INPUT_MNPW_NM` varchar(100) NOT NULL COMMENT '투입인력명',
  `INPUT_SE_CD` varchar(30) DEFAULT NULL COMMENT '투입구분코드',
  `ROLE_NM` varchar(100) DEFAULT NULL COMMENT '역할명',
  `JBPS_NM` varchar(100) DEFAULT NULL COMMENT '직위명',
  `INPUT_BGNG_YMD` date DEFAULT NULL COMMENT '투입시작일자',
  `INPUT_END_YMD` date DEFAULT NULL COMMENT '투입종료일자',
  `INPUT_MCNT` decimal(8,2) DEFAULT 0.00 COMMENT '투입개월수',
  `UNTPRC` decimal(15,0) DEFAULT 0 COMMENT '단가',
  `INPUT_RT` decimal(5,2) DEFAULT 100.00 COMMENT '투입률',
  `RMRK_CN` varchar(1000) DEFAULT NULL COMMENT '비고내용',
  `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `RGTR_ID` varchar(50) DEFAULT NULL,
  `MDFR_ID` varchar(50) DEFAULT NULL COMMENT '수정자아이디',
  PRIMARY KEY (`BIZ_MNPW_SN`),
  KEY `IDX_BIZ_MNPW_BIZ` (`BIZ_ID`),
  KEY `IDX_BIZ_MNPW_USER` (`USER_ID`),
  CONSTRAINT `FK_BIZ_MNPW_BIZ` FOREIGN KEY (`BIZ_ID`) REFERENCES `biz_info` (`BIZ_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_BIZ_MNPW_USER` FOREIGN KEY (`USER_ID`) REFERENCES `user_info` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='사업투입인력';

-- 테이블 데이터 trs_ibp.biz_mnpw:~4 rows (대략적) 내보내기
DELETE FROM `biz_mnpw`;
/*!40000 ALTER TABLE `biz_mnpw` DISABLE KEYS */;
INSERT INTO `biz_mnpw` (`BIZ_MNPW_SN`, `BIZ_ID`, `USER_ID`, `INPUT_MNPW_NM`, `INPUT_SE_CD`, `ROLE_NM`, `JBPS_NM`, `INPUT_BGNG_YMD`, `INPUT_END_YMD`, `INPUT_MCNT`, `UNTPRC`, `INPUT_RT`, `RMRK_CN`, `USE_YN`, `REG_DT`, `MDFCN_DT`, `RGTR_ID`, `MDFR_ID`) VALUES
	(1, 'B20260630133620G5XM3', 'user12345', '정다빈', 'MAIN', 'web개발', '과장', '2026-06-11', '2026-12-31', 2.72, 7000000, 40.00, NULL, 'Y', '2026-06-30 13:56:13', '2026-07-20 18:59:49', 'user12345', 'user12345'),
	(2, 'B20260630133620G5XM3', 'user12345', '서동민', 'SUB', '인프라', '차장', '2026-05-01', '2026-12-31', 0.82, 8000000, 10.00, NULL, 'Y', '2026-06-30 13:57:08', '2026-07-20 18:59:44', 'user12345', 'user12345'),
	(3, 'B2026070916475653M8T', NULL, '정다빈', 'MAIN', 'WEB개발', '대리', '2021-09-01', '2021-12-31', 4.07, 4000000, 100.00, NULL, 'Y', '2026-07-09 17:09:19', NULL, 'wiz123', NULL),
	(4, 'B2026070916475653M8T', NULL, '남상갑', 'CNTR', '교환기', '대표', NULL, NULL, NULL, 10000000, 100.00, NULL, 'Y', '2026-07-09 17:52:32', NULL, 'wiz123', NULL);
/*!40000 ALTER TABLE `biz_mnpw` ENABLE KEYS */;

-- 테이블 trs_ibp.biz_schdl 구조 내보내기
CREATE TABLE IF NOT EXISTS `biz_schdl` (
  `BIZ_SCHDL_SN` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '사업일정일련번호',
  `BIZ_ID` varchar(20) NOT NULL COMMENT '사업ID',
  `SCHDL_NM` varchar(200) NOT NULL COMMENT '일정명',
  `SCHDL_CN` varchar(1000) DEFAULT NULL COMMENT '일정내용',
  `SCHDL_SE_CD` varchar(30) DEFAULT NULL COMMENT '일정구분코드',
  `SCHDL_BGNG_YMD` date DEFAULT NULL COMMENT '일정시작일자',
  `SCHDL_END_YMD` date DEFAULT NULL COMMENT '일정종료일자',
  `PIC_ID` varchar(50) DEFAULT NULL COMMENT '담당자아이디',
  `RMRK_CN` varchar(1000) DEFAULT NULL COMMENT '비고내용',
  `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `RGTR_ID` varchar(50) DEFAULT NULL,
  `MDFR_ID` varchar(50) DEFAULT NULL COMMENT '수정자아이디',
  PRIMARY KEY (`BIZ_SCHDL_SN`),
  KEY `IDX_BIZ_SCHDL_BIZ` (`BIZ_ID`,`SCHDL_BGNG_YMD`),
  KEY `IDX_BIZ_SCHDL_PIC` (`PIC_ID`),
  CONSTRAINT `FK_BIZ_SCHDL_BIZ` FOREIGN KEY (`BIZ_ID`) REFERENCES `biz_info` (`BIZ_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_BIZ_SCHDL_PIC` FOREIGN KEY (`PIC_ID`) REFERENCES `user_info` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='사업일정';

-- 테이블 데이터 trs_ibp.biz_schdl:~0 rows (대략적) 내보내기
DELETE FROM `biz_schdl`;
/*!40000 ALTER TABLE `biz_schdl` DISABLE KEYS */;
INSERT INTO `biz_schdl` (`BIZ_SCHDL_SN`, `BIZ_ID`, `SCHDL_NM`, `SCHDL_CN`, `SCHDL_SE_CD`, `SCHDL_BGNG_YMD`, `SCHDL_END_YMD`, `PIC_ID`, `RMRK_CN`, `USE_YN`, `REG_DT`, `MDFCN_DT`, `RGTR_ID`, `MDFR_ID`) VALUES
	(1, 'B20260630133620G5XM3', 'asdfsdaf', '작업내용 후술 바람', 'FREE_MAINT', '2026-06-05', '2026-09-09', 'admin1', NULL, 'Y', '2026-06-30 14:00:39', NULL, 'user12345', NULL);
/*!40000 ALTER TABLE `biz_schdl` ENABLE KEYS */;

-- 테이블 trs_ibp.biz_stp_task 구조 내보내기
CREATE TABLE IF NOT EXISTS `biz_stp_task` (
  `TASK_SN` int(11) NOT NULL AUTO_INCREMENT COMMENT '업무일련번호',
  `BIZ_ID` varchar(20) NOT NULL COMMENT '사업ID',
  `STP_CD` varchar(10) NOT NULL COMMENT '단계코드',
  `TASK_NM` varchar(200) NOT NULL COMMENT '업무명',
  `PIC_ID` varchar(50) DEFAULT NULL COMMENT '담당자ID',
  `OUTPUT_FILE_NM` varchar(255) DEFAULT NULL COMMENT '산출물파일명',
  `OUTPUT_FILE_PATH_NM` varchar(500) DEFAULT NULL COMMENT '산출물파일경로명',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  PRIMARY KEY (`TASK_SN`),
  KEY `IDX_BIZ_STEP_TASK_BIZ_ID` (`BIZ_ID`),
  KEY `IDX_BIZ_STEP_TASK_PIC_ID` (`PIC_ID`),
  CONSTRAINT `FK_BIZ_STEP_TASK_BIZ` FOREIGN KEY (`BIZ_ID`) REFERENCES `biz_info` (`BIZ_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_BIZ_STEP_TASK_PIC` FOREIGN KEY (`PIC_ID`) REFERENCES `user_info` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='사업단계업무';

-- 테이블 데이터 trs_ibp.biz_stp_task:~0 rows (대략적) 내보내기
DELETE FROM `biz_stp_task`;
/*!40000 ALTER TABLE `biz_stp_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `biz_stp_task` ENABLE KEYS */;

-- 테이블 trs_ibp.cmn_cd 구조 내보내기
CREATE TABLE IF NOT EXISTS `cmn_cd` (
  `CD_GROUP_ID` varchar(50) NOT NULL COMMENT '코드그룹ID',
  `CD` varchar(30) NOT NULL COMMENT '코드',
  `CD_NM` varchar(100) NOT NULL COMMENT '코드명',
  `CD_EXPLN` varchar(500) DEFAULT NULL COMMENT '코드설명',
  `SORT_SEQ` int(11) DEFAULT 0 COMMENT '정렬순서',
  `DFLT_YN` char(1) NOT NULL DEFAULT 'N' COMMENT '기본여부',
  `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `RMRK_CN` varchar(500) DEFAULT NULL COMMENT '비고내용',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  PRIMARY KEY (`CD_GROUP_ID`,`CD`),
  KEY `IDX_CMN_CD_GROUP_SORT` (`CD_GROUP_ID`,`SORT_SEQ`),
  CONSTRAINT `FK_CMN_CD_GROUP` FOREIGN KEY (`CD_GROUP_ID`) REFERENCES `cmn_cd_group` (`CD_GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='공통코드';

-- 테이블 데이터 trs_ibp.cmn_cd:~60 rows (대략적) 내보내기
DELETE FROM `cmn_cd`;
/*!40000 ALTER TABLE `cmn_cd` DISABLE KEYS */;
INSERT INTO `cmn_cd` (`CD_GROUP_ID`, `CD`, `CD_NM`, `CD_EXPLN`, `SORT_SEQ`, `DFLT_YN`, `USE_YN`, `RMRK_CN`, `REG_DT`) VALUES
	('BIZ_KND_CD', 'ETC', '기타', '기타 사업 종류', 90, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('BIZ_KND_CD', 'RND', '연구개발', '연구개발 사업', 30, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('BIZ_KND_CD', 'SI', 'SI', '시스템 구축 사업', 10, 'Y', 'Y', NULL, '2026-06-30 10:03:28'),
	('BIZ_KND_CD', 'SM', 'SM', '운영 및 유지관리 사업', 20, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('BIZ_SE_CD', 'ENHNC', '고도화', '고도화 사업', 30, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('BIZ_SE_CD', 'ETC', '기타', '기타 사업 구분', 90, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('BIZ_SE_CD', 'IMPRV', '기능개선', '기능개선 사업', 40, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('BIZ_SE_CD', 'MNTC', '유지보수', '유지보수 사업', 20, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('BIZ_SE_CD', 'NEW_DVLP', '최초개발', '신규 개발 사업', 10, 'Y', 'Y', NULL, '2026-06-30 10:03:28'),
	('BIZ_STTS_CD', 'CANCEL', '취소', '사업 취소 상태', 50, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('BIZ_STTS_CD', 'CMPTN', '완료', '사업 완료 상태', 30, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('BIZ_STTS_CD', 'HOLD', '보류', '사업 보류 상태', 40, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('BIZ_STTS_CD', 'PRGRS', '진행', '사업 진행 중 상태', 20, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('BIZ_STTS_CD', 'READY', '준비', '사업 착수 전 준비 상태', 10, 'Y', 'Y', NULL, '2026-06-30 10:03:28'),
	('CAL_SCHDL_SE_CD', 'BIZTRIP', '출장', '출장 일정', 20, 'N', 'Y', NULL, '2026-07-14 17:04:12'),
	('CAL_SCHDL_SE_CD', 'BTRP', '출장', '출장 일정', 20, 'N', 'N', NULL, '2026-07-14 16:44:07'),
	('CAL_SCHDL_SE_CD', 'CLIENT', '상주', '고객사 상주근무 일정', 45, 'N', 'Y', NULL, '2026-07-21 15:25:23'),
	('CAL_SCHDL_SE_CD', 'ETC', '기타', '기타 일정', 90, 'N', 'Y', NULL, '2026-07-14 16:44:07'),
	('CAL_SCHDL_SE_CD', 'HOME', '재택', '재택근무 일정', 40, 'N', 'Y', NULL, '2026-07-14 17:04:12'),
	('CAL_SCHDL_SE_CD', 'MEET', '회의', '회의 및 미팅 일정', 50, 'N', 'N', NULL, '2026-07-14 16:44:07'),
	('CAL_SCHDL_SE_CD', 'MEETING', '회의', '회의 일정', 50, 'N', 'Y', NULL, '2026-07-14 17:04:12'),
	('CAL_SCHDL_SE_CD', 'OUTSIDE', '외근', '외근 일정', 30, 'N', 'Y', NULL, '2026-07-14 16:44:07'),
	('CAL_SCHDL_SE_CD', 'PROJECT', '프로젝트', '프로젝트 및 마일스톤 일정', 60, 'N', 'Y', NULL, '2026-07-14 16:44:07'),
	('CAL_SCHDL_SE_CD', 'REMOTE', '재택', '재택근무 일정', 40, 'N', 'N', NULL, '2026-07-14 16:44:07'),
	('CAL_SCHDL_SE_CD', 'VAC', '휴가', '연차, 반차 등 휴가 일정', 10, 'Y', 'Y', NULL, '2026-07-14 16:44:07'),
	('CST_SE_CD', 'ETC', '기타', '기타 직접비', 90, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('CST_SE_CD', 'LODG', '숙박비', '출장/현장 숙박비', 20, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('CST_SE_CD', 'MEAL', '식대', '식대', 30, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('CST_SE_CD', 'MEET', '회의비', '회의비', 40, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('CST_SE_CD', 'MTRL', '재료비', '장비/재료 구매비', 50, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('CST_SE_CD', 'TRVL', '출장비', '출장 교통/일비 등', 10, 'Y', 'Y', NULL, '2026-06-30 11:27:30'),
	('CUST_SE_CD', 'PBL', '공공', '공공기관/공공 발주처', 10, 'Y', 'Y', NULL, '2026-06-30 11:27:30'),
	('CUST_SE_CD', 'PRIVT', '민간', '민간기업/민간 발주처', 20, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('GIVE_MTHD_CD', 'ADVANCE', '선금', '계약 선금 지급', 10, 'Y', 'Y', NULL, '2026-07-08 14:27:58'),
	('GIVE_MTHD_CD', 'BALANCE', '잔금', '계약 잔금 지급', 30, 'N', 'Y', NULL, '2026-07-08 14:27:58'),
	('GIVE_MTHD_CD', 'ETC', '기타', '기타 지급방법', 90, 'N', 'Y', NULL, '2026-07-08 14:27:58'),
	('GIVE_MTHD_CD', 'INTERIM', '중도금', '계약 중도금 지급', 20, 'N', 'Y', NULL, '2026-07-08 14:27:58'),
	('GIVE_MTHD_CD', 'PROGRESS', '기성', '기성 지급', 40, 'N', 'Y', NULL, '2026-07-13 16:25:16'),
	('INPUT_SE_CD', 'CNTR', '계약직', '계약직 투입 인력', 30, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('INPUT_SE_CD', 'ETC', '기타', '기타 투입 형태', 90, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('INPUT_SE_CD', 'MAIN', '정', '주 투입 인력', 10, 'Y', 'Y', NULL, '2026-06-30 11:27:30'),
	('INPUT_SE_CD', 'OUTSRC', '외주', '외주 또는 협력업체 인력', 40, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('INPUT_SE_CD', 'SUB', '부', '보조 투입 인력', 20, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('INST_SE_CD', 'PBL', '공공', '공공기관 발주 사업', 10, 'Y', 'Y', NULL, '2026-06-30 10:03:28'),
	('INST_SE_CD', 'PRIVT', '민간', '민간기관 발주 사업', 20, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('POWK_SE_CD', 'CLIENT', '상주', '고객사 상주', 40, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('POWK_SE_CD', 'HOME', '재택', '재택 근무', 20, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('POWK_SE_CD', 'OFFICE', '본사', '본사 근무', 10, 'Y', 'Y', NULL, '2026-06-30 10:03:28'),
	('POWK_SE_CD', 'OUTSIDE', '외근', '외근 또는 출장', 30, 'N', 'Y', NULL, '2026-06-30 10:03:28'),
	('REL_SE_CD', 'END_USER', '최종사용자(갑)', '실제 수요기관 또는 최종 사용자', 10, 'Y', 'Y', NULL, '2026-06-30 11:27:30'),
	('REL_SE_CD', 'ETC', '기타', '기타 계약 관계자', 90, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('REL_SE_CD', 'OUR_CO', '우리회사', '당사 계약/수행 위치', 40, 'N', 'N', NULL, '2026-06-30 11:27:30'),
	('REL_SE_CD', 'PRIME_CTRTR', '1차계약자(을)', '최종사용자와 직접 계약한 원도급사', 20, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('REL_SE_CD', 'SUB_CTRTR', '하도급', '하도급 또는 하도급 N차 수행사', 30, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('SCHDL_SE_CD', 'END', '종료', '납품/검수/완료', 30, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('SCHDL_SE_CD', 'ETC', '기타', '기타 일정', 90, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('SCHDL_SE_CD', 'FREE_MAINT', '무상유지보수', '무상 유지보수 기간 작업', 40, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('SCHDL_SE_CD', 'ORDER', '수주', '계약/수주 이후 주요 수행', 20, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('SCHDL_SE_CD', 'PAID_MAINT', '유상유지보수', '유상 유지보수 기간 작업', 50, 'N', 'Y', NULL, '2026-06-30 11:27:30'),
	('SCHDL_SE_CD', 'PRE', '사전작업', '제안/분석/착수 전 준비', 10, 'Y', 'Y', NULL, '2026-06-30 11:27:30');
/*!40000 ALTER TABLE `cmn_cd` ENABLE KEYS */;

-- 테이블 trs_ibp.cmn_cd_group 구조 내보내기
CREATE TABLE IF NOT EXISTS `cmn_cd_group` (
  `CD_GROUP_ID` varchar(50) NOT NULL COMMENT '코드그룹ID',
  `CD_GROUP_NM` varchar(100) NOT NULL COMMENT '코드그룹명',
  `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `SORT_SEQ` int(11) DEFAULT 0 COMMENT '정렬순서',
  `RMRK_CN` varchar(500) DEFAULT NULL COMMENT '비고내용',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  PRIMARY KEY (`CD_GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='공통코드그룹';

-- 테이블 데이터 trs_ibp.cmn_cd_group:~12 rows (대략적) 내보내기
DELETE FROM `cmn_cd_group`;
/*!40000 ALTER TABLE `cmn_cd_group` DISABLE KEYS */;
INSERT INTO `cmn_cd_group` (`CD_GROUP_ID`, `CD_GROUP_NM`, `USE_YN`, `SORT_SEQ`, `RMRK_CN`, `REG_DT`) VALUES
	('BIZ_KND_CD', '사업종류코드', 'Y', 30, 'SI, SM, 연구개발 등 사업 종류', '2026-06-30 10:03:28'),
	('BIZ_SE_CD', '사업구분코드', 'Y', 40, '최초개발, 유지보수, 고도화 등 사업 성격', '2026-06-30 10:03:28'),
	('BIZ_STTS_CD', '사업상태코드', 'Y', 10, '사업 진행 상태', '2026-06-30 10:03:28'),
	('CAL_SCHDL_SE_CD', '캘린더일정구분코드', 'Y', 120, '휴가, 출장, 외근, 회의, 프로젝트 등 캘린더 일정 구분', '2026-07-14 16:44:07'),
	('CST_SE_CD', '비용구분코드', 'Y', 90, '출장비, 숙박비, 식대, 회의비 등 직접비 구분', '2026-06-30 11:27:30'),
	('CUST_SE_CD', '고객구분코드', 'Y', 60, '공공/민간 고객사 구분', '2026-06-30 11:27:30'),
	('GIVE_MTHD_CD', '지급방법코드', 'Y', 110, '선금, 중도금, 잔금 등 계약 지급방법', '2026-07-08 14:27:58'),
	('INPUT_SE_CD', '투입구분코드', 'Y', 80, '정/부/계약직/외주 등 투입 형태', '2026-06-30 11:27:30'),
	('INST_SE_CD', '기관구분코드', 'Y', 20, '공공/민간 기관 구분', '2026-06-30 10:03:28'),
	('POWK_SE_CD', '근무장소구분코드', 'Y', 50, '본사, 재택, 외근, 상주 등 근무 장소', '2026-06-30 10:03:28'),
	('REL_SE_CD', '계약관계구분코드', 'Y', 70, '최종사용자, 1차계약자, 하도급, 우리회사 등 계약관계', '2026-06-30 11:27:30'),
	('SCHDL_SE_CD', '일정구분코드', 'Y', 100, '사전작업, 수주, 종료, 유지보수 등 프로세스 일정', '2026-06-30 11:27:30');
/*!40000 ALTER TABLE `cmn_cd_group` ENABLE KEYS */;

-- 테이블 trs_ibp.co_aply_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `co_aply_info` (
  `APLY_SN` int(11) NOT NULL AUTO_INCREMENT COMMENT '신청일련번호',
  `CO_NM` varchar(100) NOT NULL COMMENT '회사명',
  `BRNO` varchar(20) NOT NULL COMMENT '사업자등록번호',
  `APLCNT_NM` varchar(50) NOT NULL COMMENT '신청자명',
  `RPRSV_NM` varchar(50) NOT NULL COMMENT '대표자명',
  `PIC_TELNO` varchar(20) NOT NULL COMMENT '담당자전화번호',
  `PIC_EML_ADDR` varchar(100) NOT NULL COMMENT '담당자이메일주소',
  `ORGNL_FILE_NM` varchar(255) DEFAULT NULL COMMENT '원본파일명',
  `ENCPT_FILE_NM` varchar(255) DEFAULT NULL COMMENT '암호화파일명',
  `FILE_PATH_NM` varchar(500) DEFAULT NULL COMMENT '파일경로명',
  `PRCS_STTS_CD` varchar(10) DEFAULT 'WAIT' COMMENT '처리상태코드',
  `RJCT_RSN` varchar(500) DEFAULT NULL COMMENT '반려사유',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  `PRCS_DT` datetime DEFAULT NULL COMMENT '처리일시',
  PRIMARY KEY (`APLY_SN`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='회사신청정보';

-- 테이블 데이터 trs_ibp.co_aply_info:~5 rows (대략적) 내보내기
DELETE FROM `co_aply_info`;
/*!40000 ALTER TABLE `co_aply_info` DISABLE KEYS */;
INSERT INTO `co_aply_info` (`APLY_SN`, `CO_NM`, `BRNO`, `APLCNT_NM`, `RPRSV_NM`, `PIC_TELNO`, `PIC_EML_ADDR`, `ORGNL_FILE_NM`, `ENCPT_FILE_NM`, `FILE_PATH_NM`, `PRCS_STTS_CD`, `RJCT_RSN`, `REG_DT`, `PRCS_DT`) VALUES
	(3, '쓰리알솔루션', '8548603728', '정다빈', '여혜진', '01051856132', 'jdb910624@gmail.com', 'KakaoTalk_20260529_152048364.png', 'f88b5b5c-4f6c-4384-9dde-74c9639f03fd.png', 'C:/trsStorage/request_biz/', 'WAIT', NULL, '2026-05-29 18:11:55', NULL),
	(4, '삼알솔루션', '123456789012', '가나다', '라마바', '01012341234', 'asdfdsfsfsdaaaaaaaaaaaaaaaaaaaaa@gmaaaaaaaaail.com', 'KakaoTalk_20260529_152031363.png', '7e117204-9ac7-463b-b118-d539c34ba555.png', 'C:/trsStorage/request_biz/', 'WAIT', NULL, '2026-06-01 17:56:36', NULL),
	(5, '삼양솔루션', 'ㅁㄴㅇㄹㄴㅇㄻㄴㅇㄹㅇㄴ', '김가나', '다라마', '01023232345', 'sadfasdf@gmaaaill.com', 'KakaoTalk_20260529_152031363.png', '3fee10f6-f109-4762-852c-27b86abc4329.png', 'C:/trsStorage/request_biz/', 'WAIT', NULL, '2026-06-01 18:00:33', NULL),
	(6, '3알솔루션', '123456789012', '홍길동', '이길여', '01012341234', 'asfdsad@gmail.com', 'KakaoTalk_20260508_152731540.png', '30d14c30-26c0-4cba-9613-eaa04973c79b.png', 'C:/trsStorage/request_biz/', 'WAIT', NULL, '2026-06-04 17:10:12', NULL),
	(7, 'Red Fire death', '1234567890', 'Fire', 'Red', '01012345678', 'jdb910624@gmail.com', '[ZUZU] 서비스 소개서.pdf', '6806c77d-8155-4d2a-a2b3-3faeef746848.pdf', 'request_biz/2026/07/21', 'WAIT', NULL, '2026-07-21 16:30:29', NULL);
/*!40000 ALTER TABLE `co_aply_info` ENABLE KEYS */;

-- 테이블 trs_ibp.co_data_file 구조 내보내기
CREATE TABLE IF NOT EXISTS `co_data_file` (
  `FILE_SN` int(11) NOT NULL AUTO_INCREMENT COMMENT '파일일련번호',
  `DATA_SN` int(11) NOT NULL COMMENT '자료일련번호',
  `ORGNL_FILE_NM` varchar(255) NOT NULL COMMENT '원본파일명',
  `ENCPT_FILE_NM` varchar(255) NOT NULL COMMENT '암호화파일명',
  `FILE_PATH_NM` varchar(500) NOT NULL COMMENT '파일경로명',
  `FILE_SZ` bigint(20) NOT NULL COMMENT '파일크기',
  `FILE_EXTN_NM` varchar(10) NOT NULL COMMENT '파일확장자명',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  PRIMARY KEY (`FILE_SN`),
  KEY `IDX_CO_DATA_FILE_DATA_SN` (`DATA_SN`),
  CONSTRAINT `FK_CO_DATA_FILE_DATA` FOREIGN KEY (`DATA_SN`) REFERENCES `co_data_mng` (`DATA_SN`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='회사자료파일';

-- 테이블 데이터 trs_ibp.co_data_file:~0 rows (대략적) 내보내기
DELETE FROM `co_data_file`;
/*!40000 ALTER TABLE `co_data_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_data_file` ENABLE KEYS */;

-- 테이블 trs_ibp.co_data_mng 구조 내보내기
CREATE TABLE IF NOT EXISTS `co_data_mng` (
  `DATA_SN` int(11) NOT NULL AUTO_INCREMENT COMMENT '자료일련번호',
  `CO_ID` varchar(20) NOT NULL COMMENT '회사ID',
  `DATA_SE_CD` varchar(50) NOT NULL COMMENT '자료구분코드',
  `DATA_NM` varchar(100) NOT NULL COMMENT '자료명',
  `MNG_PIC_ID` varchar(50) NOT NULL COMMENT '관리담당자ID',
  `EXPRY_YMD` date DEFAULT NULL COMMENT '만료일자',
  `ALRM_SNDNG_YN` char(1) DEFAULT 'N' COMMENT '알림발송여부',
  `RGTR_ID` varchar(50) NOT NULL COMMENT '등록자아이디',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  PRIMARY KEY (`DATA_SN`),
  KEY `IDX_CO_DATA_MNG_CO_ID` (`CO_ID`),
  KEY `IDX_CO_DATA_MNG_MNG_PIC_ID` (`MNG_PIC_ID`),
  CONSTRAINT `FK_CO_DATA_MNG_CO` FOREIGN KEY (`CO_ID`) REFERENCES `co_info` (`CO_ID`),
  CONSTRAINT `FK_CO_DATA_MNG_PIC` FOREIGN KEY (`MNG_PIC_ID`) REFERENCES `user_info` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='회사자료관리';

-- 테이블 데이터 trs_ibp.co_data_mng:~0 rows (대략적) 내보내기
DELETE FROM `co_data_mng`;
/*!40000 ALTER TABLE `co_data_mng` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_data_mng` ENABLE KEYS */;

-- 테이블 trs_ibp.co_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `co_info` (
  `CO_ID` varchar(20) NOT NULL COMMENT '회사ID',
  `CO_CD` varchar(10) DEFAULT NULL COMMENT '회사코드',
  `APLY_SN` int(11) DEFAULT NULL COMMENT '신청일련번호',
  `CO_NM` varchar(100) NOT NULL COMMENT '회사명',
  `BRNO` varchar(20) DEFAULT NULL COMMENT '사업자등록번호',
  `RPRSV_NM` varchar(50) DEFAULT NULL COMMENT '대표자명',
  `PIC_NM` varchar(50) DEFAULT NULL COMMENT '담당자명',
  `PIC_TELNO` varchar(20) DEFAULT NULL COMMENT '담당자전화번호',
  `PIC_EML_ADDR` varchar(100) DEFAULT NULL COMMENT '담당자이메일주소',
  `CO_TELNO` varchar(20) DEFAULT NULL COMMENT '회사전화번호',
  `CO_ADDR` varchar(200) DEFAULT NULL COMMENT '회사주소',
  `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  PRIMARY KEY (`CO_ID`),
  UNIQUE KEY `UK_CO_INFO_CO_CD` (`CO_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='회사정보';

-- 테이블 데이터 trs_ibp.co_info:~3 rows (대략적) 내보내기
DELETE FROM `co_info`;
/*!40000 ALTER TABLE `co_info` DISABLE KEYS */;
INSERT INTO `co_info` (`CO_ID`, `CO_CD`, `APLY_SN`, `CO_NM`, `BRNO`, `RPRSV_NM`, `PIC_NM`, `PIC_TELNO`, `PIC_EML_ADDR`, `CO_TELNO`, `CO_ADDR`, `USE_YN`, `REG_DT`) VALUES
	('COMP001', 'TRS', NULL, '(주)쓰리알솔루션', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Y', '2026-05-28 16:13:07'),
	('COMP002', 'WIZB', NULL, '위즈브레인', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Y', '2026-07-09 14:12:09'),
	('COMP003', 'HIVE', NULL, '하이브시스템', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Y', '2026-07-09 14:12:21');
/*!40000 ALTER TABLE `co_info` ENABLE KEYS */;

-- 테이블 trs_ibp.co_ip_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `co_ip_info` (
  `IP_SN` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IP일련번호',
  `CO_ID` varchar(20) NOT NULL COMMENT '회사ID',
  `PRM_IP_ADDR` varchar(50) NOT NULL COMMENT '허용IP주소',
  `IP_EXPLN` varchar(100) DEFAULT NULL COMMENT 'IP설명',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  PRIMARY KEY (`IP_SN`),
  KEY `IDX_CO_IP_CO_ID` (`CO_ID`),
  CONSTRAINT `FK_CO_IP_CO` FOREIGN KEY (`CO_ID`) REFERENCES `co_info` (`CO_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='회사IP정보';

-- 테이블 데이터 trs_ibp.co_ip_info:~0 rows (대략적) 내보내기
DELETE FROM `co_ip_info`;
/*!40000 ALTER TABLE `co_ip_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `co_ip_info` ENABLE KEYS */;

-- 테이블 trs_ibp.cust_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `cust_info` (
  `CUST_SN` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '고객일련번호',
  `CUST_CO_NM` varchar(100) NOT NULL COMMENT '고객회사명',
  `CUST_SE_CD` varchar(30) DEFAULT NULL COMMENT '고객구분코드',
  `BRNO` varchar(20) DEFAULT NULL COMMENT '사업자등록번호',
  `RPRSV_NM` varchar(50) DEFAULT NULL COMMENT '대표자명',
  `TELNO` varchar(20) DEFAULT NULL COMMENT '전화번호',
  `ADDR` varchar(300) DEFAULT NULL COMMENT '주소',
  `DADDR` varchar(300) DEFAULT NULL COMMENT '상세주소',
  `RMRK_CN` varchar(1000) DEFAULT NULL COMMENT '비고내용',
  `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `co_id` varchar(50) DEFAULT NULL,
  `RGTR_ID` varchar(50) DEFAULT NULL,
  `MDFR_ID` varchar(50) DEFAULT NULL COMMENT '수정자아이디',
  PRIMARY KEY (`CUST_SN`),
  KEY `IDX_CUST_INFO_NM` (`CUST_CO_NM`),
  KEY `IDX_CUST_INFO_BRNO` (`BRNO`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='고객정보';

-- 테이블 데이터 trs_ibp.cust_info:~12 rows (대략적) 내보내기
DELETE FROM `cust_info`;
/*!40000 ALTER TABLE `cust_info` DISABLE KEYS */;
INSERT INTO `cust_info` (`CUST_SN`, `CUST_CO_NM`, `CUST_SE_CD`, `BRNO`, `RPRSV_NM`, `TELNO`, `ADDR`, `DADDR`, `RMRK_CN`, `USE_YN`, `REG_DT`, `MDFCN_DT`, `co_id`, `RGTR_ID`, `MDFR_ID`) VALUES
	(1, '1', 'PBL', '1', '1', '1', '1', NULL, NULL, 'Y', '2026-06-30 13:47:35', NULL, 'COMP001', NULL, NULL),
	(2, '자동차안전연구원', 'PBL', '1', '1', '1', '1', NULL, NULL, 'Y', '2026-06-30 13:48:50', '2026-07-09 18:50:04', 'COMP001', 'user12345', 'user12345'),
	(3, '쓰리알솔루션', 'PRIVT', '2', '2', '2', '2', NULL, NULL, 'Y', '2026-06-30 13:50:51', '2026-07-09 18:50:15', 'COMP001', 'user12345', 'user12345'),
	(4, '테크플로우', 'PRIVT', '3', '3', '3', '3', NULL, NULL, 'Y', '2026-06-30 13:51:19', '2026-07-09 18:50:26', 'COMP001', 'user12345', 'user12345'),
	(5, 'TBN', 'PBL', '', '', '', '', NULL, NULL, 'Y', '2026-07-09 16:52:20', NULL, 'COMP002', 'wiz123', NULL),
	(6, '위즈브레인', 'PRIVT', '', '', '', '', NULL, NULL, 'Y', '2026-07-09 16:52:52', '2026-07-09 18:37:08', 'COMP002', 'wiz123', 'wiz123'),
	(7, '나인텔레콤', 'PRIVT', '', '', '', '', NULL, NULL, 'Y', '2026-07-09 16:53:22', NULL, 'COMP002', 'wiz123', NULL),
	(8, 'CID', 'PRIVT', '', '김재훈', '', '', NULL, NULL, 'Y', '2026-07-09 16:54:11', '2026-07-09 18:37:52', 'COMP002', 'wiz123', 'wiz123'),
	(9, '공항철도', 'PBL', '', '', '', '', NULL, NULL, 'Y', '2026-07-09 17:07:00', NULL, 'COMP002', 'wiz123', NULL),
	(10, '케이원정보통신', 'PRIVT', '', '', '', '', NULL, NULL, 'Y', '2026-07-09 17:07:20', NULL, 'COMP002', 'wiz123', NULL),
	(11, '위즈브레인', 'PBL', '', '', '', '', NULL, NULL, 'Y', '2026-07-09 17:07:41', NULL, 'COMP002', 'wiz123', NULL),
	(12, '아이티센클로잇', 'PRIVT', '', '', '', '', NULL, NULL, 'Y', '2026-07-09 18:50:49', '2026-07-09 18:51:48', 'COMP001', 'user12345', 'user12345');
/*!40000 ALTER TABLE `cust_info` ENABLE KEYS */;

-- 테이블 trs_ibp.dept_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `dept_info` (
  `DEPT_ID` varchar(20) NOT NULL COMMENT '부서ID',
  `CO_ID` varchar(20) NOT NULL COMMENT '회사ID',
  `DEPT_NM` varchar(100) NOT NULL COMMENT '부서명',
  `UP_DEPT_ID` varchar(20) DEFAULT NULL COMMENT '상위부서ID',
  `DEPT_SE_CD` varchar(10) NOT NULL DEFAULT 'DEPT' COMMENT '조직구분코드(HQ/DEPT/TEAM)',
  `DEPT_EXPLN` varchar(500) DEFAULT NULL COMMENT '조직설명',
  `MNGR_USER_ID` varchar(50) DEFAULT NULL COMMENT '조직장사용자ID',
  `SORT_SEQ` int(11) DEFAULT 0 COMMENT '정렬순서',
  `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  PRIMARY KEY (`DEPT_ID`),
  KEY `IDX_DEPT_CO_ID` (`CO_ID`),
  KEY `IDX_DEPT_UP_DEPT_ID` (`UP_DEPT_ID`),
  KEY `IDX_DEPT_MNGR_USER_ID` (`MNGR_USER_ID`),
  CONSTRAINT `FK_DEPT_CO` FOREIGN KEY (`CO_ID`) REFERENCES `co_info` (`CO_ID`),
  CONSTRAINT `FK_DEPT_UP_DEPT` FOREIGN KEY (`UP_DEPT_ID`) REFERENCES `dept_info` (`DEPT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='부서정보';

-- 테이블 데이터 trs_ibp.dept_info:~14 rows (대략적) 내보내기
DELETE FROM `dept_info`;
/*!40000 ALTER TABLE `dept_info` DISABLE KEYS */;
INSERT INTO `dept_info` (`DEPT_ID`, `CO_ID`, `DEPT_NM`, `UP_DEPT_ID`, `DEPT_SE_CD`, `DEPT_EXPLN`, `MNGR_USER_ID`, `SORT_SEQ`, `USE_YN`, `REG_DT`) VALUES
	('DEPT001', 'COMP001', '경영지원본부', NULL, 'HQ', NULL, NULL, 1, 'Y', '2026-05-28 16:13:07'),
	('DEPT002', 'COMP001', 'SW사업본부', NULL, 'HQ', NULL, 'user1', 2, 'Y', '2026-05-28 16:13:07'),
	('DEPT003', 'COMP001', '인사팀', 'DEPT001', 'TEAM', NULL, NULL, 1, 'Y', '2026-05-28 16:13:07'),
	('DEPT0031', 'COMP001', '기술연구소', NULL, 'HQ', 'adsfadsfasdf', NULL, 4, 'Y', '2026-07-22 18:10:52'),
	('DEPT0034', 'COMP001', '영업팀', NULL, 'HQ', '영업팀', 'user123', 2, 'Y', '2026-07-22 18:10:33'),
	('DEPT004', 'COMP001', '재무팀', 'DEPT001', 'TEAM', NULL, NULL, 2, 'Y', '2026-05-28 16:13:07'),
	('DEPT005', 'COMP001', 'WEB팀', 'DEPT002', 'TEAM', NULL, NULL, 1, 'Y', '2026-05-28 16:13:07'),
	('DEPT006', 'COMP001', 'APP팀', 'DEPT002', 'TEAM', NULL, NULL, 2, 'Y', '2026-05-28 16:13:07'),
	('DEPT007', 'COMP002', '경영지원본부', NULL, 'HQ', NULL, NULL, 0, 'Y', '2026-07-09 14:25:01'),
	('DEPT008', 'COMP002', 'WEB팀', NULL, 'HQ', NULL, NULL, 0, 'Y', '2026-07-09 14:25:49'),
	('DEV1234', 'COMP001', '가나다부서', 'DEPT001', 'DEPT', 'asdfasdfas', NULL, 2, 'Y', '2026-07-22 18:16:25'),
	('DSFASDF', 'COMP001', '부서1', NULL, 'DEPT', '부서1', NULL, 5, 'Y', '2026-07-22 18:16:56'),
	('GANA', 'COMP001', '가나다팀', 'DEV1234', 'TEAM', '12312312', NULL, 1, 'Y', '2026-07-22 18:19:56'),
	('HW123', 'COMP001', 'HW연구부', 'DEPT0031', 'DEPT', 'ADSLJFALKSDJ', NULL, 1, 'Y', '2026-07-22 18:19:11');
/*!40000 ALTER TABLE `dept_info` ENABLE KEYS */;

-- 테이블 trs_ibp.insd_eml 구조 내보내기
CREATE TABLE IF NOT EXISTS `insd_eml` (
  `EML_SN` int(11) NOT NULL AUTO_INCREMENT COMMENT '이메일일련번호',
  `SNDR_ID` varchar(50) NOT NULL COMMENT '발송자ID',
  `RCVR_ID` varchar(50) NOT NULL COMMENT '수신자ID',
  `TTL` varchar(200) NOT NULL COMMENT '제목',
  `CN` text NOT NULL COMMENT '내용',
  `PRSL_YN` char(1) DEFAULT 'N' COMMENT '열람여부',
  `DSPTCH_DT` datetime DEFAULT current_timestamp() COMMENT '발신일시',
  PRIMARY KEY (`EML_SN`),
  KEY `IDX_INTRNL_MAIL_SNDR_ID` (`SNDR_ID`),
  KEY `IDX_INTRNL_MAIL_RCVR_ID` (`RCVR_ID`),
  CONSTRAINT `FK_INTRNL_MAIL_RCVR` FOREIGN KEY (`RCVR_ID`) REFERENCES `user_info` (`USER_ID`),
  CONSTRAINT `FK_INTRNL_MAIL_SNDR` FOREIGN KEY (`SNDR_ID`) REFERENCES `user_info` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='내부메일';

-- 테이블 데이터 trs_ibp.insd_eml:~0 rows (대략적) 내보내기
DELETE FROM `insd_eml`;
/*!40000 ALTER TABLE `insd_eml` DISABLE KEYS */;
/*!40000 ALTER TABLE `insd_eml` ENABLE KEYS */;

-- 테이블 trs_ibp.schdl_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `schdl_info` (
  `SCHDL_SN` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '일정일련번호',
  `CO_ID` varchar(20) NOT NULL COMMENT '회사ID',
  `BIZ_ID` varchar(20) DEFAULT NULL COMMENT '사업ID',
  `SCHDL_SE_CD` varchar(30) NOT NULL COMMENT '일정구분코드',
  `VAC_SE_CD` varchar(20) DEFAULT NULL COMMENT '휴가구분코드',
  `SCHDL_NM` varchar(200) NOT NULL COMMENT '일정명',
  `BGNG_DT` datetime NOT NULL COMMENT '시작일시',
  `END_DT` datetime NOT NULL COMMENT '종료일시',
  `SCHDL_CN` varchar(1000) DEFAULT NULL COMMENT '일정내용',
  `ALL_DAY_YN` char(1) NOT NULL DEFAULT 'N' COMMENT '종일여부',
  `PLACE_NM` varchar(100) DEFAULT NULL COMMENT '장소명',
  `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `RGTR_ID` varchar(50) DEFAULT NULL COMMENT '등록자아이디',
  `MDFR_ID` varchar(50) DEFAULT NULL COMMENT '수정자아이디',
  PRIMARY KEY (`SCHDL_SN`),
  KEY `IDX_SCHDL_BIZ` (`BIZ_ID`),
  KEY `IDX_SCHDL_INFO_CO_DT` (`CO_ID`,`BGNG_DT`,`END_DT`),
  KEY `IDX_SCHDL_INFO_SE` (`SCHDL_SE_CD`),
  CONSTRAINT `FK_SCHDL_BIZ` FOREIGN KEY (`BIZ_ID`) REFERENCES `biz_info` (`BIZ_ID`) ON DELETE SET NULL,
  CONSTRAINT `FK_SCHDL_CO` FOREIGN KEY (`CO_ID`) REFERENCES `co_info` (`CO_ID`),
  CONSTRAINT `CHK_SCHDL_VAC_SE` CHECK (`SCHDL_SE_CD` = 'VAC' and `VAC_SE_CD` is not null and (`VAC_SE_CD` = 'ANNUAL' and `ALL_DAY_YN` = 'Y' or `VAC_SE_CD` in ('HALF','HOURLY') and `ALL_DAY_YN` = 'N') or `SCHDL_SE_CD` <> 'VAC' and `VAC_SE_CD` is null)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COMMENT='일정정보';

-- 테이블 데이터 trs_ibp.schdl_info:~19 rows (대략적) 내보내기
DELETE FROM `schdl_info`;
/*!40000 ALTER TABLE `schdl_info` DISABLE KEYS */;
INSERT INTO `schdl_info` (`SCHDL_SN`, `CO_ID`, `BIZ_ID`, `SCHDL_SE_CD`, `VAC_SE_CD`, `SCHDL_NM`, `BGNG_DT`, `END_DT`, `SCHDL_CN`, `ALL_DAY_YN`, `PLACE_NM`, `USE_YN`, `REG_DT`, `MDFCN_DT`, `RGTR_ID`, `MDFR_ID`) VALUES
	(25, 'COMP001', 'B20260709180250W5ILR', 'OUTSIDE', NULL, '신규 프로젝트 미팅', '2026-07-16 00:00:00', '2026-07-16 23:59:59', '종일로잡아놨는데 17시에 복귀함 ㄷㄷ', 'Y', 'tbn', 'Y', '2026-07-20 18:46:00', '2026-07-20 18:47:24', 'user12345', 'user12345'),
	(26, 'COMP001', 'B20260630133620G5XM3', 'BIZTRIP', NULL, '출장테스트', '2026-07-15 09:00:00', '2026-07-17 18:00:00', '테스트내용', 'N', '테스트지역', 'Y', '2026-07-20 18:48:10', '2026-07-22 10:28:38', 'user12345', 'user12345'),
	(27, 'COMP001', 'B20260630133620G5XM3', 'MEETING', NULL, '회의테스트', '2026-07-14 09:00:00', '2026-07-15 08:59:00', '테스트내용회의', 'N', '회의테스트장소', 'Y', '2026-07-20 18:49:20', '2026-07-22 10:25:18', 'user12345', 'user12345'),
	(28, 'COMP001', NULL, 'VAC', 'HOURLY', '시간대', '2026-07-17 18:01:00', '2026-07-21 18:00:00', 'ㅁㄴㅇㄻㄴㅇㄹ', 'N', 'ㅁㄴㅇㄻㄴㅇㄹㅇ', 'Y', '2026-07-20 18:52:21', NULL, 'user12345', NULL),
	(29, 'COMP001', NULL, 'ETC', NULL, 'EXTRA', '2026-07-13 00:00:00', '2026-07-17 23:59:59', 'TEXT EXTRA GUITAR', 'Y', 'GUITAR', 'N', '2026-07-21 14:04:41', '2026-07-22 10:23:39', 'user12345', 'user12345'),
	(30, 'COMP001', 'B20260709180250W5ILR', 'BIZTRIP', NULL, '출장테스트', '2026-07-21 00:00:00', '2026-07-21 23:59:59', '', 'Y', '', 'N', '2026-07-21 15:37:08', '2026-07-21 15:37:43', 'admin1', 'user12345'),
	(31, 'COMP001', NULL, 'VAC', 'ANNUAL', '연차', '2026-08-10 00:00:00', '2026-08-12 23:59:59', ' 딩굴딩굴', 'Y', '집', 'Y', '2026-07-21 16:12:44', NULL, 'user12345', NULL),
	(32, 'COMP001', 'B20260709180250W5ILR', 'OUTSIDE', NULL, '외근 중복 등록', '2026-07-22 09:00:00', '2026-07-22 12:00:00', '오전 외근 등록', 'N', '원주', 'Y', '2026-07-21 16:15:12', NULL, 'user12345', NULL),
	(33, 'COMP001', 'B20260630133620G5XM3', 'OUTSIDE', NULL, '외근 중복', '2026-07-22 14:10:00', '2026-07-22 17:19:00', '중복 중복\n시간 텀 있음', 'N', '화성', 'Y', '2026-07-21 16:20:03', NULL, 'user12345', NULL),
	(34, 'COMP001', 'B20260709180250W5ILR', 'CLIENT', NULL, '1', '2026-07-15 09:00:00', '2026-07-15 10:00:00', '', 'N', '', 'Y', '2026-07-21 19:16:11', NULL, 'user12345', NULL),
	(35, 'COMP001', NULL, 'VAC', 'HOURLY', '시간대', '2026-07-15 11:00:00', '2026-07-15 12:00:00', '2', 'N', '2', 'Y', '2026-07-21 19:16:56', NULL, 'user12345', NULL),
	(36, 'COMP001', 'B20260709180250W5ILR', 'HOME', NULL, '21321312', '2026-07-15 13:00:00', '2026-07-15 14:00:00', '123123123', 'N', '12212312', 'Y', '2026-07-22 09:54:12', NULL, 'user12345', NULL),
	(37, 'COMP001', 'B20260630133620G5XM3', 'OUTSIDE', NULL, '123213', '2026-07-15 17:00:00', '2026-07-15 18:00:00', '', 'N', '', 'Y', '2026-07-22 10:11:49', NULL, 'user12345', NULL),
	(38, 'COMP001', NULL, 'ETC', NULL, 'ㄴㅁㅇㄹㄴㅇ12312', '2026-07-15 16:00:00', '2026-07-15 17:00:00', '기타2', 'N', '기타1', 'Y', '2026-07-22 10:23:28', NULL, 'user12345', NULL),
	(39, 'COMP001', 'B20260709180250W5ILR', 'BIZTRIP', NULL, 'fasdfasdfads', '2026-07-15 14:01:00', '2026-07-15 14:02:00', 'fasdfasdfasd', 'N', 'sdafasd', 'Y', '2026-07-22 11:12:38', NULL, 'user12345', NULL),
	(40, 'COMP001', 'B20260709180250W5ILR', 'MEETING', NULL, 'ㄴㅁㅇㄹㄴㅇ', '2026-07-15 14:11:00', '2026-07-15 14:13:00', 'sadf', 'N', 'asdfasdf', 'Y', '2026-07-22 11:13:16', NULL, 'user12345', NULL),
	(41, 'COMP001', NULL, 'VAC', 'HALF', '반차', '2026-07-02 09:00:00', '2026-07-02 18:00:00', 'ㅁㄴㅇㄻㄴㅇㄻㄴㅇㄻㄴㅇ', 'N', 'ㄴㅁㅇㄻㄴㅇㄹ', 'Y', '2026-07-22 12:49:41', NULL, 'user12345', NULL),
	(42, 'COMP001', NULL, 'VAC', 'ANNUAL', '연차', '2026-07-22 00:00:00', '2026-07-22 23:59:59', 'asdfasdf', 'Y', 'sadfasd', 'Y', '2026-07-22 16:46:40', NULL, 'user12345', NULL),
	(43, 'COMP001', 'B20260630133620G5XM3', 'BIZTRIP', NULL, 'sdafasdfasdf', '2026-07-22 00:00:00', '2026-07-22 23:59:59', 'asdfasdfasdfsdf', 'Y', 'sdafasdfsdf', 'Y', '2026-07-22 17:20:57', NULL, 'user12345', NULL);
/*!40000 ALTER TABLE `schdl_info` ENABLE KEYS */;

-- 테이블 trs_ibp.schdl_user_rel 구조 내보내기
CREATE TABLE IF NOT EXISTS `schdl_user_rel` (
  `SCHDL_SN` bigint(20) NOT NULL COMMENT '일정일련번호',
  `USER_ID` varchar(50) NOT NULL COMMENT '사용자아이디',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  PRIMARY KEY (`SCHDL_SN`,`USER_ID`),
  KEY `IDX_SCHDL_USER_REL_USER` (`USER_ID`),
  CONSTRAINT `FK_SCHDL_USER_REL_SCHDL` FOREIGN KEY (`SCHDL_SN`) REFERENCES `schdl_info` (`SCHDL_SN`) ON DELETE CASCADE,
  CONSTRAINT `FK_SCHDL_USER_REL_USER` FOREIGN KEY (`USER_ID`) REFERENCES `user_info` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='일정사용자관계';

-- 테이블 데이터 trs_ibp.schdl_user_rel:~22 rows (대략적) 내보내기
DELETE FROM `schdl_user_rel`;
/*!40000 ALTER TABLE `schdl_user_rel` DISABLE KEYS */;
INSERT INTO `schdl_user_rel` (`SCHDL_SN`, `USER_ID`, `REG_DT`) VALUES
	(25, 'user1', '2026-07-20 18:47:24'),
	(25, 'user12345', '2026-07-20 18:47:24'),
	(26, 'admin1', '2026-07-22 10:28:38'),
	(26, 'user123', '2026-07-22 10:28:38'),
	(27, 'admin1', '2026-07-22 10:25:18'),
	(27, 'user12345', '2026-07-22 10:25:18'),
	(28, 'admin1', '2026-07-20 18:52:21'),
	(29, 'user123', '2026-07-21 14:04:41'),
	(30, 'user12345', '2026-07-21 15:37:08'),
	(31, 'user12345', '2026-07-21 16:12:44'),
	(32, 'user12345', '2026-07-21 16:15:12'),
	(33, 'user12345', '2026-07-21 16:20:03'),
	(34, 'user1', '2026-07-21 19:16:11'),
	(35, 'user1', '2026-07-21 19:16:56'),
	(36, 'user1', '2026-07-22 09:54:12'),
	(37, 'user1', '2026-07-22 10:11:49'),
	(38, 'user1', '2026-07-22 10:23:28'),
	(39, 'user1', '2026-07-22 11:12:38'),
	(40, 'user1', '2026-07-22 11:13:16'),
	(41, 'user12345', '2026-07-22 12:49:41'),
	(42, 'user12345', '2026-07-22 16:46:40'),
	(43, 'user12345', '2026-07-22 17:20:57');
/*!40000 ALTER TABLE `schdl_user_rel` ENABLE KEYS */;

-- 테이블 trs_ibp.user_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_info` (
  `USER_ID` varchar(50) NOT NULL COMMENT '사용자아이디',
  `USER_ENPSWD` varchar(200) NOT NULL COMMENT '사용자암호화비밀번호',
  `USER_NM` varchar(100) NOT NULL COMMENT '사용자명',
  `CO_ID` varchar(20) DEFAULT NULL COMMENT '회사ID',
  `DEPT_ID` varchar(20) DEFAULT NULL COMMENT '부서ID',
  `JBPS_NM` varchar(50) DEFAULT NULL COMMENT '직위명',
  `AUTHRT_ID` varchar(20) DEFAULT NULL COMMENT '권한ID',
  `USER_TELNO` varchar(20) DEFAULT NULL COMMENT '사용자전화번호',
  `USE_YN` char(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `MEMO_CN` varchar(500) DEFAULT NULL COMMENT '메모내용',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  PRIMARY KEY (`USER_ID`),
  KEY `IDX_USER_CO_ID` (`CO_ID`),
  KEY `IDX_USER_DEPT_ID` (`DEPT_ID`),
  KEY `IDX_USER_AUTHRT_ID` (`AUTHRT_ID`),
  CONSTRAINT `FK_USER_AUTHRT` FOREIGN KEY (`AUTHRT_ID`) REFERENCES `authrt_info` (`AUTHRT_ID`),
  CONSTRAINT `FK_USER_CO` FOREIGN KEY (`CO_ID`) REFERENCES `co_info` (`CO_ID`),
  CONSTRAINT `FK_USER_DEPT` FOREIGN KEY (`DEPT_ID`) REFERENCES `dept_info` (`DEPT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='사용자정보';

-- 테이블 데이터 trs_ibp.user_info:~7 rows (대략적) 내보내기
DELETE FROM `user_info`;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` (`USER_ID`, `USER_ENPSWD`, `USER_NM`, `CO_ID`, `DEPT_ID`, `JBPS_NM`, `AUTHRT_ID`, `USER_TELNO`, `USE_YN`, `MEMO_CN`, `REG_DT`) VALUES
	('admin1', '$2a$10$4YOHWXdXXeG85cM9g9MC7OWrDuNe96UjHqY5MlsMIlz6voySqYXZm', '시스템관리자', 'COMP001', 'DEPT001', '대표', 'ADMIN', NULL, 'Y', '초기 관리자 계정 (비밀번호: 1)', '2026-05-28 16:13:07'),
	('superadmin', '$2a$10$v6iC2ogo8qkbbt7vWi.rduQPRBEk9E8XLZNj9T8acW3GIqpQnx2a2', '회사관리자', 'COMP002', 'DEPT008', '과장', 'ADMIN', '', 'Y', 'ㅁㄴㅇㄻㄴㅇㄹ1234', '2026-07-20 13:39:45'),
	('user1', '$2a$10$4YOHWXdXXeG85cM9g9MC7OWrDuNe96UjHqY5MlsMIlz6voySqYXZm', '유저1', 'COMP001', 'DEPT001', '상무', 'USER', '01012341234', 'Y', '', '2026-06-01 16:31:57'),
	('user12', '$2a$10$4YOHWXdXXeG85cM9g9MC7OWrDuNe96UjHqY5MlsMIlz6voySqYXZm', 'tRS', 'COMP001', 'DEPT003', '과장', 'USER', '01012341234', 'N', '사용자명 수정', '2026-07-14 15:34:40'),
	('user123', '$2a$10$4YOHWXdXXeG85cM9g9MC7OWrDuNe96UjHqY5MlsMIlz6voySqYXZm', '유저123', 'COMP001', 'DEPT001', '대리', 'USER', '01012341234', 'Y', NULL, '2026-06-01 17:30:23'),
	('user12345', '$2a$10$4YOHWXdXXeG85cM9g9MC7OWrDuNe96UjHqY5MlsMIlz6voySqYXZm', '정다빈', 'COMP001', 'DEPT005', '과장', 'USER', '01012341234', 'Y', '', '2026-06-04 16:30:49'),
	('wiz123', '$2a$10$4YOHWXdXXeG85cM9g9MC7OWrDuNe96UjHqY5MlsMIlz6voySqYXZm', '이선희', 'COMP002', 'DEPT007', '차장', 'USER', '01012341234', 'Y', NULL, '2026-07-09 14:29:27');
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;

-- 테이블 trs_ibp.work_hstry 구조 내보내기
CREATE TABLE IF NOT EXISTS `work_hstry` (
  `WORK_HSTRY_SN` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '근무이력일련번호',
  `USER_ID` varchar(50) NOT NULL COMMENT '사용자아이디',
  `WORK_YMD` date NOT NULL COMMENT '근무일자',
  `GTWK_DT` datetime DEFAULT NULL COMMENT '출근일시',
  `LVWK_DT` datetime DEFAULT NULL COMMENT '퇴근일시',
  `POWK_SE_CD` varchar(20) DEFAULT 'OFFICE' COMMENT '근무장소구분코드',
  `WORK_RMRK_CN` varchar(500) DEFAULT NULL COMMENT '근무비고내용',
  `REG_DT` datetime DEFAULT current_timestamp() COMMENT '등록일시',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정일시',
  `GTWK_CNTN_IP_ADDR` varchar(50) DEFAULT NULL COMMENT '출근접속IP주소',
  `LVWK_CNTN_IP_ADDR` varchar(50) DEFAULT NULL COMMENT '퇴근접속IP주소',
  PRIMARY KEY (`WORK_HSTRY_SN`),
  UNIQUE KEY `UQ_WORK_USER_YMD` (`USER_ID`,`WORK_YMD`),
  KEY `IDX_WORK_YMD` (`WORK_YMD`),
  CONSTRAINT `FK_WORK_USER` FOREIGN KEY (`USER_ID`) REFERENCES `user_info` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COMMENT='근무이력';

-- 테이블 데이터 trs_ibp.work_hstry:~30 rows (대략적) 내보내기
DELETE FROM `work_hstry`;
/*!40000 ALTER TABLE `work_hstry` DISABLE KEYS */;
INSERT INTO `work_hstry` (`WORK_HSTRY_SN`, `USER_ID`, `WORK_YMD`, `GTWK_DT`, `LVWK_DT`, `POWK_SE_CD`, `WORK_RMRK_CN`, `REG_DT`, `MDFCN_DT`, `GTWK_CNTN_IP_ADDR`, `LVWK_CNTN_IP_ADDR`) VALUES
	(3, 'admin1', '2026-05-29', '2026-05-29 14:29:34', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-05-29 14:29:34', NULL, NULL, NULL),
	(4, 'admin1', '2026-06-01', '2026-06-01 10:23:37', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-06-01 10:23:37', NULL, NULL, NULL),
	(5, 'user1', '2026-06-01', '2026-06-01 16:32:04', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-06-01 16:32:04', NULL, NULL, NULL),
	(6, 'admin1', '2026-06-02', '2026-06-02 16:00:58', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-06-02 16:00:58', NULL, NULL, NULL),
	(7, 'admin1', '2026-06-04', '2026-06-04 15:41:40', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-06-04 15:41:40', NULL, NULL, NULL),
	(8, 'user12345', '2026-06-04', '2026-06-04 16:31:03', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-06-04 16:31:03', NULL, NULL, NULL),
	(9, 'user12345', '2026-06-05', '2026-06-05 15:51:38', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-06-05 15:51:38', NULL, NULL, NULL),
	(10, 'user12345', '2026-06-22', '2026-06-22 11:15:06', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-06-22 11:15:06', NULL, NULL, NULL),
	(11, 'admin1', '2026-06-29', '2026-06-29 10:12:25', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-06-29 10:12:25', NULL, NULL, NULL),
	(14, 'user12345', '2026-06-30', '2026-06-30 10:08:19', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-06-30 10:08:19', NULL, NULL, NULL),
	(15, 'user12345', '2026-07-02', '2026-07-02 15:27:25', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-02 15:27:25', NULL, NULL, NULL),
	(16, 'user12345', '2026-07-07', '2026-07-07 15:48:13', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-07 15:48:13', NULL, NULL, NULL),
	(17, 'user12345', '2026-07-08', '2026-07-08 13:09:28', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-08 13:09:28', NULL, NULL, NULL),
	(18, 'user12345', '2026-07-09', '2026-07-09 10:19:26', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-09 10:19:26', NULL, NULL, NULL),
	(19, 'wiz123', '2026-07-09', '2026-07-09 14:29:37', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-09 14:29:37', NULL, NULL, NULL),
	(20, 'user12345', '2026-07-13', '2026-07-13 10:47:49', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-13 10:47:49', NULL, NULL, NULL),
	(21, 'wiz123', '2026-07-13', '2026-07-13 10:51:34', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-13 10:51:34', NULL, NULL, NULL),
	(22, 'admin1', '2026-07-13', '2026-07-13 13:21:54', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-13 13:21:54', NULL, NULL, NULL),
	(23, 'user12345', '2026-07-14', '2026-07-14 11:14:55', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-14 11:14:55', NULL, NULL, NULL),
	(24, 'wiz123', '2026-07-14', '2026-07-14 13:38:25', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-14 13:38:25', NULL, NULL, NULL),
	(25, 'user12', '2026-07-14', '2026-07-14 15:34:51', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-14 15:34:51', NULL, NULL, NULL),
	(26, 'admin1', '2026-07-14', '2026-07-14 16:45:42', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-14 16:45:42', NULL, NULL, NULL),
	(27, 'user12345', '2026-07-15', '2026-07-15 19:18:18', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-15 19:18:18', NULL, NULL, NULL),
	(28, 'user12345', '2026-07-16', '2026-07-16 17:37:35', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-16 17:37:35', NULL, NULL, NULL),
	(29, 'user12345', '2026-07-20', '2026-07-20 10:17:29', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-20 10:17:29', NULL, NULL, NULL),
	(30, 'wiz123', '2026-07-20', '2026-07-20 13:14:05', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-20 13:14:05', NULL, NULL, NULL),
	(31, 'superadmin', '2026-07-20', '2026-07-20 14:07:00', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-20 14:07:00', NULL, NULL, NULL),
	(32, 'user12345', '2026-07-21', '2026-07-21 14:03:27', NULL, 'OUTSIDE', '로그인 시 시스템 자동 출근 처리', '2026-07-21 14:03:27', '2026-07-21 17:15:14', NULL, NULL),
	(33, 'admin1', '2026-07-21', '2026-07-21 15:36:20', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-21 15:36:20', NULL, NULL, NULL),
	(34, 'user12345', '2026-07-22', '2026-07-22 09:51:26', NULL, 'OFFICE', '로그인 시 시스템 자동 출근 처리', '2026-07-22 09:51:26', NULL, NULL, NULL);
/*!40000 ALTER TABLE `work_hstry` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
