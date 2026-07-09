<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String dsPageTitle = request.getParameter("dsPageTitle");
    if (dsPageTitle == null || dsPageTitle.trim().isEmpty()) {
        dsPageTitle = "대시보드 홈";
    }
%>
<header class="h-16 border-b border-brand-border bg-brand-card/30 backdrop-blur-md flex items-center justify-between px-8 sticky top-0 z-20">
    <div class="flex items-center gap-2 text-sm text-gray-400">
        <span>IT 개발사 스마트 포털</span>
        <i class="fa-solid fa-angle-right text-xs"></i>
        <span class="text-gray-100 font-semibold"><%=dsPageTitle%></span>
    </div>

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

        <div class="relative cursor-pointer hover:text-white text-gray-400">
            <i class="fa-solid fa-bell text-lg"></i>
            <span class="absolute -top-1 -right-1 w-2.5 h-2.5 bg-red-500 rounded-full border border-brand-dark animate-pulse"></span>
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
