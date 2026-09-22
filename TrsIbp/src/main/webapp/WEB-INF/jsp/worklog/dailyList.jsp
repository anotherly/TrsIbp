<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp"><jsp:param name="dsTitle" value="DevSync - 일일 계획"/></jsp:include>
</head>
<body class="ds-body min-h-screen flex">
<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"/>
<div class="flex-grow flex flex-col min-h-screen">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp"><jsp:param name="dsPageTitle" value="일일 계획"/></jsp:include>
    <main class="ds-page">
        <div class="ds-breadcrumb">내 업무 &gt; 개인업무 프로세스 &gt; 일일 계획</div>
        <div class="ds-page-head">
            <div><h1 class="ds-page-title">일일 계획</h1><p class="ds-page-desc">업무별 우선순위와 예상완료일을 잡고, 여러 날 이어지는 업무는 매일 진행률만 갱신합니다.</p></div>
            <div class="ds-actions"><a class="ds-btn ds-btn-outline" href="${pageContext.request.contextPath}/worklog/weeklyReport.do">주간보고 보기</a></div>
        </div>
        <section class="ds-card ds-card-inner">
            <div class="ds-form-12 ds-mb-20">
                <div class="ds-field ds-col-3"><label for="workYmd">업무일자</label><input type="date" id="workYmd" class="ds-input"></div>
                <div class="ds-col-9 ds-form-actions"><button type="button" class="ds-btn ds-btn-outline" onclick="loadDaily()">조회</button><button type="button" class="ds-btn ds-btn-primary" onclick="addRow()">+ 업무 추가</button></div>
            </div>
            <div id="dailyRows" class="space-y-3"></div>
        </section>
    </main>
</div>
<script>var ctxPath='${pageContext.request.contextPath}';</script>
<script src="${pageContext.request.contextPath}/js/worklog.js?v=20260921.5"></script>
</body>
</html>
