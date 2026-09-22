<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Set" %>
<%
    Object forwardRequestUri = request.getAttribute("javax.servlet.forward.request_uri");
    String uri = forwardRequestUri == null ? request.getRequestURI() : String.valueOf(forwardRequestUri);
    String ctx = request.getContextPath();
    if (ctx != null && ctx.length() > 0 && uri.startsWith(ctx)) uri = uri.substring(ctx.length());

    String workspace = (String) session.getAttribute("selectedWorkspace");
    if (workspace == null || workspace.trim().isEmpty()) workspace = "work";

    Set<String> sidebarWorkspaces = (Set<String>) session.getAttribute("allowedWorkspaces");
    Set<String> sidebarMenus = (Set<String>) session.getAttribute("grantedMenuCodes");
    boolean legacyAdmin = session.getAttribute("login") instanceof kr.co.TRSolution.trsIbp.user.vo.UserVO
            && "ADMIN".equals(((kr.co.TRSolution.trsIbp.user.vo.UserVO) session.getAttribute("login")).getAuthrtId());
    if (sidebarWorkspaces != null && !sidebarWorkspaces.contains(workspace.toUpperCase())) workspace = "work";

    boolean isMain = uri.equals("/main/main.do") || uri.equals("/");
    boolean isSchedule = uri.equals("/schedule/scheduleList.do");
    boolean isBiz = uri.matches("/biz/biz(List|Insert|Detail|Update)\\.do");
    boolean isContract = uri.equals("/biz/contractList.do");
    boolean isAccount = uri.equals("/biz/accountList.do");
    boolean isMnpw = uri.equals("/biz/mnpwList.do");
    boolean isProcess = uri.equals("/biz/schdlList.do");
    boolean isOrgMgmt = uri.equals("/dept/orgList.do");
    boolean isEmpMgmt = uri.startsWith("/user/emp");
    boolean isAuthorityMgmt = uri.startsWith("/authority/");
    boolean isExpense = uri.startsWith("/expense/");
    boolean isWorklog = uri.startsWith("/worklog/");
    boolean isDailyPlan = uri.equals("/worklog/dailyList.do");
    boolean isWeeklyReport = uri.equals("/worklog/weeklyReport.do");
    boolean isNotice = uri.startsWith("/notice/");
    boolean isBoard = uri.startsWith("/board/");
    boolean isOrgAttend = uri.equals("/attend/orgStatus.do");
    boolean isResourceBook = uri.equals("/resource/reservationList.do");
    boolean isResourceManage = uri.equals("/resource/resourceManage.do");

    boolean showSchedule = sidebarMenus == null || sidebarMenus.contains("WORK_SCHEDULE_LIST_SCREEN");
    boolean showBiz = sidebarMenus == null || sidebarMenus.contains("PROJECT_BIZ_LIST_SCREEN");
    boolean showContract = sidebarMenus == null || sidebarMenus.contains("PROJECT_CONTRACT_SCREEN");
    boolean showAccount = sidebarMenus == null || sidebarMenus.contains("PROJECT_ACCOUNT_SCREEN");
    boolean showMnpw = sidebarMenus == null || sidebarMenus.contains("PROJECT_MNPW_SCREEN");
    boolean showProcess = sidebarMenus == null || sidebarMenus.contains("PROJECT_PROCESS_SCREEN");
    boolean showOrgMgmt = legacyAdmin || (sidebarMenus != null && sidebarMenus.contains("MANAGEMENT_ORG_SCREEN"));
    boolean showEmpMgmt = legacyAdmin || (sidebarMenus != null && sidebarMenus.contains("MANAGEMENT_USER_SCREEN"));
    boolean showAuthorityMgmt = legacyAdmin || (sidebarMenus != null && sidebarMenus.contains("MANAGEMENT_AUTHRT_SCREEN"));
    boolean showExpense = sidebarMenus == null || sidebarMenus.contains("WORK_EXPENSE_SCREEN");
    boolean showWorklog = sidebarMenus == null || sidebarMenus.contains("WORK_DAILY_SCREEN") || sidebarMenus.contains("WORK_WEEKLY_REPORT");
    boolean showNotice = sidebarMenus == null || sidebarMenus.contains("WORK_NOTICE_SCREEN");
    boolean showResourceBook = sidebarMenus == null || sidebarMenus.contains("WORK_RESOURCE_BOOK_SCREEN");
    boolean showResourceManage = legacyAdmin || (sidebarMenus != null && sidebarMenus.contains("MANAGEMENT_RESOURCE_SCREEN"));
