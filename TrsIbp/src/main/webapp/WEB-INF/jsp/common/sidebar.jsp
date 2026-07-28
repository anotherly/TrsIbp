<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    Object forwardRequestUri = request.getAttribute("javax.servlet.forward.request_uri");
    String uri = forwardRequestUri == null ? request.getRequestURI() : String.valueOf(forwardRequestUri);
    String ctx = request.getContextPath();
    if (ctx != null && ctx.length() > 0 && uri.startsWith(ctx)) {
        uri = uri.substring(ctx.length());
    }
    String workspace = (String) session.getAttribute("selectedWorkspace");
    if (workspace == null || workspace.trim().isEmpty()) {
        workspace = "work";
    }
    Object loginObject = session.getAttribute("login");
    String authrtId = loginObject instanceof kr.co.TRSolution.trsIbp.user.vo.UserVO
            ? ((kr.co.TRSolution.trsIbp.user.vo.UserVO) loginObject).getAuthrtId() : "USER";
    boolean isAdmin = "ADMIN".equals(authrtId);
    boolean isManager = isAdmin || "MANAGER".equals(authrtId);
    if (!isManager) {
        workspace = "work";
    }
    boolean isMain = uri.equals("/main/main.do") || uri.equals("/");
    boolean isSchedule = uri.equals("/schedule/scheduleList.do");
    boolean isAttend = uri.startsWith("/attend/");
    boolean isBizList = uri.matches("/biz/biz(List|Insert|Detail|Update)\\.do");
    boolean isContract = uri.equals("/biz/contractList.do");
    boolean isAccount = uri.equals("/biz/accountList.do");
    boolean isMnpw = uri.equals("/biz/mnpwList.do");
    boolean isSchdl = uri.equals("/biz/schdlList.do");
    boolean isOrgMgmt = uri.equals("/dept/orgList.do");
    boolean isEmpMgmt = uri.matches("/user/emp(List|Insert|Detail|Update)\\.do");
