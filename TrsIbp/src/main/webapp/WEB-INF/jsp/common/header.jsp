<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Set" %>
<%
    String dsPageTitle = request.getParameter("dsPageTitle");
    if (dsPageTitle == null || dsPageTitle.trim().isEmpty()) dsPageTitle = "대시보드 홈";
    String dsWorkspace = (String) session.getAttribute("selectedWorkspace");
    if (dsWorkspace == null || dsWorkspace.trim().isEmpty()) dsWorkspace = "work";

    Set<String> dsAllowedWorkspaces = (Set<String>) session.getAttribute("allowedWorkspaces");
    boolean dsAllowWork = dsAllowedWorkspaces == null || dsAllowedWorkspaces.contains("WORK");
    boolean dsAllowProject = dsAllowedWorkspaces != null && dsAllowedWorkspaces.contains("PROJECT");
    boolean dsAllowOrg = dsAllowedWorkspaces != null && dsAllowedWorkspaces.contains("ORG");
    boolean dsAllowManagement = dsAllowedWorkspaces != null && dsAllowedWorkspaces.contains("MANAGEMENT");
    boolean dsHasMultipleWorkspaces = dsAllowedWorkspaces != null && dsAllowedWorkspaces.size() > 1;
    String dsDefaultWorkspace = String.valueOf(session.getAttribute("defaultWorkspaceId"));

    String dsWorkspaceName = "내 업무";
    String dsWorkspaceDescription = "일정 · 근태 · 개인 업무";
    String dsWorkspaceIcon = "fa-briefcase";
    if ("project".equals(dsWorkspace)) {
        dsWorkspaceName = "프로젝트 관리";
        dsWorkspaceDescription = "사업 · 계약 · 원가 · 인력";
        dsWorkspaceIcon = "fa-diagram-project";
    } else if ("org".equals(dsWorkspace)) {
        dsWorkspaceName = "조직 관리";
        dsWorkspaceDescription = "조직원 · 근태 · 투입 현황";
        dsWorkspaceIcon = "fa-sitemap";
    } else if ("management".equals(dsWorkspace)) {
        dsWorkspaceName = "경영 관리";
        dsWorkspaceDescription = "인사 · 계약 · 회계 · 권한";
        dsWorkspaceIcon = "fa-chart-line";
    }
%>
<header class="h-16 border-b border-brand-border bg-brand-card/30 backdrop-blur-md flex items-center justify-between px-8 sticky top-0 z-20">
    <div class="flex items-center gap-2 text-sm text-gray-400">
        <span>IT 개발사 스마트 포털</span><i class="fa-solid fa-angle-right text-xs"></i>
        <span class="text-gray-100 font-semibold"><%=dsPageTitle%></span>
    </div>

    <% if (dsHasMultipleWorkspaces) { %>
    <details class="ds-workspace-switcher">
        <summary aria-label="업무공간 전환 메뉴 열기">
            <span class="ds-workspace-switcher-icon"><i class="fa-solid <%=dsWorkspaceIcon%>"></i></span>
            <span class="ds-workspace-switcher-copy"><strong><%=dsWorkspaceName%></strong><small><%=dsWorkspaceDescription%></small></span>
            <i class="fa-solid fa-chevron-down ds-workspace-switcher-arrow"></i>
        </summary>
        <div class="ds-workspace-switcher-menu">
            <p>업무공간 전환</p>
            <% if (dsAllowWork) { %>
            <a href="<%=request.getContextPath()%>/main/main.do?workspace=work" class="<%="work".equals(dsWorkspace) ? "is-current" : ""%>">
                <span class="ds-workspace-option-icon"><i class="fa-solid fa-briefcase"></i></span>
                <span><strong>내 업무</strong><small>일정 · 근태 · 개인 업무</small></span><% if ("work".equals(dsWorkspace)) { %><i class="fa-solid fa-check"></i><% } %>
            </a>
            <% } %>
            <% if (dsAllowProject) { %>
            <a href="<%=request.getContextPath()%>/main/main.do?workspace=project" class="<%="project".equals(dsWorkspace) ? "is-current" : ""%>">
                <span class="ds-workspace-option-icon"><i class="fa-solid fa-diagram-project"></i></span>
                <span><strong>프로젝트 관리</strong><small>사업 · 계약 · 원가 · 인력</small></span><% if ("project".equals(dsWorkspace)) { %><i class="fa-solid fa-check"></i><% } %>
            </a>
            <% } %>
            <% if (dsAllowOrg) { %>
            <a href="<%=request.getContextPath()%>/main/main.do?workspace=org" class="<%="org".equals(dsWorkspace) ? "is-current" : ""%>">
                <span class="ds-workspace-option-icon"><i class="fa-solid fa-sitemap"></i></span>
                <span><strong>조직 관리</strong><small>조직원 · 근태 · 투입 현황</small></span><% if ("org".equals(dsWorkspace)) { %><i class="fa-solid fa-check"></i><% } %>
            </a>
            <% } %>
            <% if (dsAllowManagement) { %>
            <a href="<%=request.getContextPath()%>/main/main.do?workspace=management" class="<%="management".equals(dsWorkspace) ? "is-current" : ""%>">
                <span class="ds-workspace-option-icon"><i class="fa-solid fa-chart-line"></i></span>
                <span><strong>경영 관리</strong><small>인사 · 계약 · 회계 · 권한</small></span><% if ("management".equals(dsWorkspace)) { %><i class="fa-solid fa-check"></i><% } %>
            </a>
            <% } %>
            <button type="button" class="ds-workspace-default-button" onclick="setDefaultWorkspace('<%=dsWorkspace%>')">
                <i class="<%=dsWorkspace.toUpperCase().equals(dsDefaultWorkspace) ? "fa-solid" : "fa-regular"%> fa-star"></i>
                <span><%=dsWorkspace.toUpperCase().equals(dsDefaultWorkspace) ? "현재 기본 업무공간" : "이 화면을 기본 업무공간으로 설정"%></span>
            </button>
        </div>
    </details>
    <% } %>

    <div class="flex items-center gap-6">
        <%-- 통합검색은 기능 구현 시 다시 활성화한다.
        <div class="relative w-64">
            <span class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none"><i class="fa-solid fa-magnifying-glass text-gray-500 text-xs"></i></span>
            <input type="text" class="w-full bg-slate-900 border border-brand-border text-xs text-gray-100 rounded-lg pl-9 pr-3 py-2 focus:outline-none focus:border-brand-accent transition" placeholder="프로젝트, 일정, 사용자 통합 검색">
        </div>
        --%>
        <div class="flex items-center gap-2 pl-4 border-l border-brand-border/60">
            <a href="<%=request.getContextPath()%>/user/empDetail.do?userId=${sessionScope.login.userId}&selfEdit=true" class="ds-header-user-link" title="내 개인정보·비밀번호 보기"><i class="fa-solid fa-user-circle text-brand-accent mr-1"></i><strong>${not empty sessionScope.login ? sessionScope.login.userNm : '게스트'}</strong></a>
            <a href="<%=request.getContextPath()%>/login/logout.do" class="text-xs text-gray-500 hover:text-red-400 transition px-2 py-1 rounded hover:bg-red-500/10" onclick="return confirm('로그아웃 하시겠습니까?')"><i class="fa-solid fa-right-from-bracket"></i></a>
        </div>
    </div>
</header>
