<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp">
        <jsp:param name="dsTitle" value="DevSync - 비용 청구"/>
    </jsp:include>
</head>
<body class="ds-body min-h-screen flex">
<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"/>
<div class="flex-grow flex flex-col min-h-screen">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp">
        <jsp:param name="dsPageTitle" value="비용 청구"/>
    </jsp:include>
    <main class="ds-page">
        <div class="ds-breadcrumb">내 업무 &gt; 비용 청구</div>
        <div class="ds-page-head">
            <div>
                <h1 class="ds-page-title">비용 청구</h1>
                <p class="ds-page-desc">개인카드 등으로 지출한 프로젝트 비용을 등록하고 영수증·매출전표를 첨부합니다. 등록 즉시 프로젝트 손익에 반영됩니다.</p>
            </div>
            <div class="ds-actions">
                <button type="button" class="ds-btn ds-btn-primary" data-authority-code="WORK_EXPENSE_REG" onclick="openExpenseForm()">+ 비용 등록</button>
            </div>
        </div>

        <section class="ds-card ds-card-inner">
            <div class="ds-search-grid ds-mb-20">
                <div class="ds-field">
                    <label for="expenseSearch">검색</label>
                    <input id="expenseSearch" class="ds-input" placeholder="프로젝트/비용명/사용처 검색">
                </div>
                <div class="ds-search-actions">
                    <button type="button" class="ds-btn ds-btn-outline" onclick="loadExpenses()">검색</button>
                </div>
            </div>
            <div class="ds-table-wrap">
                <table class="ds-table">
                    <thead><tr><th>사용일</th><th>프로젝트</th><th>구분</th><th>비용명</th><th>사용처</th><th>금액</th><th>작성자</th><th>증빙</th><th>관리</th></tr></thead>
                    <tbody id="expenseBody"></tbody>
                </table>
            </div>
        </section>
    </main>
</div>

<div id="expenseModal" class="ds-modal hidden">
    <div class="ds-modal-dim" onclick="closeExpenseForm()"></div>
    <div class="ds-modal-panel" style="width:min(860px,calc(100vw - 48px));overflow-y:auto;">
        <div class="ds-modal-head">
            <div><h2 class="ds-modal-title">비용 청구 등록/수정</h2><p class="ds-modal-desc">프로젝트 비용과 증빙자료를 함께 등록합니다.</p></div>
            <button type="button" class="ds-modal-close" onclick="closeExpenseForm()">×</button>
        </div>
        <form id="expenseForm" enctype="multipart/form-data" class="ds-form-12">
            <input type="hidden" name="claimSn" id="claimSn">
            <div class="ds-field ds-col-12"><label for="expBizId">프로젝트</label><select name="bizId" id="expBizId" class="ds-select" required></select></div>
            <div class="ds-field ds-col-3"><label for="expUseYmd">사용일</label><input type="date" name="useYmd" id="expUseYmd" class="ds-input" required></div>
            <div class="ds-field ds-col-3"><label for="expSe">비용구분</label><select name="expnsSeCd" id="expSe" class="ds-select"><option value="LODGING">숙박</option><option value="SUPPLY">물품</option><option value="MEAL">식비</option><option value="TRANSPORT">교통</option><option value="FUEL">유류</option><option value="ETC">기타</option></select></div>
            <div class="ds-field ds-col-3"><label for="expPay">결제수단</label><select name="pmtMthdCd" id="expPay" class="ds-select"><option value="PERSONAL_CARD">개인카드</option><option value="CORP_CARD">법인카드</option><option value="CASH">현금</option><option value="ETC">기타</option></select></div>
            <div id="expCardLast4Field" class="ds-field ds-col-3"><label for="expCardLast4">카드 뒷번호 4자리</label><input type="text" name="cardLast4" id="expCardLast4" class="ds-input" maxlength="4" inputmode="numeric" pattern="[0-9]{4}" placeholder="예: 1234"></div>
            <div class="ds-field ds-col-4"><label for="expAmt">금액</label><input type="number" name="claimAmt" id="expAmt" min="1" class="ds-input" required></div>
            <div class="ds-field ds-col-4"><label for="expNm">비용명</label><input name="expnsNm" id="expNm" class="ds-input" required></div>
            <div class="ds-field ds-col-4"><label for="expMerchant">사용처</label><input name="merchantNm" id="expMerchant" class="ds-input"></div>
            <div class="ds-field ds-col-12"><label for="expRmrk">비고</label><textarea name="rmrkCn" id="expRmrk" class="ds-textarea" rows="3"></textarea></div>
            <div class="ds-field ds-col-12"><label for="expFiles">영수증/매출전표</label><input type="file" name="files" id="expFiles" class="ds-input" multiple accept="image/*,.pdf"></div>
            <div id="expenseExistingFiles" class="ds-col-12"></div>
            <div class="ds-col-12 ds-form-actions"><button type="button" class="ds-btn ds-btn-outline" onclick="closeExpenseForm()">취소</button><button type="submit" class="ds-btn ds-btn-primary">저장</button></div>
        </form>
    </div>
</div>
<script>var ctxPath='${pageContext.request.contextPath}';</script>
<script src="${pageContext.request.contextPath}/js/expense.js?v=20260921.5"></script>
</body>
</html>
