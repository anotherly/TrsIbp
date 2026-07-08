<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<aside class="w-64 bg-slate-950 border-r border-brand-border flex flex-col justify-between h-screen sticky top-0 z-30">
    <div>
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
                <img src="<%=request.getContextPath()%>/protoType/photo-1534528741775-53994a69daeb" alt="Profile" class="w-10 h-10 rounded-full border border-cyan-400 object-cover">
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
                    <i id="arrow-sub-work" class="fa-solid fa-chevron-up text-xs transition-transform text-cyan-400"></i>
                </button>
                <div id="sub-work" class="pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400 transition-all duration-300">
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">출퇴근 및 타임카드</a>
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">유연근무 현황</a>
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">외근/파견/상주 신청</a>
                </div>
            </div>

            <div>
                <button type="button" onclick="toggleSubmenu('sub-leave')" class="w-full flex items-center justify-between p-3 text-gray-300 hover:text-white hover:bg-brand-card rounded-lg transition duration-200 group">
                    <span class="flex items-center gap-3"><i class="fa-solid fa-umbrella text-gray-400 group-hover:text-cyan-400 w-5"></i><span class="font-medium text-sm">휴가 관리</span></span>
                    <i id="arrow-sub-leave" class="fa-solid fa-chevron-up text-xs transition-transform text-cyan-400"></i>
                </button>
                <div id="sub-leave" class="pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">휴가 신청서 작성</a>
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">잔여 연차 현황</a>
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">대체/보상 휴가 적립</a>
                </div>
            </div>

            <div>
                <button type="button" onclick="toggleSubmenu('sub-schedule')" class="w-full flex items-center justify-between p-3 text-gray-300 hover:text-white hover:bg-brand-card rounded-lg transition duration-200 group">
                    <span class="flex items-center gap-3"><i class="fa-solid fa-calendar-check text-gray-400 group-hover:text-cyan-400 w-5"></i><span class="font-medium text-sm">일정/공유</span></span>
                    <i id="arrow-sub-schedule" class="fa-solid fa-chevron-down text-xs text-gray-500 transition-transform"></i>
                </button>
                <div id="sub-schedule" class="hidden pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">종합 일정 캘린더</a>
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">회의실/자원 예약</a>
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">공용 테스트폰 대여</a>
                </div>
            </div>

            <div>
                <button type="button" onclick="toggleSubmenu('sub-project')" class="w-full flex items-center justify-between p-3 text-white bg-brand-card rounded-lg transition duration-200 group">
                    <span class="flex items-center gap-3"><i class="fa-solid fa-cubes-stacked text-cyan-400 w-5"></i><span class="font-medium text-sm">프로젝트/사업</span></span>
                    <i id="arrow-sub-project" class="fa-solid fa-chevron-up text-xs transition-transform text-cyan-400"></i>
                </button>
                <div id="sub-project" class="pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                    <a href="<%=request.getContextPath()%>/biz/bizList.do" class="block p-2 text-cyan-400 font-semibold rounded-md bg-slate-900/40">사업 목록</a>
                    <a href="<%=request.getContextPath()%>/biz/contractList.do" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">계약 관리</a>
                    <a href="<%=request.getContextPath()%>/biz/accountList.do" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">회계 관리</a>
                    <a href="<%=request.getContextPath()%>/biz/mnpwList.do" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">투입인력 관리</a>
                    <a href="<%=request.getContextPath()%>/biz/schdlList.do" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">프로세스(일정) 관리</a>
                </div>
            </div>

            <div>
                <button type="button" onclick="toggleSubmenu('sub-infra')" class="w-full flex items-center justify-between p-3 text-gray-300 hover:text-white hover:bg-brand-card rounded-lg transition duration-200 group">
                    <span class="flex items-center gap-3"><i class="fa-solid fa-laptop-code text-gray-400 group-hover:text-cyan-400 w-5"></i><span class="font-medium text-sm">인프라/총무</span></span>
                    <i id="arrow-sub-infra" class="fa-solid fa-chevron-down text-xs text-gray-500 transition-transform"></i>
                </button>
                <div id="sub-infra" class="hidden pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">장비/기기 할당 대장</a>
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">SW 라이선스 신청</a>
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">비대면 증명서 발급</a>
                </div>
            </div>

            <div>
                <button type="button" onclick="toggleSubmenu('sub-finance')" class="w-full flex items-center justify-between p-3 text-gray-300 hover:text-white hover:bg-brand-card rounded-lg transition duration-200 group">
                    <span class="flex items-center gap-3"><i class="fa-solid fa-file-invoice-dollar text-gray-400 group-hover:text-cyan-400 w-5"></i><span class="font-medium text-sm">비용/회계</span></span>
                    <i id="arrow-sub-finance" class="fa-solid fa-chevron-down text-xs text-gray-500 transition-transform"></i>
                </button>
                <div id="sub-finance" class="hidden pl-8 pr-2 py-1 space-y-1 text-xs text-gray-400">
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">지출 경비 청구(OCR)</a>
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">급여 명세서 조회</a>
                    <a href="#" class="block p-2 hover:text-white rounded-md hover:bg-brand-card">프로젝트별 손익 리포트</a>
                </div>
            </div>
        </nav>
    </div>

    <div class="p-4 border-t border-brand-border flex items-center justify-between text-xs text-gray-500">
        <span>Server: <span class="text-emerald-500 font-bold">Stable</span></span>
        <div class="flex items-center gap-2">
            <button type="button" class="hover:text-white" title="설정"><i class="fa-solid fa-gear text-sm"></i></button>
            <a href="<%=request.getContextPath()%>/login/logout.do" class="hover:text-red-400 transition" title="로그아웃" onclick="return confirm('로그아웃 하시겠습니까?')">
                <i class="fa-solid fa-right-from-bracket text-sm"></i>
            </a>
        </div>
    </div>
</aside>
