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
        <div class="ds-breadcrumb">프로젝트/사업 &gt; 사업 목록 &gt; 사업 상세</div>
        <div class="ds-page-head">
            <div>
                <h1 class="ds-page-title">사업 상세</h1>
                <p class="ds-page-desc">사업 등록/수정 화면과 동일한 항목으로 사업 기본정보를 조회합니다.</p>
            </div>
            <div class="ds-actions">
                <a href="${pageContext.request.contextPath}/biz/bizList.do" class="ds-btn ds-btn-outline">목록</a>
                <a href="${pageContext.request.contextPath}/biz/bizUpdate.do?bizId=${param.bizId}" class="ds-btn ds-btn-primary">수정</a>
                <button type="button" class="ds-btn ds-btn-danger" onclick="deleteBiz();">삭제</button>
            </div>
        </div>

        <section class="ds-card ds-card-inner ds-mb-20">
            <div class="ds-section-head">
                <div>
                    <h2 class="ds-section-title">사업 기본정보</h2>
                    <p class="ds-section-desc">사업 등록/수정 화면과 동일한 항목으로 조회합니다.</p>
                </div>
            </div>

            <input type="hidden" id="frmBizId" name="bizId" value="${param.bizId}">
            <div class="ds-form-grid biz-basic-form biz-detail-view">
                <div class="ds-field"><label class="required">사업코드</label><p id="dispBizCd" class="ds-display-text"></p></div>
                <div class="ds-field"><label class="required">사업명</label><p id="dispBizNm" class="ds-display-text"></p></div>
                <div class="ds-field"><label class="required">민간/공공</label><p id="dispInstSeNm" class="ds-display-text"></p></div>
                <div class="ds-field"><label class="required">사업종류</label><p id="dispBizKndNm" class="ds-display-text"></p></div>
                <div class="ds-field"><label class="required">사업상태</label><p id="dispBizSttsNm" class="ds-display-text"></p></div>
                <div class="ds-field"><label class="required">사업성격</label><p id="dispBizSeNm" class="ds-display-text"></p></div>
                <div class="ds-field"><label>발주처</label><p id="dispOrdplNm" class="ds-display-text"></p></div>
                <div class="ds-field"><label>계약일</label><p id="dispCtrtYmd" class="ds-display-text"></p></div>
                <div class="ds-field"><label>착수일</label><p id="dispOtstYmd" class="ds-display-text"></p></div>
                <div class="ds-field"><label>사업종료일</label><p id="dispBizEndYmd" class="ds-display-text"></p></div>
                <div class="ds-field"><label>계약금액</label><p id="dispCtrtAmt" class="ds-display-text"></p></div>
                <div class="ds-field"><label>지급방법</label><p id="dispGiveMthdCn" class="ds-display-text"></p></div>
                <div class="ds-field"><label>지급기일</label><p id="dispGiveDdtYmd" class="ds-display-text"></p></div>
                <div class="ds-field"><label>하자보증시작일</label><p id="dispDfrpGrnteBgngYmd" class="ds-display-text"></p></div>
                <div class="ds-field"><label>하자보증종료일</label><p id="dispDfrpGrnteEndYmd" class="ds-display-text"></p></div>
                <div class="ds-field ds-col-span-2"><label>기타사항</label><p id="dispRmrkCn" class="ds-display-text ds-display-textarea"></p></div>
            </div>
        </section>
    </main>
</div>

<script>var ctxPath='${pageContext.request.contextPath}'; var currentBizId='${param.bizId}'; var bizPageMode='detail';</script>
<script src="${pageContext.request.contextPath}/js/biz/biz.js"></script>
<script>$(function(){initBizDetailPage();});</script>
</body>
</html>
