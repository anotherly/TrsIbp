<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head><jsp:include page="/WEB-INF/jsp/common/head.jsp"><jsp:param name="dsTitle" value="DevSync - 사용자 상세"/></jsp:include></head>
<body class="ds-body min-h-screen flex">
<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"/>
<div class="flex-grow flex flex-col min-h-screen">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp"><jsp:param name="dsPageTitle" value="사용자 상세"/></jsp:include>
    <main class="ds-page">
        <div class="ds-breadcrumb">사용자(직원) 관리 &gt; 상세</div>
        <div class="ds-page-head"><div><h1 class="ds-page-title">사용자 상세</h1><p class="ds-page-desc">직원 계정 정보를 조회합니다.</p></div><div class="ds-actions"><button type="button" class="ds-btn ds-btn-outline" onclick="goEmpList();">목록</button><button type="button" class="ds-btn ds-btn-outline" onclick="deleteEmp('${userId}');">삭제</button><button type="button" class="ds-btn ds-btn-primary" onclick="goEmpUpdate('${userId}');">수정</button></div></div>
        <section class="ds-card ds-card-inner">
            <div class="ds-section-head"><div><h2 class="ds-section-title">기본 정보</h2><p class="ds-section-desc">사용자 정보는 상세 화면에서 수정되지 않습니다.</p></div></div>
            <div class="ds-form-12">
                <div class="ds-field ds-col-6"><label>사용자ID</label><p id="dispUserId" class="ds-display-text"></p></div>
                <div class="ds-field ds-col-6"><label>사용자명</label><p id="dispUserNm" class="ds-display-text"></p></div>
                <div class="ds-field ds-col-4"><label>회사</label><p id="dispCoNm" class="ds-display-text"></p></div>
                <div class="ds-field ds-col-4"><label>부서</label><p id="dispDeptNm" class="ds-display-text"></p></div>
                <div class="ds-field ds-col-4"><label>직위</label><p id="dispJbpsNm" class="ds-display-text"></p></div>
                <div class="ds-field ds-col-4"><label>권한</label><p id="dispAuthrtNm" class="ds-display-text"></p></div>
                <div class="ds-field ds-col-4"><label>전화번호</label><p id="dispUserTelno" class="ds-display-text"></p></div>
                <div class="ds-field ds-col-4"><label>사용여부</label><p id="dispUseYn" class="ds-display-text"></p></div>
                <div class="ds-field ds-col-4"><label>등록일</label><p id="dispRegDt" class="ds-display-text"></p></div>
                <div class="ds-field ds-col-12"><label>메모</label><p id="dispMemoCn" class="ds-display-text ds-display-textarea"></p></div>
            </div>
        </section>
    </main>
</div>
<script src="<%=request.getContextPath()%>/js/user/userManage.js"></script>
<script>$(function(){ initEmpDetailPage('${userId}'); });</script>
</body>
</html>
