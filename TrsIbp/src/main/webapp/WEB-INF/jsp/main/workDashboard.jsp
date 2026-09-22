<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="ds-dashboard-stack">
    <section class="ds-dashboard-hero">
        <div>
            <p class="ds-dashboard-eyebrow">DevSync Workspace</p>
            <h1>내 업무 대시보드</h1>
            <p>오늘 일정, 참여 프로젝트와 일일 계획 진행상황을 한눈에 확인합니다.</p>
        </div>
        <div class="ds-dashboard-scope">
            <strong><i class="fa-solid fa-shield-halved"></i> 조회 범위</strong>
            <span>로그인 사용자 본인의 일정·프로젝트·일일 계획 기준</span>
        </div>
    </section>

    <section class="ds-dashboard-kpis">
        <article class="ds-dashboard-card ds-kpi-clickable" tabindex="0" role="button" onclick="focusWorkTodaySchedule(this);">
            <div class="ds-kpi-label">오늘 일정</div>
            <div class="ds-kpi-value"><fmt:formatNumber value="${dashboardSummary.todayScheduleCount}"/>건</div>
            <div class="ds-kpi-sub">클릭하면 오늘 · 내 일정으로 이동</div>
        </article>
        <article class="ds-dashboard-card ds-kpi-clickable" tabindex="0" role="button" onclick="openDashboardSummaryDetail('work','myProject',this,'참여 중 프로젝트');">
            <div class="ds-kpi-label">참여 중 프로젝트</div>
            <div class="ds-kpi-value is-cyan"><fmt:formatNumber value="${dashboardSummary.myProjectCount}"/>개</div>
            <div class="ds-kpi-sub">클릭해서 참여 프로젝트 확인</div>
        </article>
        <article class="ds-dashboard-card ds-kpi-clickable" tabindex="0" role="button" onclick="openDashboardSummaryDetail('work','monthSchedule',this,'이번 달 내 일정');">
            <div class="ds-kpi-label">이번 달 일정</div>
            <div class="ds-kpi-value"><fmt:formatNumber value="${dashboardSummary.monthScheduleCount}"/>건</div>
            <div class="ds-kpi-sub">클릭해서 월간 일정 목록 확인</div>
        </article>
        <article class="ds-dashboard-card ds-kpi-clickable" tabindex="0" role="button" onclick="openDashboardSummaryDetail('work','dailyPlan',this,'진행 중 일일 계획');">
            <div class="ds-kpi-label">진행 중 일일 계획</div>
            <div class="ds-kpi-value is-green"><fmt:formatNumber value="${empty dashboardSummary.activeDailyPlanCount ? 0 : dashboardSummary.activeDailyPlanCount}"/>건</div>
            <div class="ds-kpi-sub">우선순위·진행률·예상완료일 기준</div>
        </article>
    </section>

    <section id="dashboardSummaryDetail" class="ds-dashboard-card ds-dashboard-summary-detail hidden" aria-live="polite"></section>

    <section class="ds-dashboard-card ds-gantt-card">
        <div class="ds-dashboard-card-head">
            <div>
                <div class="ds-dashboard-card-title">일일 계획 진행 타임라인</div>
                <p class="ds-dashboard-muted mt-1">우선순위, 시작일·예상완료일, 남은 기간과 최신 진행률을 함께 표시합니다.</p>
            </div>
            <a class="ds-dashboard-link" data-authority-code="WORK_DAILY_SCREEN" href="${pageContext.request.contextPath}/worklog/dailyList.do">일일 계획 <i class="fa-solid fa-arrow-right"></i></a>
        </div>
        <c:choose>
            <c:when test="${empty dashboardWorkPlanList}">
                <div class="ds-empty">현재 진행 중인 일일 계획이 없습니다.</div>
            </c:when>
            <c:otherwise>
                <div class="ds-gantt-list">
                    <c:forEach var="item" items="${dashboardWorkPlanList}">
                        <a class="ds-gantt-row" href="${pageContext.request.contextPath}/worklog/dailyList.do" title="일일 계획으로 이동">
                            <div class="ds-gantt-task">
                                <div class="ds-gantt-task-title">
                                    <span class="ds-priority-dot is-p${empty item.priorityNo ? 3 : item.priorityNo}"></span>
                                    <strong><c:out value="${item.workCn}"/></strong>
                                </div>
                                <small><c:out value="${empty item.bizAbrvNm ? (empty item.bizNm ? '공통/기타' : item.bizNm) : item.bizAbrvNm}"/> · P${empty item.priorityNo ? 3 : item.priorityNo}</small>
                            </div>
                            <div class="ds-gantt-visual">
                                <div class="ds-gantt-dates"><span><c:out value="${item.taskBgngYmd}"/></span><span><c:out value="${empty item.exptEndYmd ? '-' : item.exptEndYmd}"/></span></div>
                                <div class="ds-gantt-track"><i style="width:${empty item.prgrsRt ? 0 : item.prgrsRt}%"></i><b style="left:${empty item.prgrsRt ? 0 : item.prgrsRt}%"></b></div>
                            </div>
                            <div class="ds-gantt-status">
                                <strong><fmt:formatNumber value="${empty item.prgrsRt ? 0 : item.prgrsRt}"/>%</strong>
                                <c:choose>
                                    <c:when test="${empty item.exptEndYmd}"><span>완료일 미정</span></c:when>
                                    <c:when test="${item.remainDay lt 0}"><span class="is-overdue">${-item.remainDay}일 지연</span></c:when>
                                    <c:when test="${item.remainDay eq 0}"><span class="is-today">오늘 완료예정</span></c:when>
                                    <c:otherwise><span>D-${item.remainDay}</span></c:otherwise>
                                </c:choose>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <section id="dashboardSmartScheduleWidget" class="bg-brand-card rounded-2xl border border-brand-border shadow-xl overflow-hidden">
        <div class="p-6 border-b border-brand-border bg-slate-950/40 flex flex-col xl:flex-row xl:items-end justify-between gap-4">
            <div>
                <h2 class="text-lg font-bold text-gray-100">스마트 일정 위젯</h2>
                <p class="text-xs text-gray-400">등록된 휴가, 출장, 외근, 회의, 자원예약과 프로젝트 일정을 표시합니다.</p>
            </div>
            <div class="ds-schedule-toolbar">
                <label class="ds-project-filter"><select id="dashScheduleProjectFilter" class="ds-select" aria-label="프로젝트 선택"><option value="">전체 프로젝트</option></select></label>
                <div class="ds-tab-group">
                    <button type="button" data-view-type="all" onclick="changeDashboardScheduleView('all')" class="dash-schedule-tab ds-tab is-active">전체 일정</button>
                    <button type="button" data-view-type="my" onclick="changeDashboardScheduleView('my')" class="dash-schedule-tab ds-tab">내 일정</button>
                    <button type="button" data-view-type="team" onclick="changeDashboardScheduleView('team')" class="dash-schedule-tab ds-tab">팀 일정</button>
                </div>
            </div>
        </div>
        <div class="grid grid-cols-1 lg:grid-cols-12">
            <div class="lg:col-span-7 p-6 border-r border-brand-border bg-slate-950/20">
                <div class="ds-calendar-head">
                    <button type="button" class="ds-icon-btn" onclick="moveDashboardScheduleMonth(-1);">‹</button>
                    <strong id="dashScheduleMonthLabel"></strong>
                    <button type="button" class="ds-icon-btn" onclick="moveDashboardScheduleMonth(1);">›</button>
                </div>
                <div id="dashScheduleCalendarGrid" class="ds-calendar-grid"></div>
                <div id="dashScheduleCalendarLegend" class="ds-calendar-legend">
                    <span><em><i class="ds-dot ds-dot-leave"></i>휴가</em><b data-legend-count="leave">0</b></span>
                    <span><em><i class="ds-dot ds-dot-biztrip"></i>출장</em><b data-legend-count="biztrip">0</b></span>
                    <span><em><i class="ds-dot ds-dot-outside"></i>외근</em><b data-legend-count="outside">0</b></span>
                    <span><em><i class="ds-dot ds-dot-home"></i>재택</em><b data-legend-count="home">0</b></span>
                    <span><em><i class="ds-dot ds-dot-resident"></i>상주</em><b data-legend-count="resident">0</b></span>
                    <span><em><i class="ds-dot ds-dot-meeting"></i>회의</em><b data-legend-count="meeting">0</b></span>
                    <span><em><i class="ds-dot ds-dot-resource"></i>자원예약</em><b data-legend-count="resource">0</b></span>
                    <span><em><i class="ds-dot ds-dot-etc"></i>기타</em><b data-legend-count="etc">0</b></span>
                </div>
            </div>
            <div class="lg:col-span-5 p-6">
                <div class="ds-schedule-list-head">
                    <h3 id="dashScheduleSelectedTitle" class="font-bold text-sm text-gray-300"></h3>
                    <button type="button" class="ds-btn ds-btn-primary" data-authority-code="WORK_SCHEDULE_REG" onclick="openScheduleModal();">+ 새 일정 등록</button>
                </div>
                <div id="dashScheduleDayList" class="ds-schedule-list"></div>
            </div>
        </div>
    </section>

    <section id="dashboardScheduleDetailCard" class="bg-brand-card p-6 rounded-2xl border border-brand-border shadow-xl">
        <div id="dashboardScheduleInlineDetail" class="ds-inline-schedule-detail is-empty">
            <div class="ds-empty"><i class="fa-regular fa-hand-pointer"></i><p>우측 일정의 화살표를 누르면 장소·작성자·상세내용을 확인할 수 있습니다.</p></div>
        </div>
    </section>
    <jsp:include page="/WEB-INF/jsp/common/scheduleModal.jsp"/>
    <jsp:include page="/WEB-INF/jsp/common/userSelectModal.jsp"/>

    <section class="ds-dashboard-columns ds-dashboard-bottom-grid">
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-head">
                <div class="ds-dashboard-card-title">공지사항</div>
                <a class="ds-dashboard-link" data-authority-code="WORK_NOTICE_SCREEN" href="${pageContext.request.contextPath}/notice/noticeList.do">공지사항 <i class="fa-solid fa-arrow-right"></i></a>
            </div>
            <c:choose>
                <c:when test="${empty dashboardNoticeList}"><div class="ds-empty">현재 확인할 공지사항이 없습니다.</div></c:when>
                <c:otherwise>
                    <div class="ds-dashboard-notice-list">
                        <c:forEach var="notice" items="${dashboardNoticeList}">
                            <a class="ds-dashboard-notice-row" href="${pageContext.request.contextPath}/notice/noticeList.do?noticeSn=${notice.noticeSn}">
                                <span class="ds-dashboard-badge ${notice.noticeScopeCd eq 'SYSTEM' ? 'is-warn' : ''}">${notice.noticeScopeCd eq 'SYSTEM' ? '시스템' : '회사'}</span>
                                <strong><c:out value="${notice.noticeTitle}"/></strong>
                                <small><c:out value="${notice.regYmd}"/></small>
                            </a>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </article>

        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-head">
                <div class="ds-dashboard-card-title">오늘 내 일정</div>
                <a class="ds-dashboard-link" data-authority-code="WORK_SCHEDULE_LIST_SCREEN" href="${pageContext.request.contextPath}/schedule/scheduleList.do">일정 관리 <i class="fa-solid fa-arrow-right"></i></a>
            </div>
            <c:choose>
                <c:when test="${empty dashboardPrimaryList}"><div class="ds-empty">오늘 등록된 일정이 없습니다.</div></c:when>
                <c:otherwise>
                    <c:forEach var="item" items="${dashboardPrimaryList}">
                        <button type="button" class="ds-dashboard-row ds-dashboard-row-button" onclick="focusDashboardSchedule('${item.bgngYmd}','my','${item.schdlSn}');">
                            <div><strong><c:out value="${item.schdlNm}"/></strong><small class="ds-dashboard-muted"><c:out value="${empty item.bizNm ? item.placeNm : item.bizNm}"/></small></div>
                            <span class="ds-dashboard-muted"><c:choose><c:when test="${item.allDayYn eq 'Y'}">종일</c:when><c:otherwise><c:out value="${item.bgngTm}"/> ~ <c:out value="${item.endTm}"/></c:otherwise></c:choose></span>
                            <span class="ds-dashboard-badge"><c:out value="${item.schdlSeNm}"/></span>
                        </button>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </article>
    </section>
</div>