%>
<aside class="ds-sidebar w-64 bg-slate-950 border-r border-brand-border flex flex-col justify-between h-screen sticky top-0 z-30">
    <div class="ds-sidebar-scroll">
        <div class="ds-brand">
            <a href="<%=ctx%>/main/main.do?workspace=<%=workspace%>" class="flex items-center gap-3">
                <div class="ds-brand-mark"><i class="fa-solid fa-code-merge text-xl"></i></div>
                <div><span class="font-extrabold text-xl text-white tracking-wider">DevSync</span><span class="text-xs block text-cyan-400 font-semibold tracking-widest uppercase">IT Groupware</span></div>
            </a>
        </div>
        <a class="ds-user-card ds-user-card-link" href="<%=ctx%>/user/empDetail.do?userId=${sessionScope.login.userId}" title="내 개인정보·비밀번호 보기">
            <div class="relative shrink-0">
                <img src="<%=ctx%>/common/loginProfileView.do" onerror="this.onerror=null;this.src='<%=ctx%>/images/default-profile.svg';" alt="로그인 사용자 프로필" class="w-10 h-10 rounded-full border border-cyan-400 object-cover bg-slate-800">
                <span class="absolute bottom-0 right-0 w-3 h-3 bg-emerald-500 border-2 border-slate-950 rounded-full"></span>
            </div>
            <div class="flex-grow overflow-hidden">
                <h4 class="font-bold text-sm text-gray-100 truncate">${not empty sessionScope.login ? sessionScope.login.userNm : '게스트'}</h4>
                <span class="text-xs text-gray-400">${not empty sessionScope.login ? sessionScope.login.authrtNm : ''}</span>
            </div>
        </a>

        <nav class="px-4 space-y-1">
            <div class="ds-workspace-caption">
                <i class="fa-solid <%= "project".equals(workspace) ? "fa-diagram-project" : "org".equals(workspace) ? "fa-sitemap" : "management".equals(workspace) ? "fa-chart-line" : "fa-briefcase" %>"></i>
                <span><%= "project".equals(workspace) ? "프로젝트 관리" : "org".equals(workspace) ? "조직 관리" : "management".equals(workspace) ? "경영 관리" : "내 업무" %></span>
            </div>
            <a href="<%=ctx%>/main/main.do?workspace=<%=workspace%>" class="ds-menu-item <%=isMain ? "is-active" : ""%>"><i class="fa-solid fa-house w-5"></i><span>대시보드</span></a>

            <% if ("work".equals(workspace)) { %>
                <% if (showSchedule) { %><a href="<%=ctx%>/schedule/scheduleList.do" class="ds-menu-item <%=isSchedule ? "is-active" : ""%>"><i class="fa-solid fa-calendar-days w-5"></i><span>일정 관리</span></a><% } %>
                <% if (showExpense) { %><a href="<%=ctx%>/expense/expenseList.do" class="ds-menu-item <%=isExpense ? "is-active" : ""%>"><i class="fa-solid fa-receipt w-5"></i><span>비용 청구</span></a><% } %>
                <% if (showWorklog) { %><div class="ds-menu-button <%=isWorklog ? "is-active" : ""%>"><span><i class="fa-solid fa-list-check w-5"></i><span>개인업무 프로세스</span></span><i class="fa-solid fa-chevron-down text-[10px]"></i></div><div class="ds-submenu"><a href="<%=ctx%>/worklog/dailyList.do" class="ds-menu-item <%=isDailyPlan ? "is-active" : ""%>"><i class="fa-regular fa-calendar-check w-5"></i><span>일일 계획</span></a><a href="<%=ctx%>/worklog/weeklyReport.do" class="ds-menu-item <%=isWeeklyReport ? "is-active" : ""%>"><i class="fa-solid fa-file-excel w-5"></i><span>주간보고</span></a></div><% } %>
                <% if (showNotice) { %><div class="ds-menu-button <%=isNotice || isBoard ? "is-active" : ""%>"><span><i class="fa-solid fa-table-list w-5"></i><span>게시판</span></span><i class="fa-solid fa-chevron-down text-[10px]"></i></div><div class="ds-submenu"><a href="<%=ctx%>/board/boardList.do" class="ds-menu-item <%=uri.equals("/board/boardList.do") ? "is-active" : ""%>"><i class="fa-regular fa-message w-5"></i><span>게시판</span></a><a href="<%=ctx%>/notice/noticeList.do" class="ds-menu-item <%=isNotice ? "is-active" : ""%>"><i class="fa-solid fa-bullhorn w-5"></i><span>공지사항</span></a><a href="<%=ctx%>/board/dataList.do" class="ds-menu-item <%=uri.equals("/board/dataList.do") ? "is-active" : ""%>"><i class="fa-solid fa-folder-open w-5"></i><span>자료실</span></a></div><% } %>
                <% if (showResourceBook) { %><a href="<%=ctx%>/resource/reservationList.do" class="ds-menu-item <%=isResourceBook ? "is-active" : ""%>"><i class="fa-solid fa-calendar-check w-5"></i><span>자원 예약</span></a><% } %>
                <%-- TODO 근태 기능 구현 완료 후 메뉴 노출
                <a href="<%=ctx%>/main/main.do?workspace=work" class="ds-menu-item"><i class="fa-solid fa-clock-rotate-left w-5"></i><span>내 근태</span></a>
                --%>
            <% } else if ("project".equals(workspace)) { %>
                <% if (showBiz) { %><a href="<%=ctx%>/biz/bizList.do" class="ds-menu-item <%=isBiz ? "is-active" : ""%>"><i class="fa-solid fa-diagram-project w-5"></i><span>사업 관리</span></a><% } %>
                <% if (showContract) { %><a href="<%=ctx%>/biz/contractList.do" class="ds-menu-item <%=isContract ? "is-active" : ""%>"><i class="fa-solid fa-file-signature w-5"></i><span>계약 관리</span></a><% } %>
                <% if (showAccount) { %><a href="<%=ctx%>/biz/accountList.do" class="ds-menu-item <%=isAccount ? "is-active" : ""%>"><i class="fa-solid fa-coins w-5"></i><span>회계 관리</span></a><% } %>
                <% if (showMnpw) { %><a href="<%=ctx%>/biz/mnpwList.do" class="ds-menu-item <%=isMnpw ? "is-active" : ""%>"><i class="fa-solid fa-people-group w-5"></i><span>투입인력 관리</span></a><% } %>
                <% if (showProcess) { %><a href="<%=ctx%>/biz/schdlList.do" class="ds-menu-item <%=isProcess ? "is-active" : ""%>"><i class="fa-solid fa-list-check w-5"></i><span>프로세스 관리</span></a><% } %>
            <% } else if ("org".equals(workspace)) { %>
                <a href="<%=ctx%>/attend/orgStatus.do" class="ds-menu-item <%=isOrgAttend ? "is-active" : ""%>"><i class="fa-solid fa-users w-5"></i><span>조직원 근태 현황</span></a>
            <% } else if ("management".equals(workspace)) { %>
                <% if (showContract) { %><a href="<%=ctx%>/biz/contractList.do" class="ds-menu-item <%=isContract ? "is-active" : ""%>"><i class="fa-solid fa-file-signature w-5"></i><span>계약 관리</span></a><% } %>
                <% if (showAccount) { %><a href="<%=ctx%>/biz/accountList.do" class="ds-menu-item <%=isAccount ? "is-active" : ""%>"><i class="fa-solid fa-coins w-5"></i><span>회계·손익 관리</span></a><% } %>
                <% if (showOrgMgmt || showEmpMgmt || showAuthorityMgmt) { %><div class="ds-menu-divider"><span>회사 설정</span></div><% } %>
                <% if (showOrgMgmt) { %><a href="<%=ctx%>/dept/orgList.do" class="ds-menu-item <%=isOrgMgmt ? "is-active" : ""%>"><i class="fa-solid fa-sitemap w-5"></i><span>조직 관리</span></a><% } %>
                <% if (showEmpMgmt) { %><a href="<%=ctx%>/user/empList.do" class="ds-menu-item <%=isEmpMgmt ? "is-active" : ""%>"><i class="fa-solid fa-user-gear w-5"></i><span>사용자 관리</span></a><% } %>
                <% if (showAuthorityMgmt) { %><a href="<%=ctx%>/authority/authorityManage.do" class="ds-menu-item <%=isAuthorityMgmt ? "is-active" : ""%>"><i class="fa-solid fa-shield-halved w-5"></i><span>역할·권한 관리</span></a><% } %>
                <% if (showResourceManage) { %><a href="<%=ctx%>/resource/resourceManage.do" class="ds-menu-item <%=isResourceManage ? "is-active" : ""%>"><i class="fa-solid fa-boxes-stacked w-5"></i><span>사무실 자원 관리</span></a><% } %>
            <% } %>

        </nav>
    </div>
    <div class="ds-sidebar-footer">
        <span>Server: <span class="text-emerald-500 font-bold">Stable</span></span>
        <a href="<%=ctx%>/login/logout.do" class="hover:text-red-400 transition" title="로그아웃" onclick="return confirm('로그아웃 하시겠습니까?')"><i class="fa-solid fa-right-from-bracket text-sm"></i></a>
    </div>
</aside>
