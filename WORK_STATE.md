# TRS_IBP 현재 개발 상태

최종 갱신일: 2026-07-28 (Asia/Seoul)

## Git 기준

- 작업 브랜치: `agent/workspace-dashboard-authority`
- 작업 시작 기준 HEAD: `a57f0439f7b731671923db41b0cd906c7d5dbc17`
- 기준 커밋 메시지: `최종 조직도 복구 및 폼 정렬 수정`
- 보존 필수 기능: 확장형 조직도, 조직 상세 모달, 조직 접기·펼치기, 부서 해제, 사용자 폼 행·열 정렬

## 이번 변경 범위

- 루트 `AGENTS.md`에 프로젝트 필수 규칙 고정
- 코레일 권한관리 참고 화면을 현재 DevSync 정보구조에 맞게 재구성
- 역할별 업무공간 및 화면·목록·상세·등록·수정·삭제 권한 관리
- 메뉴 숨김과 별개로 `.do`·`.ajax` 서버 요청 권한 검증
- 사용자별 기본 업무공간 지정 및 로그인 세션 적용
- 업무·프로젝트·조직·경영 대시보드의 임의 수치 제거
- 최신 DB 스키마의 일정·근태·사업·투입인력·비용·사용자·조직 데이터 연동
- 비관리자의 사업 조회를 `biz_mnpw` 참여 관계 범위로 제한
- 일정 상세는 대상자, 일정 수정·삭제는 등록자 범위로 제한
- 계약·회계 권한이 없을 때 계약금액·손익 데이터 응답 마스킹

## DB 기준과 적용 순서

- 기준 스키마: 사용자 제공 `trs_ibp(9).sql`
- 용어 기준: 사용자 제공 `공공데이터 공통표준(2025.11월)(3).xlsx`
- 신규 migration: `TrsIbp/src/main/resources/db/migration/20260728_workspace_authority.sql`
- 적용 DB: MariaDB 10.6

배포 전 신규 migration을 먼저 적용해야 합니다. 이 migration은 다음을 수행합니다.

1. 기존 `authrt_info`의 하위 호환을 유지하며 관리 컬럼을 보강합니다.
2. `workspc_info`, `menu_info`, `authrt_menu_rel`, `user_workspc_rel`을 생성합니다.
3. 내 업무·프로젝트·조직·경영 업무공간과 현재 구현 URL을 등록합니다.
4. `ADMIN`, `MANAGER`, `USER` 기본 권한과 모든 활성 사용자의 내 업무 기본값을 초기화합니다.

## 권한 구조

| 구분 | 구현 기준 |
|---|---|
| 최고관리자 `ADMIN` | 전체 업무공간·기능, 역할·권한 설정 |
| 관리자 `MANAGER` | 내 업무·참여 프로젝트·조직·경영 조회/업무, 최고관리자 설정 제외 |
| 일반사용자 `USER` | 내 업무 대시보드와 일정 기능 |
| 사용자 정의 권한 | 권한 화면에서 업무공간별 기능을 개별 선택 |

- 화면 버튼은 `MENU_CD` 기준으로 노출합니다.
- 서버는 `MENU_URL_ADDR`와 요청 유형(`SCREEN`, `LIST`, `DETAIL`, `REG`, `MDFCN`, `DEL`)을 함께 검사합니다.
- 본인 개인정보 조회는 유지하되 타 사용자 조회는 사용자 상세권한이 필요합니다.
- 최고관리자가 아닌 사용자의 사업 상세·하위 데이터는 본인이 참여한 사업만 허용합니다.
- 최고관리자가 아닌 사용자의 일정 상세는 대상 일정의 참여자, 수정·삭제는 일정 등록자만 허용합니다.

## 대시보드 데이터 출처

| 업무공간 | 연동 테이블 |
|---|---|
| 내 업무 | `schdl_info`, `schdl_user_rel`, `work_hstry`, `biz_mnpw`, `biz_info` |
| 프로젝트 | `biz_info`, `biz_mnpw`, `biz_schdl`, `cmn_cd` |
| 조직 | `dept_info`, `user_info`, `work_hstry`, `schdl_info`, `schdl_user_rel`, `biz_mnpw` |
| 경영 | `user_info`, `biz_info`, `biz_cst` |

현재 DB에 근거가 없는 목업 일정·프로젝트·인원·금액 수치는 제거했습니다. 데이터가 없으면 `0` 또는 빈 상태로 표시합니다.

## 변경 파일군

- 권한: `authority` controller/service/mapper/JSP/CSS/JavaScript
- 대시보드: `dashboard` service/mapper 및 업무공간별 JSP
- 공통 레이아웃: `head.jsp`, `header.jsp`, `sidebar.jsp`, `layout.js`, `layout.css`
- 서버 통제: `AuthInterceptor.java`, `dispatcher-servlet.xml`
- 기존 화면 연동: 일정·사업·사용자·조직 화면의 권한별 버튼과 동적 행

## 검증 상태

- 완료: JavaScript 문법 검사
- 완료: 변경 MyBatis/Spring XML well-formed 검사
- 완료: `git diff --check`
- 완료: 첨부 최신 DB 스키마의 사용 테이블·컬럼 대조
- 미수행: Maven 패키지 빌드 — 현재 작업 환경에 `mvn`/`mvnw`가 없음
- 미수행: 실제 MariaDB 10.6 migration 실행 — 현재 작업 환경에 DB 서버/클라이언트가 없음
- 미수행: 로그인 후 브라우저 역할별 화면 동작 검증 — 실행 DB와 애플리케이션 서버가 없음

미수행 항목은 완료로 간주하지 않습니다. 배포 환경에서 migration 적용 후 `ADMIN`, `MANAGER`, `USER` 및 사용자 정의 권한으로 회귀 검증해야 합니다.
