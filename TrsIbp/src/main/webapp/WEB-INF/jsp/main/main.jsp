<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp">
        <jsp:param name="dsTitle" value="DevSync - IT 개발사 스마트 대시보드"/>
    </jsp:include>
</head>
<body class="ds-body min-h-screen flex">
    <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"/>
    <c:set var="workspace" value="${empty requestScope.selectedWorkspace ? 'work' : requestScope.selectedWorkspace}"/>
    <div class="flex-grow flex flex-col min-h-screen">
        <jsp:include page="/WEB-INF/jsp/common/header.jsp">
            <jsp:param name="dsPageTitle" value="대시보드 홈"/>
        </jsp:include>
        <main class="flex-grow p-8 space-y-6 max-w-7xl mx-auto w-full">
            <c:choose>
                <c:when test="${workspace eq 'project'}">
                    <jsp:include page="/WEB-INF/jsp/main/projectDashboard.jsp"/>
                </c:when>
                <c:when test="${workspace eq 'org'}">
                    <jsp:include page="/WEB-INF/jsp/main/orgDashboard.jsp"/>
                </c:when>
                <c:when test="${workspace eq 'management'}">
                    <jsp:include page="/WEB-INF/jsp/main/managementDashboard.jsp"/>
                </c:when>
                <c:otherwise>
                    <jsp:include page="/WEB-INF/jsp/main/workDashboard.jsp"/>
                </c:otherwise>
            </c:choose>
        </main>
    </div>


    <div id="dashboardNoticeModal" class="ds-modal hidden" style="z-index:1200;">
        <div class="ds-modal-panel max-w-2xl ds-dashboard-notice-modal">
            <div class="ds-modal-head ds-dashboard-notice-head"><div><span id="dashboardNoticeBadge" class="text-xs"></span><h2 id="dashboardNoticeTitle" class="mt-1">공지사항</h2></div><button type="button" onclick="closeDashboardNotice(false)">×</button></div>
            <div class="p-6 ds-dashboard-notice-scroll"><div id="dashboardNoticeMeta" class="text-xs text-gray-500 mb-4"></div><div id="dashboardNoticeContent" class="whitespace-pre-wrap leading-7"></div></div>
            <div class="p-4 border-t border-brand-border flex justify-between items-center ds-dashboard-notice-footer"><label class="text-sm text-gray-400 flex items-center gap-2"><input type="checkbox" id="dashboardNoticeDontShow"> 다시 보지 않음</label><button type="button" class="ds-btn ds-btn-primary" onclick="closeDashboardNotice(true)">확인</button></div>
        </div>
    </div>

    <script>var ctxPath = '<%=request.getContextPath()%>';</script>
    <script src="<%=request.getContextPath()%>/js/dashboard.js?v=20260922.1"></script>
    <c:if test="${workspace eq 'work'}">
        <script src="<%=request.getContextPath()%>/js/comm/userSelectModal.js"></script>
        <script src="<%=request.getContextPath()%>/js/schedule/schedule.js?v=20260922.1"></script>
        <script>
            $(function() {
                if (typeof initDashboardScheduleWidget === 'function') {
                    initDashboardScheduleWidget();
                }
            });
        </script>
    </c:if>

    <script>
    var dashboardNoticeQueue = [], dashboardNoticeCurrent = null;
    function escNotice(v){ return $('<div>').text(v == null ? '' : v).html(); }
    function loadDashboardNoticePopup(){
        $.getJSON(ctxPath + '/notice/popupList.ajax', function(r){
            var list = (r && r.list) || [];
            dashboardNoticeQueue = list.filter(function(n){ return localStorage.getItem('trs_notice_dismiss_' + n.noticeSn) !== 'Y'; });
            showNextDashboardNotice();
        });
    }
    function showNextDashboardNotice(){
        dashboardNoticeCurrent = dashboardNoticeQueue.shift();
        if(!dashboardNoticeCurrent){ $('#dashboardNoticeModal').addClass('hidden'); return; }
        var n = dashboardNoticeCurrent;
        $('#dashboardNoticeBadge').text(n.noticeScopeCd === 'SYSTEM' ? '시스템 공지' : '회사 공지');
        $('#dashboardNoticeTitle').text(n.noticeTitle || '공지사항');
        $('#dashboardNoticeMeta').text((n.rgtrNm || n.rgtrId || '') + (n.regDt ? ' · ' + n.regDt : ''));
        $('#dashboardNoticeContent').text(window.decodeStoredText ? window.decodeStoredText(n.noticeCn || '') : (n.noticeCn || ''));
        $('#dashboardNoticeDontShow').prop('checked', false);
        $('#dashboardNoticeModal').removeClass('hidden');
    }
    function closeDashboardNotice(next){
        if(dashboardNoticeCurrent && $('#dashboardNoticeDontShow').prop('checked')) localStorage.setItem('trs_notice_dismiss_' + dashboardNoticeCurrent.noticeSn, 'Y');
        $('#dashboardNoticeModal').addClass('hidden');
        if(next) showNextDashboardNotice();
    }
    $(function(){ loadDashboardNoticePopup(); });
    </script>

    <c:if test="${param.authDenied eq 'Y'}">
        <script>$(function(){ if (typeof showToast === 'function') showToast('해당 화면을 사용할 권한이 없습니다.', 'error'); });</script>
    </c:if>
</body>
</html>
