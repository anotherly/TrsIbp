<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp"><jsp:param name="dsTitle" value="DevSync - 게시판"/></jsp:include>
</head>
<body class="ds-body min-h-screen flex">
<jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"/>
<div class="flex-grow flex flex-col min-h-screen">
    <jsp:include page="/WEB-INF/jsp/common/header.jsp"><jsp:param name="dsPageTitle" value="게시판"/></jsp:include>
    <main class="ds-page">
        <div class="ds-breadcrumb">내 업무 &gt; 게시판 &gt; 게시판</div>
        <div class="ds-page-head">
            <div>
                <h1 class="ds-page-title">게시판</h1>
                <p class="ds-page-desc">회사 구성원이 자유롭게 글과 업무 자료를 공유합니다. 게시글은 공지 팝업으로 노출되지 않습니다.</p>
            </div>
            <div class="ds-actions"><button type="button" class="ds-btn ds-btn-primary" onclick="openBoardForm();">+ 글 등록</button></div>
        </div>

        <section class="ds-card ds-card-inner">
            <div class="ds-search-grid ds-mb-20">
                <div class="ds-field">
                    <label for="boardSearch">검색</label>
                    <input id="boardSearch" class="ds-input" placeholder="제목, 내용, 작성자 검색" onkeydown="if(event.key==='Enter'){event.preventDefault();loadBoards();}">
                </div>
                <div class="ds-search-actions"><button type="button" class="ds-btn ds-btn-outline" onclick="loadBoards();">검색</button></div>
            </div>
            <div class="overflow-x-auto">
                <table class="ds-table ds-board-table">
                    <thead><tr><th style="width:90px">번호</th><th>제목</th><th style="width:160px">작성자</th><th style="width:90px">첨부</th><th style="width:170px">등록일</th></tr></thead>
                    <tbody id="boardRows"><tr><td colspan="5" class="ds-empty">게시글을 조회하는 중입니다.</td></tr></tbody>
                </table>
            </div>
        </section>
    </main>
</div>

<div id="boardModal" class="ds-modal hidden" aria-hidden="true">
    <div class="ds-modal-dim" onclick="closeBoardModal();"></div>
    <div class="ds-modal-panel" style="width:min(900px,calc(100vw - 48px));max-height:calc(100vh - 48px);overflow-y:auto;">
        <div class="ds-modal-head">
            <div><h2 id="boardModalTitle" class="ds-modal-title">게시글</h2><p id="boardModalDesc" class="ds-modal-desc"></p></div>
            <button type="button" class="ds-modal-close" onclick="closeBoardModal();" title="닫기">×</button>
        </div>

        <div id="boardView" class="hidden">
            <div id="boardViewMeta" class="ds-board-view-meta"></div>
            <div id="boardViewContent" class="ds-board-view-content"></div>
            <div class="ds-field ds-mt-20"><label>첨부파일</label><div id="boardViewFiles" class="ds-file-list"></div></div>
            <div id="boardViewActions" class="ds-form-actions"></div>
        </div>

        <form id="boardForm" class="ds-form-12" enctype="multipart/form-data">
            <input type="hidden" id="boardSn" name="boardSn">
            <input type="hidden" id="deleteFileSns" name="deleteFileSns">
            <div class="ds-field ds-col-12"><label class="required" for="boardTitle">제목</label><input id="boardTitle" name="boardTitle" class="ds-input" maxlength="300" required></div>
            <div class="ds-field ds-col-12"><label class="required" for="boardCn">내용</label><textarea id="boardCn" name="boardCn" class="ds-textarea" rows="12" maxlength="10000" required></textarea></div>
            <div class="ds-field ds-col-12">
                <label for="boardFiles">첨부파일</label>
                <div class="ds-file-upload-box">
                    <div class="ds-upload-toolbar">
                        <input type="file" id="boardFiles" name="boardFiles" class="ds-file-input-hidden" multiple>
                        <button type="button" class="ds-btn ds-btn-outline" onclick="document.getElementById('boardFiles').click();"><i class="fa-solid fa-paperclip"></i> 파일 선택</button>
                        <span id="boardFileSummary" class="ds-upload-file-summary">선택된 파일 없음</span>
                    </div>
                    <p class="ds-field-help">기존 파일 포함 최대 10개 · 파일당 10MB 이하</p>
                    <div id="boardExistingFiles" class="ds-file-list"></div>
                    <div id="boardSelectedFiles" class="ds-file-list"></div>
                </div>
            </div>
            <div class="ds-col-12 ds-form-actions">
                <button type="button" class="ds-btn ds-btn-outline" onclick="closeBoardModal();">취소</button>
                <button type="submit" class="ds-btn ds-btn-primary">저장</button>
            </div>
        </form>
    </div>
</div>

<script>var ctxPath='${pageContext.request.contextPath}';</script>
<script src="${pageContext.request.contextPath}/js/board.js?v=20260922.1"></script>
</body>
</html>
