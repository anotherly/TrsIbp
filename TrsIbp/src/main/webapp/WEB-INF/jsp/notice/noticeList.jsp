<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp"><jsp:param name="dsTitle" value="DevSync - 공지사항"/></jsp:include>
</head>
<body class="ds-body min-h-screen flex">
<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"/>
<div class="flex-grow flex flex-col min-h-screen">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp"><jsp:param name="dsPageTitle" value="공지사항"/></jsp:include>
    <main class="ds-page">
        <div class="ds-breadcrumb">내 업무 &gt; 게시판 &gt; 공지사항</div>
        <div class="ds-page-head">
            <div><h1 class="ds-page-title">공지사항</h1><p class="ds-page-desc">회사 공지와 시스템 운영 공지를 한 게시판에서 확인합니다.</p></div>
            <div class="ds-actions"><button type="button" class="ds-btn ds-btn-primary" data-authority-code="WORK_NOTICE_REG" onclick="openNoticeForm()">+ 회사 공지 등록</button></div>
        </div>
        <section class="ds-card ds-card-inner">
            <div class="ds-search-grid ds-mb-20">
                <div class="ds-field"><label for="noticeSearch">검색</label><input id="noticeSearch" class="ds-input" placeholder="제목/내용 검색"></div>
                <div class="ds-search-actions"><button type="button" class="ds-btn ds-btn-outline" onclick="loadNotices()">검색</button></div>
            </div>
            <div id="noticeRows" class="divide-y divide-brand-border"></div>
        </section>
    </main>
</div>

<div id="noticeModal" class="ds-modal hidden">
    <div class="ds-modal-dim" onclick="closeNotice()"></div>
    <div class="ds-modal-panel" style="width:min(820px,calc(100vw - 48px));overflow-y:auto;">
        <div class="ds-modal-head"><div><h2 id="noticeModalTitle" class="ds-modal-title">공지</h2></div><button type="button" class="ds-modal-close" onclick="closeNotice()">×</button></div>
        <div id="noticeView" class="hidden"></div>
        <form id="noticeForm" class="ds-form-12">
            <input type="hidden" id="noticeSn" name="noticeSn">
            <input type="hidden" id="noticeBgngDt" name="bgngDt">
            <input type="hidden" id="noticeEndDt" name="endDt">
            <div class="ds-field ds-col-12"><label for="noticeTitle">제목</label><input id="noticeTitle" name="noticeTitle" class="ds-input" required></div>
            <div class="ds-field ds-col-12"><label for="noticeCn">내용</label><textarea id="noticeCn" name="noticeCn" class="ds-textarea" rows="10" required></textarea></div>
            <div class="ds-field ds-col-12"><label style="display:flex;align-items:center;gap:8px;margin:0;"><input type="checkbox" id="popupYn" checked> 로그인 후 팝업으로 표시</label></div>
            <div class="ds-col-12 ds-form-actions"><button type="button" class="ds-btn ds-btn-outline" onclick="closeNotice()">취소</button><button type="submit" class="ds-btn ds-btn-primary">저장</button></div>
        </form>
    </div>
</div>
<script>var ctxPath='${pageContext.request.contextPath}';</script>
<script src="${pageContext.request.contextPath}/js/notice.js?v=20261008.1"></script>
</body>
</html>
