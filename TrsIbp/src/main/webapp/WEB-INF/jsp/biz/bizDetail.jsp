<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp">
        <jsp:param name="dsTitle" value="DevSync - 사업 상세"/>
    </jsp:include>
</head>
<body class="ds-body min-h-screen flex">
<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"/>

<div class="flex-grow flex flex-col min-h-screen">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="dsPageTitle" value="사업 상세"/>
    </jsp:include>

    <main class="ds-page">
        <div class="ds-breadcrumb">프로젝트/사업 &gt; 전사 사업 현황판 &gt; 사업 상세</div>
        <div class="ds-page-head">
            <div>
                <h1 class="ds-page-title">사업 상세</h1>
                <p class="ds-page-desc">등록된 사업 기본정보와 사업 단계 업무를 조회합니다.</p>
            </div>
            <div class="ds-actions">
                <a href="${pageContext.request.contextPath}/biz/bizList.do" class="ds-btn ds-btn-outline">목록으로</a>
                <a href="${pageContext.request.contextPath}/biz/bizUpdate.do?bizId=${param.bizId}" class="ds-btn ds-btn-primary">수정</a>
                <button type="button" class="ds-btn ds-btn-danger" onclick="deleteBiz();">삭제</button>
            </div>
        </div>

        <section class="ds-card ds-card-inner ds-mb-20">
            <div class="ds-section-head">
                <div>
                    <h2 class="ds-section-title">사업 기본정보</h2>
                    <p class="ds-section-desc">사업ID 기준 상세 정보입니다.</p>
                </div>
            </div>
            <jsp:include page="/WEB-INF/jsp/biz/bizForm.jsp">
                <jsp:param name="mode" value="detail"/>
                <jsp:param name="bizId" value="${param.bizId}"/>
            </jsp:include>
        </section>

        <section class="ds-card ds-card-inner ds-mb-20">
            <div class="ds-section-head">
                <div>
                    <h2 class="ds-section-title">계약 관계 관리</h2>
                    <p class="ds-section-desc">고객사를 등록하고 해당 사업의 갑/을/병/정 계약 관계를 관리합니다.</p>
                </div>
            </div>
            <div class="ds-form-grid ds-mb-20">
                <input type="hidden" id="frmCustSn">
                <input type="hidden" id="frmBizCustRelSn">
                <div class="ds-field">
                    <label for="frmCustCoNm">고객사명</label>
                    <input type="text" id="frmCustCoNm" class="ds-input" maxlength="100">
                </div>
                <div class="ds-field">
                    <label for="frmCustSeCd">고객구분</label>
                    <select id="frmCustSeCd" class="ds-select"><option value="">선택</option></select>
                </div>
                <div class="ds-field">
                    <label for="frmBrno">사업자등록번호</label>
                    <input type="text" id="frmBrno" class="ds-input" maxlength="20">
                </div>
                <div class="ds-field">
                    <label for="frmRprsvNm">대표자명</label>
                    <input type="text" id="frmRprsvNm" class="ds-input" maxlength="50">
                </div>
                <div class="ds-field">
                    <label for="frmTelno">전화번호</label>
                    <input type="text" id="frmTelno" class="ds-input" maxlength="20">
                </div>
                <div class="ds-field">
                    <label for="frmAddr">주소</label>
                    <input type="text" id="frmAddr" class="ds-input" maxlength="300">
                </div>
                <div class="ds-field">
                    <label for="frmRelSeCd">계약관계</label>
                    <select id="frmRelSeCd" class="ds-select"><option value="">선택</option></select>
                </div>
                <div class="ds-field">
                    <label for="frmRelLvl">관계레벨</label>
                    <input type="number" id="frmRelLvl" class="ds-input" min="1" step="1">
                </div>
                <div class="ds-field">
                    <label for="frmRelSortSeq">정렬순서</label>
                    <input type="number" id="frmRelSortSeq" class="ds-input" min="0" step="1">
                </div>
                <div class="ds-field">
                    <label for="frmDirectCtrtYn">직접계약여부</label>
                    <select id="frmDirectCtrtYn" class="ds-select">
                        <option value="N">N</option>
                        <option value="Y">Y</option>
                    </select>
                </div>
                <div class="ds-field">
                    <label for="frmOurCoYn">우리회사여부</label>
                    <select id="frmOurCoYn" class="ds-select">
                        <option value="N">N</option>
                        <option value="Y">Y</option>
                    </select>
                </div>
                <div class="ds-search-actions">
                    <button type="button" class="ds-btn ds-btn-outline ds-btn-full" onclick="resetCustRelForm();">초기화</button>
                </div>
                <div class="ds-search-actions">
                    <button type="button" class="ds-btn ds-btn-primary ds-btn-full" onclick="saveCustAndRel();">저장</button>
                </div>
            </div>
            <div class="ds-table-wrap">
                <table class="ds-table">
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>고객사</th>
                        <th>구분</th>
                        <th>계약관계</th>
                        <th>레벨</th>
                        <th>직접계약</th>
                        <th>우리회사</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody id="bizCustRelBody"></tbody>
                </table>
            </div>
        </section>

        <section class="ds-card ds-card-inner ds-mb-20">
            <div class="ds-section-head">
                <div>
                    <h2 class="ds-section-title">회계 관리</h2>
                    <p class="ds-section-desc">직접비를 등록하고 계약금액 대비 손익을 조회합니다.</p>
                </div>
            </div>
            <section class="ds-summary-grid">
                <div class="ds-summary-card"><div class="ds-summary-label">계약금액</div><div id="profitCtrtAmt" class="ds-summary-value">0</div></div>
                <div class="ds-summary-card"><div class="ds-summary-label">직접비</div><div id="profitDirectCst" class="ds-summary-value">0</div></div>
                <div class="ds-summary-card"><div class="ds-summary-label">인건비</div><div id="profitLaborCst" class="ds-summary-value">0</div></div>
                <div class="ds-summary-card"><div class="ds-summary-label">영업이익</div><div id="profitAmt" class="ds-summary-value">0</div><div id="profitRate" class="ds-summary-hint">0%</div></div>
            </section>
            <div class="ds-form-grid ds-mb-20">
                <input type="hidden" id="frmBizCstSn">
                <div class="ds-field">
                    <label for="frmCstSeCd">비용구분</label>
                    <select id="frmCstSeCd" class="ds-select"><option value="">선택</option></select>
                </div>
                <div class="ds-field">
                    <label for="frmCstNm">비용명</label>
                    <input type="text" id="frmCstNm" class="ds-input" maxlength="100">
                </div>
                <div class="ds-field">
                    <label for="frmOcrnCst">발생비용</label>
                    <input type="number" id="frmOcrnCst" class="ds-input" min="0" step="1">
                </div>
                <div class="ds-field">
                    <label for="frmOcrnYmd">발생일자</label>
                    <input type="date" id="frmOcrnYmd" class="ds-input">
                </div>
                <div class="ds-search-actions">
                    <button type="button" class="ds-btn ds-btn-outline ds-btn-full" onclick="resetCstForm();">초기화</button>
                </div>
                <div class="ds-search-actions">
                    <button type="button" class="ds-btn ds-btn-primary ds-btn-full" onclick="saveBizCst();">저장</button>
                </div>
            </div>
            <div class="ds-table-wrap">
                <table class="ds-table">
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>구분</th>
                        <th>비용명</th>
                        <th>금액</th>
                        <th>발생일자</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody id="bizCstBody"></tbody>
                </table>
            </div>
        </section>

        <section class="ds-card ds-card-inner ds-mb-20">
            <div class="ds-section-head">
                <div>
                    <h2 class="ds-section-title">투입인력 관리</h2>
                    <p class="ds-section-desc">사업별 투입자, 투입기간, M/M, 단가, 역할을 관리합니다.</p>
                </div>
            </div>
            <div class="ds-form-grid ds-mb-20">
                <input type="hidden" id="frmBizMnpwSn">
                <div class="ds-field">
                    <label for="frmUserId">사용자ID</label>
                    <input type="text" id="frmUserId" class="ds-input" maxlength="50" placeholder="내부 사용자일 때만 입력">
                </div>
                <div class="ds-field">
                    <label for="frmInputMnpwNm">투입인력명</label>
                    <input type="text" id="frmInputMnpwNm" class="ds-input" maxlength="50">
                </div>
                <div class="ds-field">
                    <label for="frmInputSeCd">투입구분</label>
                    <select id="frmInputSeCd" class="ds-select"><option value="">선택</option></select>
                </div>
                <div class="ds-field">
                    <label for="frmRoleNm">역할</label>
                    <input type="text" id="frmRoleNm" class="ds-input" maxlength="100">
                </div>
                <div class="ds-field">
                    <label for="frmJbpsNm">직위</label>
                    <input type="text" id="frmJbpsNm" class="ds-input" maxlength="50">
                </div>
                <div class="ds-field">
                    <label for="frmInputBgngYmd">투입시작일</label>
                    <input type="date" id="frmInputBgngYmd" class="ds-input">
                </div>
                <div class="ds-field">
                    <label for="frmInputEndYmd">투입종료일</label>
                    <input type="date" id="frmInputEndYmd" class="ds-input">
                </div>
                <div class="ds-field">
                    <label for="frmInputMcnt">M/M</label>
                    <input type="number" id="frmInputMcnt" class="ds-input" min="0" step="0.01">
                </div>
                <div class="ds-field">
                    <label for="frmUntprc">단가</label>
                    <input type="number" id="frmUntprc" class="ds-input" min="0" step="1">
                </div>
                <div class="ds-search-actions">
                    <button type="button" class="ds-btn ds-btn-outline ds-btn-full" onclick="resetMnpwForm();">초기화</button>
                </div>
                <div class="ds-search-actions">
                    <button type="button" class="ds-btn ds-btn-primary ds-btn-full" onclick="saveBizMnpw();">저장</button>
                </div>
            </div>
            <div class="ds-table-wrap">
                <table class="ds-table">
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>투입자</th>
                        <th>구분</th>
                        <th>역할</th>
                        <th>기간</th>
                        <th>M/M</th>
                        <th>단가</th>
                        <th>인건비</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody id="bizMnpwBody"></tbody>
                </table>
            </div>
        </section>

        <section class="ds-card ds-card-inner">
            <div class="ds-section-head">
                <div>
                    <h2 class="ds-section-title">프로세스(일정) 관리</h2>
                    <p class="ds-section-desc">사업별 작업내용, 완료일, 담당자, 산출물성 메모를 관리합니다.</p>
                </div>
            </div>
            <div class="ds-form-grid ds-mb-20">
                <input type="hidden" id="frmBizSchdlSn">
                <div class="ds-field">
                    <label for="frmSchdlSeCd">일정구분</label>
                    <select id="frmSchdlSeCd" class="ds-select"><option value="">선택</option></select>
                </div>
                <div class="ds-field">
                    <label for="frmSchdlNm">일정명</label>
                    <input type="text" id="frmSchdlNm" class="ds-input" maxlength="200">
                </div>
                <div class="ds-field">
                    <label for="frmSchdlBgngYmd">시작일</label>
                    <input type="date" id="frmSchdlBgngYmd" class="ds-input">
                </div>
                <div class="ds-field">
                    <label for="frmSchdlEndYmd">종료/완료일</label>
                    <input type="date" id="frmSchdlEndYmd" class="ds-input">
                </div>
                <div class="ds-field">
                    <label for="frmPicId">담당자ID</label>
                    <input type="text" id="frmPicId" class="ds-input" maxlength="50">
                </div>
                <div class="ds-field ds-col-span-2">
                    <label for="frmSchdlCn">작업내용</label>
                    <input type="text" id="frmSchdlCn" class="ds-input" maxlength="1000">
                </div>
                <div class="ds-search-actions">
                    <button type="button" class="ds-btn ds-btn-outline ds-btn-full" onclick="resetSchdlForm();">초기화</button>
                </div>
                <div class="ds-search-actions">
                    <button type="button" class="ds-btn ds-btn-primary ds-btn-full" onclick="saveBizSchdl();">저장</button>
                </div>
            </div>
            <div class="ds-table-wrap">
                <table class="ds-table">
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>구분</th>
                        <th>일정명</th>
                        <th>기간</th>
                        <th>담당자</th>
                        <th>작업내용</th>
                        <th>관리</th>
                    </tr>
                    </thead>
                    <tbody id="bizSchdlBody"></tbody>
                </table>
            </div>
        </section>
    </main>
</div>

<script>
    var ctxPath = '${pageContext.request.contextPath}';
    var currentBizId = '${param.bizId}';
    var bizPageMode = 'detail';
</script>
<script src="${pageContext.request.contextPath}/js/biz/biz.js"></script>
<script>
    $(function() {
        initBizDetailPage();
    });
</script>
</body>
</html>
