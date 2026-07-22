<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    Object forwardRequestUri = request.getAttribute("javax.servlet.forward.request_uri");
    String uri = forwardRequestUri == null ? request.getRequestURI() : String.valueOf(forwardRequestUri);
    String ctx = request.getContextPath();
    if (ctx != null && ctx.length() > 0 && uri.startsWith(ctx)) {
        uri = uri.substring(ctx.length());
    }
    boolean isBizList = uri.equals("/biz/bizList.do") || uri.equals("/biz/bizInsert.do") || uri.equals("/biz/bizDetail.do") || uri.equals("/biz/bizUpdate.do");
    boolean isContract = uri.equals("/biz/contractList.do");
    boolean isAccount = uri.equals("/biz/accountList.do");
    boolean isMnpw = uri.equals("/biz/mnpwList.do");
    boolean isSchdl = uri.equals("/biz/schdlList.do");
    boolean isOrgMgmt = uri.equals("/dept/orgList.do");
    boolean isEmpMgmt = uri.equals("/user/empList.do") || uri.equals("/user/empInsert.do") || uri.equals("/user/empDetail.do") || uri.equals("/user/empUpdate.do");
    boolean isCompanyMgmt = isOrgMgmt || isEmpMgmt;
    boolean isSchedule = uri.equals("/schedule/scheduleList.do");
    boolean isProject = uri.startsWith("/biz/") && uri.endsWith(".do");
