<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String dsPageTitle = request.getParameter("dsPageTitle");
    if (dsPageTitle == null || dsPageTitle.trim().isEmpty()) {
        dsPageTitle = "대시보드 홈";
    }
    String dsWorkspace = (String) session.getAttribute("selectedWorkspace");
    if (dsWorkspace == null || dsWorkspace.trim().isEmpty()) dsWorkspace = "work";
    Object dsLoginObject = session.getAttribute("login");
    String dsAuthrtId = dsLoginObject instanceof kr.co.TRSolution.trsIbp.user.vo.UserVO
            ? ((kr.co.TRSolution.trsIbp.user.vo.UserVO) dsLoginObject).getAuthrtId() : "USER";
    boolean dsHasMultipleWorkspaces = "ADMIN".equals(dsAuthrtId) || "MANAGER".equals(dsAuthrtId);
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
        dsWorkspaceDescription = "인사 · 계약 · 회계 · 자산";
        dsWorkspaceIcon = "fa-chart-line";
    }
%>
<header class="h-16 border-b border-brand-border bg-brand-card/30 backdrop-blur-md flex items-center justify-between px-8 sticky top-0 z-20">
    <div class="flex items-center gap-2 text-sm text-gray-400">
        <span>IT 개발사 스마트 포털</span>
        <i class="fa-solid fa-angle-right text-xs"></i>
        <span class="text-gray-100 font-semibold"><%=dsPageTitle%></span>
    </div>

    <% if (dsHasMultipleWorkspaces) { %>
    <details class="ds-workspace-switcher">
        <summary aria-label="업무공간 전환 메뉴 열기">
            <span class="ds-workspace-switcher-icon"><i class="fa-solid <%=dsWorkspaceIcon%>"></i></span>
            <span class="ds-workspace-switcher-copy">
                <strong><%=dsWorkspaceName%></strong>
                <small><%=dsWorkspaceDescription%></small>
            </span>
            <i class="fa-solid fa-chevron-down ds-workspace-switcher-arrow"></i>
        </summary>
        <div class="ds-workspace-switcher-menu">
            <p>업무공간 전환</p>
            <a href="<%=request.getContextPath()%>/main/main.do?workspace=work" class="<%="work".equals(dsWorkspace) ? "is-current" : ""%>">
                <span class="ds-workspace-option-icon"><i class="fa-solid fa-briefcase"></i></span>
                <span><strong>내 업무</strong><small>일정 · 근태 · 개인 업무</small></span>
                <% if ("work".equals(dsWorkspace)) { %><i class="fa-solid fa-check"></i><% } %>
            </a>
            <a href="<%=request.getContextPath()%>/main/main.do?workspace=project" class="<%="project".equals(dsWorkspace) ? "is-current" : ""%>">
                <span class="ds-workspace-option-icon"><i class="fa-solid fa-diagram-project"></i></span>
                <span><strong>프로젝트 관리</strong><small>사업 · 계약 · 원가 · 인력</small></span>
                <% if ("project".equals(dsWorkspace)) { %><i class="fa-solid fa-check"></i><% } %>
            </a>
            <a href="<%=request.getContextPath()%>/main/main.do?workspace=org" class="<%="org".equals(dsWorkspace) ? "is-current" : ""%>">
                <span class="ds-workspace-option-icon"><i class="fa-solid fa-sitemap"></i></span>
                <span><strong>조직 관리</strong><small>조직원 · 근태 · 투입 현황</small></span>
                <% if ("org".equals(dsWorkspace)) { %><i class="fa-solid fa-check"></i><% } %>
            </a>
            <a href="<%=request.getContextPath()%>/main/main.do?workspace=management" class="<%="management".equals(dsWorkspace) ? "is-current" : ""%>">
                <span class="ds-workspace-option-icon"><i class="fa-solid fa-chart-line"></i></span>
                <span><strong>경영 관리</strong><small>인사 · 계약 · 회계 · 자산</small></span>
                <% if ("management".equals(dsWorkspace)) { %><i class="fa-solid fa-check"></i><% } %>
            </a>
        </div>
    </details>
    <% } %>

    <div class="flex items-center gap-6">
        <!-- <div class="hidden lg:flex items-center gap-3 text-xs bg-slate-900 border border-brand-border px-3 py-1.5 rounded-full">
            <span class="flex items-center gap-1.5 text-gray-400">
                <i class="fa-brands fa-github text-gray-100"></i> Github: <span class="text-emerald-400 font-semibold">Connected</span>
            </span>
            <span class="text-gray-700">|</span>
            <span class="flex items-center gap-1.5 text-gray-400">
                <i class="fa-brands fa-jira text-blue-400"></i> Jira: <span class="text-emerald-400 font-semibold">Sync</span>
            </span>
            <span class="text-gray-700">|</span>
            <span class="flex items-center gap-1.5 text-gray-400">
                <i class="fa-brands fa-slack text-orange-400"></i> Slack: <span class="text-emerald-400 font-semibold">Active</span>
            </span>
        </div> -->

        <div class="relative w-64">
            <span class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                <i class="fa-solid fa-magnifying-glass text-gray-500 text-xs"></i>
            </span>
            <input type="text" class="w-full bg-slate-900 border border-brand-border text-xs text-gray-100 rounded-lg pl-9 pr-3 py-2 focus:outline-none focus:border-brand-accent transition" placeholder="프로젝트, 마일스톤, 문서 통합 검색">
        </div>

        <div class="flex items-center gap-2 pl-4 border-l border-brand-border/60">
            <span class="text-xs text-gray-400">
                <i class="fa-solid fa-user-circle text-brand-accent mr-1"></i>
                <strong class="text-gray-200">${not empty sessionScope.login ? sessionScope.login.userNm : '게스트'}</strong>
            </span>
            <a href="<%=request.getContextPath()%>/login/logout.do" class="text-xs text-gray-500 hover:text-red-400 transition px-2 py-1 rounded hover:bg-red-500/10" onclick="return confirm('로그아웃 하시겠습니까?')">
                <i class="fa-solid fa-right-from-bracket"></i>
            </a>
        </div>
    </div>
</header>
