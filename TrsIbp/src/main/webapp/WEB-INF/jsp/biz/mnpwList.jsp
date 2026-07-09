<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head><jsp:include page="/WEB-INF/jsp/common/head.jsp"><jsp:param name="dsTitle" value="DevSync - 투입인력 관리"/></jsp:include></head>
<body class="ds-body min-h-screen flex">
<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"/>
<div class="flex-grow flex flex-col min-h-screen">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp"><jsp:param name="dsPageTitle" value="투입인력 관리"/></jsp:include>
    <main class="ds-page">
        <div class="ds-breadcrumb">프로젝트/사업 &gt; 투입인력 관리</div>
        <div class="ds-page-head"><div><h1 class="ds-page-title">투입인력 관리</h1><p class="ds-page-desc">사업별 투입자, 기간, M/M, 단가, 역할을 관리합니다.</p></div><div class="ds-actions"><a href="${pageContext.request.contextPath}/biz/bizList.do" class="ds-btn ds-btn-outline">사업 목록</a></div></div>
        <section class="ds-card ds-card-inner ds-mb-20"><div class="ds-form-grid"><div class="ds-field ds-col-span-2"><label for="manageBizId">사업 선택</label><select id="manageBizId" class="ds-select" onchange="changeManagedBiz('mnpw');"><option value="">사업을 선택하십시오.</option></select></div></div></section>
        <section class="ds-card ds-card-inner">
            <div class="ds-section-head"><div><h2 class="ds-section-title">투입자 등록/수정/삭제</h2><p class="ds-section-desc">내부 사용자ID가 없으면 외부/임시 인력명만 입력해도 됩니다.</p></div>
                <div class="ds-form-actions ds-form-actions-top"><button type="button" class="ds-btn ds-btn-outline" onclick="resetMnpwForm();">초기화</button><button type="button" class="ds-btn ds-btn-primary" onclick="saveBizMnpw();">저장</button></div>
            </div>
            <div class="ds-form-12 ds-mb-20">
                <input type="hidden" id="frmBizMnpwSn">
                <div class="ds-field ds-col-3"><label for="frmUserId">사용자ID</label><input type="text" id="frmUserId" class="ds-input" maxlength="50" placeholder="내부 사용자일 때만 입력"></div>
                <div class="ds-field ds-col-3"><label for="frmInputMnpwNm">투입인력명</label><input type="text" id="frmInputMnpwNm" class="ds-input" maxlength="50"></div>
                <div class="ds-field ds-col-3"><label for="frmInputSeCd">투입구분</label><select id="frmInputSeCd" class="ds-select"><option value="">선택</option></select></div>
                <div class="ds-field ds-col-3"><label for="frmRoleNm">역할</label><input type="text" id="frmRoleNm" class="ds-input" maxlength="100"></div>
                <div class="ds-field ds-col-3"><label for="frmJbpsNm">직위</label><input type="text" id="frmJbpsNm" class="ds-input" maxlength="50"></div>
                <div class="ds-field ds-col-3"><label for="frmInputBgngYmd">투입시작일</label><input type="date" id="frmInputBgngYmd" class="ds-input"></div>
                <div class="ds-field ds-col-3"><label for="frmInputEndYmd">투입종료일</label><input type="date" id="frmInputEndYmd" class="ds-input"></div>
                <div class="ds-field ds-col-3"><label for="frmInputMcnt">M/M</label><input type="number" id="frmInputMcnt" class="ds-input" min="0" step="0.01"></div>
                <div class="ds-field ds-col-3"><label for="frmUntprc">단가</label><input type="number" id="frmUntprc" class="ds-input" min="0" step="1"></div>
            </div>
            <div class="ds-table-wrap"><table class="ds-table ds-table-compact"><thead><tr><th>번호</th><th>투입자</th><th>구분</th><th>역할</th><th>기간</th><th>M/M</th><th>단가</th><th>인건비</th><th>관리</th></tr></thead><tbody id="bizMnpwBody"></tbody></table></div>
        </section>
    </main>
</div>
<script>var ctxPath='${pageContext.request.contextPath}'; var currentBizId=''; var bizPageMode='mnpw';</script>
<script src="${pageContext.request.contextPath}/js/biz/biz.js"></script>
<script>$(function(){ initBizManagePage('mnpw'); });</script>
</body>
</html>
