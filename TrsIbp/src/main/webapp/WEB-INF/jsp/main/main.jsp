<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp">
        <jsp:param name="dsTitle" value="DevSync - IT 개발사 스마트 대시보드"/>
    </jsp:include>
</head>
<body class="ds-body min-h-screen flex">
    <jsp:include page="/WEB-INF/jsp/common/sidebar.jsp"/>

    <!-- 2. MAIN LAYOUT (메인 대시보드 영역) -->
    <div class="flex-grow flex flex-col min-h-screen">
        <jsp:include page="/WEB-INF/jsp/common/header.jsp">
            <jsp:param name="dsPageTitle" value="대시보드 홈"/>
        </jsp:include>

        <!-- DASHBOARD CONTAINER (콘텐츠 스크롤 구역) -->
        <main class="flex-grow p-8 space-y-6 max-w-7xl mx-auto w-full">
            
            <!-- ROW 1: QUICK ACTIONS & STATUS (상단 근태/휴가 요약 그리드) -->
            <section class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <!-- 위젯 A: 스마트 근태 체크 (출퇴근 타임클락 - INTERACTIVE!) -->
                <div class="bg-brand-card p-6 rounded-2xl border border-brand-border flex flex-col justify-between shadow-xl relative overflow-hidden">
                    <div class="absolute -right-10 -top-10 w-24 h-24 bg-brand-accent/5 rounded-full blur-2xl"></div>
                    <div>
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="font-bold text-gray-200 text-base">근무 상태 컨트롤러</h3>
                            <span id="work-location-badge" class="px-2.5 py-0.5 bg-brand-accent/15 border border-brand-accent/30 text-brand-neonBlue text-xs rounded-full font-bold">본사 근무</span>
                        </div>
                        
                        <!-- 근무지 토글 칩스 -->
                        <div class="grid grid-cols-4 gap-1.5 mb-4">
                            <button onclick="setWorkLocation('본사')" id="loc-본사" class="py-1 text-xs rounded-lg font-semibold bg-brand-accent text-white border border-brand-accent transition">본사</button>
                            <button onclick="setWorkLocation('재택')" id="loc-재택" class="py-1 text-xs rounded-lg font-semibold bg-slate-900 text-gray-400 border border-brand-border hover:text-white transition">재택</button>
                            <button onclick="setWorkLocation('외근')" id="loc-외근" class="py-1 text-xs rounded-lg font-semibold bg-slate-900 text-gray-400 border border-brand-border hover:text-white transition">외근</button>
                            <button onclick="setWorkLocation('상주')" id="loc-상주" class="py-1 text-xs rounded-lg font-semibold bg-slate-900 text-gray-400 border border-brand-border hover:text-white transition">상주</button>
                        </div>

                        <!-- 실시간 근무 타이머 -->
                        <div class="text-center py-2">
                            <span id="timer-display" class="text-3xl font-extrabold text-white tracking-widest font-mono">00 : 00 : 00</span>
                            <p class="text-xs text-gray-400 mt-1">오늘 총 기록된 근무 시간</p>
                        </div>
                    </div>

                    <!-- 출퇴근 작동 버튼 -->
                    <div class="grid grid-cols-2 gap-3 mt-4">
                        <button id="btn-checkout" onclick="triggerCheckOut()" class="w-full py-2.5 bg-slate-800 text-gray-500 border border-brand-border rounded-xl text-sm font-bold cursor-not-allowed transition flex items-center justify-center gap-2" disabled="">
                            <i class="fa-solid fa-arrow-right-from-bracket"></i> 퇴근하기
                        </button>
                    </div>
                    <!-- 출퇴근 시간 표시 (AJAX 응답 후 업데이트) -->
                    <div class="mt-3 text-center text-xs text-gray-500 space-y-0.5">
                        <p id="checkin-time-display"></p>
                        <p id="checkout-time-display"></p>
                        <p id="work-time-display"></p>
                    </div>
                </div>

                <!-- 위젯 B: 나의 휴가 요약 -->
                <div class="bg-brand-card p-6 rounded-2xl border border-brand-border flex flex-col justify-between shadow-xl">
                    <div>
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="font-bold text-gray-200 text-base">연차 소진 및 잔여</h3>
                            <button class="text-xs text-cyan-400 font-bold hover:underline">휴가계획 수립 <i class="fa-solid fa-arrow-right"></i></button>
                        </div>
                        <div class="flex items-baseline gap-2 justify-center py-4">
                            <span class="text-5xl font-black text-white font-mono tracking-tighter">11.5</span>
                            <span class="text-lg text-gray-400">/ 15 일</span>
                        </div>
                        <!-- 커스텀 프로그레스바 -->
                        <div class="w-full bg-slate-900 h-2.5 rounded-full overflow-hidden border border-brand-border">
                            <div class="bg-gradient-to-r from-cyan-500 to-brand-accent h-full rounded-full" style="width: 76.6%;"></div>
                        </div>
                        <div class="flex justify-between text-xs text-gray-400 mt-2">
                            <span>사용한 연차: 3.5일</span>
                            <span>남은 연차: 11.5일</span>
                        </div>
                    </div>
                    <!-- 단축 링크 -->
                    <button class="w-full mt-4 py-2.5 bg-slate-900 hover:bg-slate-800 border border-brand-border text-gray-200 rounded-xl text-xs font-semibold transition flex items-center justify-center gap-2">
                        <i class="fa-solid fa-file-signature text-cyan-400"></i> 전자 휴가 결재 기안하기
                    </button>
                </div>

                <!-- 위젯 C: 내 Jira 스프린트 / PR 현황 -->
                <div class="bg-brand-card p-6 rounded-2xl border border-brand-border flex flex-col justify-between shadow-xl">
                    <div>
                        <div class="flex items-center justify-between mb-3">
                            <h3 class="font-bold text-gray-200 text-base">스프린트 개발 공수 (Jira)</h3>
                            <span class="px-2 py-0.5 bg-blue-500/10 border border-blue-500/20 text-blue-400 text-[10px] rounded font-bold uppercase">Sprint 24</span>
                        </div>
                        <div class="space-y-3 py-1">
                            <div>
                                <div class="flex justify-between text-xs mb-1">
                                    <span class="text-gray-300 font-medium">#102 쇼핑몰 결제 연동 API</span>
                                    <span class="text-cyan-400 font-semibold">82%</span>
                                </div>
                                <div class="w-full bg-slate-900 h-2 rounded-full overflow-hidden">
                                    <div class="bg-brand-neonBlue h-full rounded-full" style="width: 82%;"></div>
                                </div>
                            </div>
                            <div>
                                <div class="flex justify-between text-xs mb-1">
                                    <span class="text-gray-300 font-medium">#105 모바일 결제 화면 UI 고도화</span>
                                    <span class="text-emerald-400 font-semibold">100% (Done)</span>
                                </div>
                                <div class="w-full bg-slate-900 h-2 rounded-full overflow-hidden">
                                    <div class="bg-emerald-500 h-full rounded-full" style="width: 100%;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 깃허브 Pull Request 링크 연동 인터페이스 -->
                    <div class="border-t border-brand-border/60 pt-3 mt-3 flex items-center justify-between text-xs">
                        <span class="text-gray-400"><i class="fa-brands fa-github text-gray-300 mr-1.5"></i> PR 대기 중인 코드</span>
                        <a href="#" class="text-brand-neonBlue hover:underline font-semibold flex items-center gap-1">2건 검토하기 <i class="fa-solid fa-chevron-right text-[10px]"></i></a>
                    </div>
                </div>
            </section>

            <!-- ROW 2: SMART SCHEDULE WIDGET -->
            <section class="bg-brand-card rounded-2xl border border-brand-border shadow-xl overflow-hidden">
                <div class="p-6 border-b border-brand-border bg-slate-950/40 flex flex-col xl:flex-row xl:items-end justify-between gap-4">
                    <div class="flex items-center gap-3">
                        <div class="w-2.5 h-6 bg-brand-accent rounded-full"></div>
                        <div>
                            <h2 class="text-lg font-bold text-gray-100">스마트 일정 위젯 (스케줄러)</h2>
                            <p class="text-xs text-gray-400">휴가, 출장, 외근, 회의, 기타 일정을 종합 캘린더와 연동합니다.</p>
                        </div>
                    </div>
                    <div class="ds-schedule-toolbar">
                        <label class="ds-project-filter">프로젝트 필터<select id="dashScheduleProjectFilter" class="ds-select"><option value="">전체 프로젝트</option></select></label>
                        <div class="ds-tab-group">
                            <button type="button" data-view-type="all" onclick="changeDashboardScheduleView('all')" class="dash-schedule-tab ds-tab is-active">전체 일정</button>
                            <button type="button" data-view-type="my" onclick="changeDashboardScheduleView('my')" class="dash-schedule-tab ds-tab">내 일정</button>
                            <button type="button" data-view-type="team" onclick="changeDashboardScheduleView('team')" class="dash-schedule-tab ds-tab">팀 일정</button>
                        </div>
                    </div>
                </div>
                <div class="grid grid-cols-1 lg:grid-cols-12">
                    <div class="lg:col-span-8 p-6 border-r border-brand-border bg-slate-950/20">
                        <div class="ds-calendar-head">
                            <button type="button" class="ds-icon-btn" onclick="moveDashboardScheduleMonth(-1);">‹</button>
                            <strong id="dashScheduleMonthLabel"></strong>
                            <button type="button" class="ds-icon-btn" onclick="moveDashboardScheduleMonth(1);">›</button>
                        </div>
                        <div id="dashScheduleCalendarGrid" class="ds-calendar-grid"></div>
                        <div class="ds-calendar-legend">
                            <span><i class="ds-dot ds-dot-leave"></i>휴가</span>
                            <span><i class="ds-dot ds-dot-trip"></i>출장/외근</span>
                            <span><i class="ds-dot ds-dot-meeting"></i>회의</span>
                            <span><i class="ds-dot ds-dot-etc"></i>기타</span>
                        </div>
                    </div>
                    <div class="lg:col-span-4 p-6">
                        <div class="ds-schedule-list-head">
                            <h3 id="dashScheduleSelectedTitle" class="font-bold text-sm text-gray-300"></h3>
                            <a href="${pageContext.request.contextPath}/schedule/scheduleList.do" class="ds-btn ds-btn-outline">캘린더 크게보기</a>
                        </div>
                        <div id="dashScheduleDayList" class="ds-schedule-list"></div>
                    </div>
                </div>
            </section>

            <!-- ROW 3: TWO-COLUMN COLLABORATION & INFRA (자원예약, 팀원 협업 상태, 인프라) -->
            <section class="grid grid-cols-1 lg:grid-cols-12 gap-6">
                <!-- 좌측 7/12: 오늘의 전사 원격/재택/휴가 현황판 (협업 지원용) -->
                <div class="lg:col-span-7 bg-brand-card p-6 rounded-2xl border border-brand-border flex flex-col justify-between shadow-xl">
                    <div>
                        <div class="flex items-center justify-between mb-4">
                            <div class="flex items-center gap-2">
                                <i class="fa-solid fa-users text-cyan-400"></i>
                                <h3 class="font-bold text-gray-200 text-base">오늘의 부서원 상태 공유</h3>
                            </div>
                            <span class="text-xs bg-slate-900 border border-brand-border px-2 py-1 rounded text-gray-400">총 8명 중 3명 외부 근무</span>
                        </div>

                        <div class="space-y-3">
                            <!-- 팀원 1: 재택 -->
                            <div class="flex items-center justify-between bg-slate-950/40 p-3 rounded-xl border border-brand-border/60">
                                <div class="flex items-center gap-3">
                                    <img src="<%=request.getContextPath()%>/protoType/photo-1438761681033-6461ffad8d80" alt="Team Profile" class="w-9 h-9 rounded-full object-cover border border-blue-400">
                                    <div>
                                        <span class="font-bold text-sm text-gray-200">한혜지 대리</span>
                                        <p class="text-[11px] text-gray-400">웹 디자인 파트</p>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <span class="px-2 py-1 bg-blue-500/10 border border-blue-500/20 text-blue-400 text-xs rounded-full font-bold"><i class="fa-solid fa-house-laptop"></i> 재택 근무</span>
                                </div>
                            </div>

                            <!-- 팀원 2: 상주(파견) -->
                            <div class="flex items-center justify-between bg-slate-950/40 p-3 rounded-xl border border-brand-border/60">
                                <div class="flex items-center gap-3">
                                    <img src="<%=request.getContextPath()%>/protoType/photo-1507003211169-0a1dd7228f2d" alt="Team Profile" class="w-9 h-9 rounded-full object-cover border border-purple-400">
                                    <div>
                                        <span class="font-bold text-sm text-gray-200">정재윤 책임</span>
                                        <p class="text-[11px] text-gray-400">백엔드 아키텍트</p>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <span class="px-2 py-1 bg-purple-500/10 border border-purple-500/20 text-purple-400 text-xs rounded-full font-bold"><i class="fa-solid fa-network-wired"></i> 고객사 상주</span>
                                </div>
                            </div>

                            <!-- 팀원 3: 연차 -->
                            <div class="flex items-center justify-between bg-slate-950/40 p-3 rounded-xl border border-brand-border/60">
                                <div class="flex items-center gap-3">
                                    <img src="<%=request.getContextPath()%>/protoType/photo-1494790108377-be9c29b29330" alt="Team Profile" class="w-9 h-9 rounded-full object-cover border border-emerald-500">
                                    <div>
                                        <span class="font-bold text-sm text-gray-200">김민서 수석</span>
                                        <p class="text-[11px] text-gray-400">인프라/보안 파트</p>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <span class="px-2 py-1 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 text-xs rounded-full font-bold"><i class="fa-solid fa-umbrella"></i> 연차 휴가</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 단축 연락망 -->
                    <p class="text-[11px] text-gray-500 mt-3">* 해당 상태 정보는 슬랙(Slack)의 상태 마크에 실시간 자동 동기화되어 반영됩니다.</p>
                </div>

                <!-- 우측 5/12: 사내 대여 자산 및 회의실 실시간 예약 상황 -->
                <div class="lg:col-span-5 bg-brand-card p-6 rounded-2xl border border-brand-border flex flex-col justify-between shadow-xl">
                    <div>
                        <div class="flex items-center justify-between mb-4">
                            <div class="flex items-center gap-2">
                                <i class="fa-solid fa-box text-cyan-400"></i>
                                <h3 class="font-bold text-gray-200 text-base">공용 테스트 기기 대여</h3>
                            </div>
                            <span class="text-xs text-brand-neonBlue font-bold hover:underline cursor-pointer">대여하기</span>
                        </div>

                        <div class="space-y-2.5">
                            <!-- 자산 1: 맥북 -->
                            <div class="flex items-center justify-between text-xs bg-slate-950 p-2.5 rounded-lg border border-brand-border">
                                <span class="text-gray-300 font-medium"><i class="fa-solid fa-laptop text-gray-500 mr-2"></i>MacBook Pro M3 16" (A-04)</span>
                                <span class="px-2 py-0.5 rounded bg-slate-800 text-gray-400 font-bold">내 보유 기기</span>
                            </div>
                            <!-- 자산 2: 아이폰 -->
                            <div class="flex items-center justify-between text-xs bg-slate-950 p-2.5 rounded-lg border border-brand-border">
                                <span class="text-gray-300 font-medium"><i class="fa-solid fa-mobile-screen-button text-gray-500 mr-2"></i>iPhone 15 Pro (T-iOS-02)</span>
                                <span class="px-2 py-0.5 rounded bg-red-500/10 border border-red-500/20 text-red-400 font-bold">대여 중 (H 대리)</span>
                            </div>
                            <!-- 자산 3: 갤럭시 -->
                            <div class="flex items-center justify-between text-xs bg-slate-950 p-2.5 rounded-lg border border-brand-border">
                                <span class="text-gray-300 font-medium"><i class="fa-solid fa-mobile-screen-button text-gray-500 mr-2"></i>Galaxy S24 Ultra (T-And-09)</span>
                                <span class="px-2 py-0.5 rounded bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 font-bold">대여 가능</span>
                            </div>
                        </div>

                        <!-- 회의실 예약 요약 -->
                        <div class="mt-5 pt-4 border-t border-brand-border/60">
                            <h4 class="text-xs font-bold text-gray-400 mb-2">오늘 내가 예약한 사내 자원</h4>
                            <div class="bg-brand-accent/5 border border-brand-accent/20 p-3 rounded-lg text-xs flex justify-between items-center">
                                <div>
                                    <span class="font-bold text-gray-100 block">3층 미팅룸 B (회의실)</span>
                                    <span class="text-[10px] text-gray-400">사용 예정: 10:00 - 10:30 (데일리 스크럼)</span>
                                </div>
                                <button class="text-red-400 hover:underline">취소</button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </main>
    </div>

    <!-- 3. INTERACTIVE MODAL FOR ADDING EVENT (일정 추가 인터랙션 모달) -->
    <div id="add-event-modal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm transition-all duration-300">
        <div class="bg-brand-card border border-brand-border rounded-2xl w-full max-w-md p-6 shadow-2xl relative">
            <button onclick="closeAddEventModal()" class="absolute top-4 right-4 text-gray-400 hover:text-white text-lg"><i class="fa-solid fa-xmark"></i></button>
            <h3 class="text-lg font-bold text-white mb-4"><i class="fa-solid fa-calendar-plus text-cyan-400 mr-1.5"></i> 새 일정 등록하기</h3>
            
            <form onsubmit="addNewEvent(event)" class="space-y-4">
                <!-- 일정 카테고리 분류 -->
                <div>
                    <label class="block text-xs font-bold text-gray-400 mb-1.5">일정 종류</label>
                    <select id="new-event-cat" class="w-full bg-slate-900 border border-brand-border text-xs rounded-lg p-2.5 text-gray-200 focus:outline-none focus:border-brand-accent">
                        <option value="my">내 업무 일정 (Personal Task)</option>
                        <option value="project">프로젝트/마일스톤 (Jira 연동)</option>
                        <option value="team">팀 휴가/재택 등록 (전자결재연동)</option>
                    </select>
                </div>

                <!-- 일정 타이틀 -->
                <div>
                    <label class="block text-xs font-bold text-gray-400 mb-1.5">일정 타이틀</label>
                    <input type="text" id="new-event-title" required="" class="w-full bg-slate-900 border border-brand-border text-xs rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-brand-accent" placeholder="예: [프로젝트] AWS 클라우드 아키텍처 중간 미팅">
                </div>

                <!-- 시간 설정 -->
                <div class="grid grid-cols-2 gap-3">
                    <div>
                        <label class="block text-xs font-bold text-gray-400 mb-1.5">시작 시간</label>
                        <input type="time" id="new-event-time" required="" class="w-full bg-slate-900 border border-brand-border text-xs rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-brand-accent">
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-gray-400 mb-1.5">소요 시간</label>
                        <select id="new-event-duration" class="w-full bg-slate-900 border border-brand-border text-xs rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-brand-accent">
                            <option value="30m">30 분</option>
                            <option value="1h">1 시간</option>
                            <option value="2h">2 시간</option>
                            <option value="All Day">All Day (온종일)</option>
                        </select>
                    </div>
                </div>

                <!-- 상세 설명 및 회의실 등 리소스 연동 -->
                <div>
                    <label class="block text-xs font-bold text-gray-400 mb-1.5">회의 장소 / 자원 선택</label>
                    <select id="new-event-loc" class="w-full bg-slate-900 border border-brand-border text-xs rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-brand-accent">
                        <option value="3층 미팅룸 B">3층 대회의실 B</option>
                        <option value="화상 회의 (Zoom)">원격 화상 회의 (Zoom 연동 생성)</option>
                        <option value="기타">장소 없음 / 비대면</option>
                    </select>
                </div>

                <!-- 설명 기재 -->
                <div>
                    <label class="block text-xs font-bold text-gray-400 mb-1.5">일정 상세 설명</label>
                    <textarea id="new-event-desc" rows="2" class="w-full bg-slate-900 border border-brand-border text-xs rounded-lg p-2.5 text-gray-100 focus:outline-none focus:border-brand-accent" placeholder="일정의 세부 업무 범위나 어젠다를 입력하세요."></textarea>
                </div>

                <!-- 승인 버튼 -->
                <button type="submit" class="w-full py-2.5 bg-brand-accent hover:bg-blue-600 text-white rounded-xl text-sm font-bold shadow-lg shadow-brand-accent/20 transition">일정 및 리소스 저장하기</button>
            </form>
        </div>
    </div>


    <%-- 컨텍스트 경로: dashboard.js에서 AJAX URL 조합에 사용 --%>
    <script>
        var ctxPath = '<%=request.getContextPath()%>';
    </script>

    <script src="<%=request.getContextPath()%>/js/dashboard.js"></script>
    <script src="<%=request.getContextPath()%>/js/schedule/schedule.js"></script>

<script>$(function(){ if (typeof initDashboardScheduleWidget === 'function') { initDashboardScheduleWidget(); } });</script>
</body></html>
