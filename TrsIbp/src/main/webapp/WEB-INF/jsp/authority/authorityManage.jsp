<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp">
        <jsp:param name="dsTitle" value="DevSync - 역할·권한 관리"/>
    </jsp:include>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/authority/authority.css?v=20261008-scope">
</head>
<body class="ds-body min-h-screen flex">
    <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"/>
    <div class="flex-grow flex flex-col min-h-screen">
        <jsp:include page="/WEB-INF/jsp/common/header.jsp">
            <jsp:param name="dsPageTitle" value="역할·권한 관리"/>
        </jsp:include>
        <main class="ds-authority-page">
            <section class="ds-authority-heading">
                <div>
                    <p class="ds-dashboard-eyebrow">System Settings</p>
                    <h1><i class="fa-solid fa-shield-halved"></i> 역할·권한 관리</h1>
                    <p>역할별 업무공간과 목록·상세·등록·수정·삭제 기능을 설정합니다.</p>
                </div>
                <button type="button" id="btnAuthoritySave" data-authority-code="MANAGEMENT_AUTHRT_SAVE" class="ds-btn ds-btn-primary">
                    <i class="fa-solid fa-floppy-disk"></i> 권한 저장
                </button>
            </section>

            <section class="ds-authority-panel">
                <aside class="ds-authority-roles">
                    <div class="ds-authority-section-head">
                        <strong>사용자 권한</strong>
                        <div>
                            <button type="button" id="btnAuthorityEdit" data-authority-code="MANAGEMENT_AUTHRT_MDFCN" class="ds-text-btn">수정</button>
                            <button type="button" id="btnAuthorityDelete" data-authority-code="MANAGEMENT_AUTHRT_DEL" class="ds-text-btn is-danger">삭제</button>
                        </div>
                    </div>
                    <div id="authorityRoleList" class="ds-authority-role-list"></div>
                    <button type="button" id="btnAuthorityAdd" data-authority-code="MANAGEMENT_AUTHRT_REG" class="ds-authority-add">
                        <i class="fa-solid fa-plus"></i> 신규 권한 추가
                    </button>
                </aside>

                <section class="ds-authority-menus">
                    <div class="ds-authority-menu-head">
                        <div>
                            <strong id="selectedAuthorityName">권한을 선택해 주세요.</strong>
                            <span id="selectedAuthorityCount">0개 기능 허용</span>
                        </div>
                        <label class="ds-check-label">
                            <input type="checkbox" id="checkAllAuthority"> 전체 선택
                        </label>
                    </div>
                    <section class="ds-authority-scope" id="authorityScopePanel" aria-labelledby="authorityScopeTitle">
                        <div class="ds-authority-scope-title">
                            <strong id="authorityScopeTitle"><i class="fa-solid fa-database"></i> 프로젝트 조회 범위</strong>
                            <span>선택한 권한에 적용 · 두 옵션 중 하나만 선택</span>
                        </div>
                        <div class="ds-authority-scope-options">
                            <label class="ds-authority-scope-option">
                                <input type="checkbox" class="authority-scope-check" value="COMPANY" id="scopeCompany">
                                <span><b>전체 프로젝트</b><small>소속 회사의 전체 프로젝트 조회 및 해당 기능 권한 적용</small></span>
                            </label>
                            <label class="ds-authority-scope-option">
                                <input type="checkbox" class="authority-scope-check" value="SELF" id="scopeSelf">
                                <span><b>본인 등록·투입 프로젝트만</b><small>본인이 등록하거나 현재 활성 투입된 프로젝트로 제한</small></span>
                            </label>
                        </div>
                    </section>
                    <div id="authorityMenuList" class="ds-authority-menu-list">
                        <div class="ds-empty">권한 목록을 불러오는 중입니다.</div>
                    </div>
                </section>
            </section>
        </main>
    </div>

    <div id="authorityModal" class="ds-modal-backdrop hidden">
        <section class="ds-modal-panel ds-authority-modal" role="dialog" aria-modal="true" aria-labelledby="authorityModalTitle">
            <div class="ds-modal-header">
                <h2 id="authorityModalTitle">신규 권한 추가</h2>
                <button type="button" id="btnAuthorityModalClose" class="ds-icon-btn"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <form id="authorityForm" class="ds-authority-form">
                <input type="hidden" id="authorityFormMode" value="insert">
                <div class="ds-form-row">
                    <label for="authorityName">권한명 <em>*</em></label>
                    <input type="text" id="authorityName" maxlength="50" placeholder="예: 프로젝트 관리자">
                </div>
                <div class="ds-form-row">
                    <label for="authorityDescription">권한설명</label>
                    <textarea id="authorityDescription" rows="3" maxlength="200"></textarea>
                </div>
                <div class="ds-modal-actions">
                    <button type="button" id="btnAuthorityModalCancel" class="ds-btn ds-btn-outline">취소</button>
                    <button type="submit" class="ds-btn ds-btn-primary">저장</button>
                </div>
            </form>
        </section>
    </div>

    <script>
        var ctxPath = '<%=request.getContextPath()%>';
    </script>
    <script src="<%=request.getContextPath()%>/js/authority/authorityManage.js?v=20261008-scope"></script>
</body>
</html>
