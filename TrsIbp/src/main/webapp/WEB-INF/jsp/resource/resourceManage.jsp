<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html lang="ko"><head><jsp:include page="/WEB-INF/jsp/common/head.jsp"><jsp:param name="dsTitle" value="DevSync - 사무실 자원 관리"/></jsp:include></head>
<body class="ds-body min-h-screen flex"><jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"/><div class="flex-grow flex flex-col min-h-screen"><jsp:include page="/WEB-INF/jsp/common/header.jsp"><jsp:param name="dsPageTitle" value="사무실 자원 관리"/></jsp:include>
<main class="ds-page"><div class="ds-breadcrumb">경영 관리 &gt; 사무실 자원 관리</div><div class="ds-page-head"><div><h1 class="ds-page-title">사무실 자원 관리</h1><p class="ds-page-desc">회의실·차량·IT장비·서버 등 공용 자원과 유형별 부가정보를 관리합니다.</p></div></div>
<section class="ds-card ds-card-inner ds-mb-20">
    <div class="ds-section-head"><div><h2 class="ds-section-title">자원 등록/수정</h2></div><div><button class="ds-btn ds-btn-outline" type="button" onclick="resetResourceForm()">초기화</button> <button class="ds-btn ds-btn-primary" type="button" onclick="saveResource()">저장</button></div></div>
    <input type="hidden" id="resourceSn">
    <div class="ds-resource-primary-grid">
        <div class="ds-field"><label>자원명</label><input id="resourceNm" class="ds-input"></div>
        <div class="ds-field"><label>유형</label><select id="resourceType" class="ds-select"><option value="MEETING_ROOM">회의실</option><option value="VEHICLE">차량</option><option value="IT_DEVICE">IT장비</option><option value="SERVER">서버</option><option value="ETC">기타</option></select></div>
        <div class="ds-field"><label>사용방식</label><select id="useMode" class="ds-select"><option value="TIME">시간예약</option><option value="LOAN">대여</option><option value="ASSIGN">할당</option></select></div>
        <div class="ds-field"><label>예약가능</label><select id="bookableYn" class="ds-select"><option value="Y">가능</option><option value="N">불가</option></select></div>
    </div>
    <div class="ds-resource-secondary-grid">
        <div class="ds-field"><label>위치</label><input id="locationNm" class="ds-input"></div>
        <div class="ds-field"><label>설명</label><input id="resourceExpln" class="ds-input"></div>
    </div>
    <div class="ds-resource-attr-panel">
        <div class="ds-resource-attr-head"><div><strong>부가정보</strong><p>자원별 추가 정보를 항목명과 값으로 관리합니다.</p></div><button type="button" class="ds-btn ds-btn-outline ds-btn-sm" onclick="addResourceAttrRow()"><i class="fa-solid fa-plus"></i> 항목 추가</button></div>
        <div class="ds-resource-attr-table-wrap">
            <table class="ds-resource-attr-table"><thead><tr><th>항목명</th><th>항목값</th><th>관리</th></tr></thead><tbody id="resourceAttrBody"></tbody></table>
        </div>
    </div>
</section>
<section class="ds-card ds-card-inner"><div class="ds-table-wrap"><table class="ds-table"><thead><tr><th>자원명</th><th>유형</th><th>위치</th><th>사용방식</th><th>예약</th><th>부가정보</th><th>관리</th></tr></thead><tbody id="resourceBody"></tbody></table></div></section></main></div>
<script>var ctxPath='${pageContext.request.contextPath}';</script><script src="${pageContext.request.contextPath}/js/resource.js?v=20260921.4"></script><script>$(function(){initResourceManage();});</script></body></html>
