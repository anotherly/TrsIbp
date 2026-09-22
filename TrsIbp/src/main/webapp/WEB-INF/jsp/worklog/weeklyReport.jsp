<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp"><jsp:param name="dsTitle" value="DevSync - 주간보고"/></jsp:include>
</head>
<body class="ds-body min-h-screen flex">
<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"/>
<div class="flex-grow flex flex-col min-h-screen">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp"><jsp:param name="dsPageTitle" value="주간보고"/></jsp:include>
    <main class="ds-page">
        <div class="ds-breadcrumb">내 업무 &gt; 개인업무 프로세스 &gt; 주간보고</div>
        <div class="ds-page-head">
            <div><h1 class="ds-page-title">주간보고</h1><p class="ds-page-desc">월~금 일간업무를 여러 프로젝트 기준으로 한 파일에 묶어 출력합니다.</p></div>
            <div class="ds-actions"><button type="button" class="ds-btn ds-btn-primary" onclick="downloadWeekly()"><i class="fa-solid fa-file-excel"></i> 엑셀 다운로드</button></div>
        </div>
        <section class="ds-card ds-card-inner">
            <div class="ds-form-12 ds-mb-20">
                <div class="ds-field ds-col-3"><label for="weekStart">주 시작일(월)</label><input id="weekStart" type="date" class="ds-input"></div>
                <div class="ds-col-9 ds-form-actions"><button type="button" class="ds-btn ds-btn-outline" onclick="loadWeekly()">조회</button></div>
            </div>
            <div id="weeklyRows" class="space-y-4"></div>
        </section>
    </main>
</div>
<script>var ctxPath='${pageContext.request.contextPath}';</script>
<script src="${pageContext.request.contextPath}/js/worklog.js?v=20260921.5"></script>
</body>
</html>
