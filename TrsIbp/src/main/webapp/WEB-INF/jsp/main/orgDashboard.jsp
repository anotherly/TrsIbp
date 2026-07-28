<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="ds-dashboard-stack">
    <section class="ds-dashboard-hero">
        <div>
            <p class="ds-dashboard-eyebrow">DevSync Workspace</p>
            <h1>조직 관리 대시보드</h1>
            <p>하위 조직원의 근무, 휴가, 프로젝트 투입률과 업무 진행 상황을 확인합니다.</p>
        </div>
        <div class="ds-dashboard-scope">
            <strong><i class="fa-solid fa-shield-halved"></i> 조회 범위</strong>
            <span>현재 직책에 연결된 하위 본부·부서·팀 범위만 표시</span>
        </div>
    </section>

    <section class="ds-dashboard-kpis">
        <article class="ds-dashboard-card"><div class="ds-kpi-label">하위 조직원</div><div class="ds-kpi-value">32명</div><div class="ds-kpi-sub">개발1팀 11 · 개발2팀 10 · 기술지원 11</div></article>
        <article class="ds-dashboard-card"><div class="ds-kpi-label">오늘 근무</div><div class="ds-kpi-value is-green">27명</div><div class="ds-kpi-sub">휴가 3 · 출장 1 · 재택 1</div></article>
        <article class="ds-dashboard-card"><div class="ds-kpi-label">평균 투입률</div><div class="ds-kpi-value is-cyan">84%</div><div class="ds-kpi-sub"><span class="ds-text-danger">과투입 3명</span> · 미투입 2명</div></article>
        <article class="ds-dashboard-card"><div class="ds-kpi-label">승인 대기</div><div class="ds-kpi-value">6건</div><div class="ds-kpi-sub">휴가 4 · 출장 2</div></article>
    </section>

    <section class="ds-dashboard-columns">
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-head"><div class="ds-dashboard-card-title">조직별 근무·투입 현황</div><span class="ds-dashboard-link">조직원 현황</span></div>
            <div class="ds-dashboard-row"><strong>개발1팀</strong><span class="ds-dashboard-muted">근무 9 / 11명</span><span class="ds-dashboard-badge is-warn">투입 94%</span></div>
            <div class="ds-dashboard-row"><strong>개발2팀</strong><span class="ds-dashboard-muted">근무 9 / 10명</span><span class="ds-dashboard-badge is-ok">투입 81%</span></div>
            <div class="ds-dashboard-row"><strong>기술지원팀</strong><span class="ds-dashboard-muted">근무 9 / 11명</span><span class="ds-dashboard-badge">투입 76%</span></div>
        </article>
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-head"><div class="ds-dashboard-card-title">조직장 빠른 실행</div></div>
            <div class="ds-dashboard-quick">
                <a href="#"><strong><i class="fa-solid fa-circle-check"></i> 승인 대기</strong><span>휴가 · 출장 6건</span></a>
                <a href="#"><strong><i class="fa-solid fa-users"></i> 조직원 조회</strong><span>근무 · 일정 현황</span></a>
                <a href="#"><strong><i class="fa-solid fa-chart-pie"></i> 투입률 확인</strong><span>가용 · 과투입 인력</span></a>
                <a href="#"><strong><i class="fa-solid fa-chart-column"></i> 조직 보고</strong><span>주간 · 월간 현황</span></a>
            </div>
        </article>
    </section>

    <section class="ds-dashboard-thirds">
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-title">과투입 인원</div>
            <div class="ds-dashboard-notice"><strong>김대리 · 120%</strong><small class="ds-text-danger">확인 필요</small><p>3개 프로젝트 동시 참여</p></div>
            <div class="ds-dashboard-notice"><strong>박과장 · 110%</strong><small class="ds-text-warning">주의</small><p>8월 투입계획 조정 필요</p></div>
        </article>
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-title">오늘 주요 일정</div>
            <div class="ds-dashboard-notice"><strong>개발본부 월간회의</strong><small>15:00</small><p>대회의실</p></div>
            <div class="ds-dashboard-notice"><strong>신규입사자 온보딩</strong><small>16:30</small><p>개발1팀</p></div>
        </article>
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-title">지연 작업</div>
            <div class="ds-dashboard-notice"><strong>권한 메뉴 검토</strong><small class="ds-text-danger">2일 지연</small><p>담당 정다빈 · DevSync</p></div>
            <div class="ds-dashboard-notice"><strong>API 명세 승인</strong><small class="ds-text-warning">1일 지연</small><p>담당 이사원 · TBN</p></div>
        </article>
    </section>
</div>