%>
<aside class="ds-sidebar w-64 bg-slate-950 border-r border-brand-border flex flex-col justify-between h-screen sticky top-0 z-30">
    <div class="ds-sidebar-scroll">
        <div class="ds-brand">
            <a href="<%=ctx%>/main/main.do?workspace=<%=workspace%>" class="flex items-center gap-3">
                <div class="ds-brand-mark"><i class="fa-solid fa-code-merge text-xl"></i></div>
                <div>
                    <span class="font-extrabold text-xl text-white tracking-wider">DevSync</span>
                    <span class="text-xs block text-cyan-400 font-semibold tracking-widest uppercase">IT Groupware</span>
                </div>
            </a>
        </div>

        <div class="ds-user-card">
            <div class="relative shrink-0">
                <img src="<%=ctx%>/common/loginProfileView.do" onerror="this.onerror=null;this.src='<%=ctx%>/images/default-profile.svg';" alt="로그인 사용자 프로필" class="w-10 h-10 rounded-full border border-cyan-400 object-cover bg-slate-800">
                <span class="absolute bottom-0 right-0 w-3 h-3 bg-emerald-500 border-2 border-slate-950 rounded-full"></span>
            </div>
            <div class="flex-grow overflow-hidden">
                <h4 class="font-bold text-sm text-gray-100 truncate">${not empty sessionScope.login ? sessionScope.login.userNm : '게스트'}</h4>
                <span class="text-xs text-gray-400">${not empty sessionScope.login ? sessionScope.login.authrtNm : ''}</span>
            </div>
        </div>

        <nav class="px-4 space-y-1">
            <div class="ds-workspace-caption">
                <i class="fa-solid <%= "project".equals(workspace) ? "fa-diagram-project" : "org".equals(workspace) ? "fa-sitemap" : "management".equals(workspace) ? "fa-chart-line" : "fa-briefcase" %>"></i>
                <span><%= "project".equals(workspace) ? "프로젝트 관리" : "org".equals(workspace) ? "조직 관리" : "management".equals(workspace) ? "경영 관리" : "내 업무" %></span>
            </div>

            <a href="<%=ctx%>/main/main.do?workspace=<%=workspace%>" class="ds-menu-item <%=isMain ? "is-active" : ""%>">
                <i class="fa-solid fa-house w-5"></i><span>대시보드</span>
            </a>

            <% if ("work".equals(workspace)) { %>
                <a href="<%=ctx%>/schedule/scheduleList.do" class="ds-menu-item <%=isSchedule ? "is-active" : ""%>">
                    <i class="fa-solid fa-calendar-days w-5"></i><span>일정 관리</span>
                </a>
                <button type="button" onclick="toggleSubmenu('sub-attend')" class="ds-menu-button <%=isAttend ? "is-active" : ""%>">
                    <span><i class="fa-solid fa-clock-rotate-left w-5"></i><span>근태 관리</span></span>
                    <i id="arrow-sub-attend" class="fa-solid fa-chevron-down text-xs"></i>
                </button>
                <div id="sub-attend" class="<%=isAttend ? "" : "hidden"%> ds-submenu">
                    <a href="#" class="ds-sidebar-link">내 근태</a>
                </div>
            <% } else if ("project".equals(workspace) && isManager) { %>
                <button type="button" onclick="toggleSubmenu('sub-project')" class="ds-menu-button <%=uri.startsWith("/biz/") ? "is-active" : ""%>">
                    <span><i class="fa-solid fa-diagram-project w-5"></i><span>프로젝트·사업 관리</span></span>
                    <i id="arrow-sub-project" class="fa-solid fa-chevron-down text-xs"></i>
                </button>
                <div id="sub-project" class="<%=uri.startsWith("/biz/") ? "" : "hidden"%> ds-submenu">
                    <a href="<%=ctx%>/biz/bizList.do" class="ds-sidebar-link <%=isBizList ? "is-active" : ""%>">사업 관리</a>
                    <a href="<%=ctx%>/biz/contractList.do" class="ds-sidebar-link <%=isContract ? "is-active" : ""%>">계약 관리</a>
                    <a href="<%=ctx%>/biz/accountList.do" class="ds-sidebar-link <%=isAccount ? "is-active" : ""%>">회계 관리</a>
                    <a href="<%=ctx%>/biz/mnpwList.do" class="ds-sidebar-link <%=isMnpw ? "is-active" : ""%>">투입인력 관리</a>
                    <a href="<%=ctx%>/biz/schdlList.do" class="ds-sidebar-link <%=isSchdl ? "is-active" : ""%>">프로세스 관리</a>
                </div>
            <% } else if ("org".equals(workspace) && isManager) { %>
                <a href="#" class="ds-menu-item"><i class="fa-solid fa-users w-5"></i><span>조직원 현황</span></a>
                <a href="#" class="ds-menu-item"><i class="fa-solid fa-calendar-check w-5"></i><span>근태·휴가 현황</span></a>
                <a href="#" class="ds-menu-item"><i class="fa-solid fa-chart-pie w-5"></i><span>프로젝트 투입 현황</span></a>
                <a href="#" class="ds-menu-item"><i class="fa-solid fa-list-check w-5"></i><span>업무 진행 현황</span></a>
                <a href="#" class="ds-menu-item"><i class="fa-solid fa-calendar-week w-5"></i><span>조직 일정</span></a>
            <% } else if ("management".equals(workspace) && isManager) { %>
                <a href="#" class="ds-menu-item"><i class="fa-solid fa-id-card w-5"></i><span>인사 관리</span></a>
                <a href="#" class="ds-menu-item"><i class="fa-solid fa-calendar-minus w-5"></i><span>근태·연차 관리</span></a>
                <a href="<%=ctx%>/biz/contractList.do" class="ds-menu-item <%=isContract ? "is-active" : ""%>"><i class="fa-solid fa-file-signature w-5"></i><span>계약 관리</span></a>
                <a href="<%=ctx%>/biz/accountList.do" class="ds-menu-item <%=isAccount ? "is-active" : ""%>"><i class="fa-solid fa-coins w-5"></i><span>회계·손익 관리</span></a>
                <a href="#" class="ds-menu-item"><i class="fa-solid fa-cart-shopping w-5"></i><span>구매·자산 관리</span></a>
                <% if (isAdmin) { %>
                    <div class="ds-menu-divider"><span>회사 최고관리자</span></div>
                    <a href="<%=ctx%>/dept/orgList.do" class="ds-menu-item <%=isOrgMgmt ? "is-active" : ""%>"><i class="fa-solid fa-sitemap w-5"></i><span>조직 관리</span></a>
                    <a href="<%=ctx%>/user/empList.do" class="ds-menu-item <%=isEmpMgmt ? "is-active" : ""%>"><i class="fa-solid fa-user-gear w-5"></i><span>사용자 관리</span></a>
                    <a href="#" class="ds-menu-item"><i class="fa-solid fa-shield-halved w-5"></i><span>역할·권한 관리</span></a>
                <% } %>
            <% } %>

            <div class="ds-menu-divider"><span>공통</span></div>
            <% if (isManager) { %>
                <a href="<%=ctx%>/main/main.do?workspace=work" class="ds-menu-item"><i class="fa-solid fa-repeat w-5"></i><span>기본 업무공간</span></a>
            <% } %>
            <a href="<%=ctx%>/user/empDetail.do?userId=${sessionScope.login.userId}" class="ds-menu-item"><i class="fa-solid fa-user-lock w-5"></i><span>개인정보·비밀번호</span></a>
        </nav>
    </div>

    <div class="ds-sidebar-footer">
        <span>Server: <span class="text-emerald-500 font-bold">Stable</span></span>
        <a href="<%=ctx%>/login/logout.do" class="hover:text-red-400 transition" title="로그아웃" onclick="return confirm('로그아웃 하시겠습니까?')"><i class="fa-solid fa-right-from-bracket text-sm"></i></a>
    </div>
</aside>