%>
<aside class="ds-sidebar w-64 bg-slate-950 border-r border-brand-border flex flex-col justify-between h-screen sticky top-0 z-30">
    <div class="ds-sidebar-scroll">
        <div class="p-6 border-b border-brand-border flex items-center justify-between">
            <a href="<%=request.getContextPath()%>/main/main.do" class="flex items-center gap-3">
                <div class="bg-gradient-to-tr from-brand-accent to-cyan-400 p-2 rounded-lg text-white">
                    <i class="fa-solid fa-code-merge text-xl"></i>
                </div>
                <div>
                    <span class="font-extrabold text-xl text-white tracking-wider">DevSync</span>
                    <span class="text-xs block text-cyan-400 font-semibold tracking-widest uppercase">IT Groupware</span>
                </div>
            </a>
        </div>

        <div class="p-4 mx-4 my-3 bg-brand-card/50 rounded-xl border border-brand-border/60 flex items-center gap-3">
            <div class="relative">
                <img src="<%=request.getContextPath()%>/common/loginProfileView.do" onerror="this.onerror=null;this.src='<%=request.getContextPath()%>/images/default-profile.svg';" alt="로그인 사용자 프로필" class="w-10 h-10 rounded-full border border-cyan-400 object-cover bg-slate-800">
                <span class="absolute bottom-0 right-0 w-3 h-3 bg-emerald-500 border-2 border-slate-950 rounded-full"></span>
            </div>
            <div class="flex-grow overflow-hidden">
                <h4 class="font-bold text-sm text-gray-100 truncate">${not empty sessionScope.login ? sessionScope.login.userNm : '게스트'}</h4>
                <span class="text-xs text-gray-400">${not empty sessionScope.login ? sessionScope.login.authrtNm : ''}</span>
            </div>
        </div>

        <nav class="px-4 space-y-1">
            <div>
                <button type="button" onclick="toggleSubmenu('sub-work')" class="w-full flex items-center justify-between p-3 text-gray-300 hover:text-white hover:bg-brand-card rounded-lg transition duration-200 group">
                    <span class="flex items-center gap-3"><i class="fa-solid fa-clock-rotate-left text-gray-400 group-hover:text-cyan-400 w-5"></i><span class="font-medium text-sm">근무 관리</span></span>
                    <i id="arrow-sub-work" class="fa-solid fa-chevron-down text-xs transition-transform text-gray-500"></i>
                </button>
                <div id="sub-work" class="hidden pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400 transition-all duration-300">
                    <a href="#" class="ds-sidebar-link">출퇴근 및 타임카드</a>
                    <a href="#" class="ds-sidebar-link">유연근무 현황</a>
                    <a href="#" class="ds-sidebar-link">외근/파견/상주 신청</a>
                </div>
            </div>

            <div>
                <button type="button" onclick="toggleSubmenu('sub-leave')" class="w-full flex items-center justify-between p-3 text-gray-300 hover:text-white hover:bg-brand-card rounded-lg transition duration-200 group">
                    <span class="flex items-center gap-3"><i class="fa-solid fa-umbrella text-gray-400 group-hover:text-cyan-400 w-5"></i><span class="font-medium text-sm">휴가 관리</span></span>
                    <i id="arrow-sub-leave" class="fa-solid fa-chevron-down text-xs transition-transform text-gray-500"></i>
                </button>
                <div id="sub-leave" class="hidden pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                    <a href="#" class="ds-sidebar-link">휴가 신청서 작성</a>
                    <a href="#" class="ds-sidebar-link">잔여 연차 현황</a>
                    <a href="#" class="ds-sidebar-link">대체/보상 휴가 적립</a>
                </div>
            </div>

            <div>
                <button type="button" onclick="toggleSubmenu('sub-schedule')" class="w-full flex items-center justify-between p-3 <%= isSchedule ? "text-white bg-brand-card" : "text-gray-300 hover:text-white hover:bg-brand-card" %> rounded-lg transition duration-200 group">
                    <span class="flex items-center gap-3"><i class="fa-solid fa-calendar-check <%= isSchedule ? "text-cyan-400" : "text-gray-400 group-hover:text-cyan-400" %> w-5"></i><span class="font-medium text-sm">일정/공유</span></span>
                    <i id="arrow-sub-schedule" class="fa-solid <%= isSchedule ? "fa-chevron-up text-cyan-400" : "fa-chevron-down text-gray-500" %> text-xs transition-transform"></i>
                </button>
                <div id="sub-schedule" class="<%= isSchedule ? "" : "hidden" %> pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                    <a href="<%=request.getContextPath()%>/schedule/scheduleList.do" data-menu-path="/schedule/scheduleList.do" class="ds-sidebar-link <%= isSchedule ? "is-active" : "" %>">종합 일정 캘린더</a>
                    <a href="#" class="ds-sidebar-link">회의실/자원 예약</a>
                    <a href="#" class="ds-sidebar-link">공용 테스트폰 대여</a>
                </div>
            </div>

            <div>
                <button type="button" onclick="toggleSubmenu('sub-project')" class="w-full flex items-center justify-between p-3 <%= isProject ? "text-white bg-brand-card" : "text-gray-300 hover:text-white hover:bg-brand-card" %> rounded-lg transition duration-200 group">
                    <span class="flex items-center gap-3"><i class="fa-solid fa-cubes-stacked <%= isProject ? "text-cyan-400" : "text-gray-400 group-hover:text-cyan-400" %> w-5"></i><span class="font-medium text-sm">프로젝트/사업</span></span>
                    <i id="arrow-sub-project" class="fa-solid <%= isProject ? "fa-chevron-up text-cyan-400" : "fa-chevron-down text-gray-500" %> text-xs transition-transform"></i>
                </button>
                <div id="sub-project" class="<%= isProject ? "" : "hidden" %> pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                    <a href="<%=request.getContextPath()%>/biz/bizList.do" data-menu-path="/biz/bizList.do,/biz/bizInsert.do,/biz/bizDetail.do,/biz/bizUpdate.do" class="ds-sidebar-link <%= isBizList ? "is-active" : "" %>">사업 목록</a>
                    <a href="<%=request.getContextPath()%>/biz/contractList.do" data-menu-path="/biz/contractList.do" class="ds-sidebar-link <%= isContract ? "is-active" : "" %>">계약 관리</a>
                    <a href="<%=request.getContextPath()%>/biz/accountList.do" data-menu-path="/biz/accountList.do" class="ds-sidebar-link <%= isAccount ? "is-active" : "" %>">회계 관리</a>
                    <a href="<%=request.getContextPath()%>/biz/mnpwList.do" data-menu-path="/biz/mnpwList.do" class="ds-sidebar-link <%= isMnpw ? "is-active" : "" %>">투입인력 관리</a>
                    <a href="<%=request.getContextPath()%>/biz/schdlList.do" data-menu-path="/biz/schdlList.do" class="ds-sidebar-link <%= isSchdl ? "is-active" : "" %>">프로세스(일정) 관리</a>
                </div>
            </div>



            <div>
                <button type="button" onclick="toggleSubmenu('sub-user-mgmt')" class="w-full flex items-center justify-between p-3 <%= isCompanyMgmt ? "text-white bg-brand-card" : "text-gray-300 hover:text-white hover:bg-brand-card" %> rounded-lg transition duration-200 group">
                    <span class="flex items-center gap-3"><i class="fa-solid fa-building text-gray-400 group-hover:text-cyan-400 w-5"></i><span class="font-medium text-sm">회사 관리</span></span>
                    <i id="arrow-sub-user-mgmt" class="fa-solid <%= isCompanyMgmt ? "fa-chevron-up text-cyan-400" : "fa-chevron-down text-gray-500" %> text-xs transition-transform"></i>
                </button>
                <div id="sub-user-mgmt" class="<%= isCompanyMgmt ? "" : "hidden" %> pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                    <a href="<%=request.getContextPath()%>/dept/orgList.do" data-menu-path="/dept/orgList.do" class="ds-sidebar-link <%= isOrgMgmt ? "is-active" : "" %>">조직 관리</a>
                    <a href="<%=request.getContextPath()%>/user/empList.do" data-menu-path="/user/empList.do,/user/empInsert.do,/user/empDetail.do,/user/empUpdate.do" class="ds-sidebar-link <%= isEmpMgmt ? "is-active" : "" %>">사용자 관리</a>
                </div>
            </div>

            <div>
                <button type="button" onclick="toggleSubmenu('sub-infra')" class="w-full flex items-center justify-between p-3 text-gray-300 hover:text-white hover:bg-brand-card rounded-lg transition duration-200 group">
                    <span class="flex items-center gap-3"><i class="fa-solid fa-laptop-code text-gray-400 group-hover:text-cyan-400 w-5"></i><span class="font-medium text-sm">인프라/총무</span></span>
                    <i id="arrow-sub-infra" class="fa-solid fa-chevron-down text-xs text-gray-500 transition-transform"></i>
                </button>
                <div id="sub-infra" class="hidden pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                    <a href="#" class="ds-sidebar-link">장비/기기 할당 대장</a>
                    <a href="#" class="ds-sidebar-link">SW 라이선스 신청</a>
                    <a href="#" class="ds-sidebar-link">비대면 증명서 발급</a>
                </div>
            </div>

            <div>
                <button type="button" onclick="toggleSubmenu('sub-finance')" class="w-full flex items-center justify-between p-3 text-gray-300 hover:text-white hover:bg-brand-card rounded-lg transition duration-200 group">
                    <span class="flex items-center gap-3"><i class="fa-solid fa-file-invoice-dollar text-gray-400 group-hover:text-cyan-400 w-5"></i><span class="font-medium text-sm">비용/회계</span></span>
                    <i id="arrow-sub-finance" class="fa-solid fa-chevron-down text-xs text-gray-500 transition-transform"></i>
                </button>
                <div id="sub-finance" class="hidden pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                    <a href="#" class="ds-sidebar-link">지출 경비 청구(OCR)</a>
                    <a href="#" class="ds-sidebar-link">급여 명세서 조회</a>
                    <a href="#" class="ds-sidebar-link">프로젝트별 손익 리포트</a>
                </div>
            </div>
        </nav>
    </div>

    <div class="ds-sidebar-footer p-4 border-t border-brand-border flex items-center justify-between text-xs text-gray-500">
        <span>Server: <span class="text-emerald-500 font-bold">Stable</span></span>
        <div class="flex items-center gap-2">
            <button type="button" class="hover:text-white" title="설정"><i class="fa-solid fa-gear text-sm"></i></button>
            <a href="<%=request.getContextPath()%>/login/logout.do" class="hover:text-red-400 transition" title="로그아웃" onclick="return confirm('로그아웃 하시겠습니까?')">
                <i class="fa-solid fa-right-from-bracket text-sm"></i>
            </a>
        </div>
    </div>
</aside>
<script>
(function() {
    var path = window.location.pathname.replace('<%=request.getContextPath()%>', '');
    document.querySelectorAll('.ds-sidebar-link[data-menu-path]').forEach(function(link) {
        var paths = (link.getAttribute('data-menu-path') || '').split(',');
        if (paths.indexOf(path) > -1) {
            document.querySelectorAll('.ds-sidebar-link.is-active').forEach(function(activeLink) {
                activeLink.classList.remove('is-active');
            });
            link.classList.add('is-active');
        }
    });
})();
</script>
