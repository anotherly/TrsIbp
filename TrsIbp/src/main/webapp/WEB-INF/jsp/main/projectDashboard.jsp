<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="ds-dashboard-stack">
    <section class="ds-dashboard-hero">
        <div>
            <p class="ds-dashboard-eyebrow">DevSync Workspace</p>
            <h1>프로젝트 관리 대시보드</h1>
            <p>담당 프로젝트의 일정, 계약, 원가, 투입인력과 진행 위험을 한곳에서 관리합니다.</p>
        </div>
        <div class="ds-dashboard-scope">
            <strong><i class="fa-solid fa-shield-halved"></i> 조회 범위</strong>
            <span>본인이 PM·PL로 지정되거나 참여 중인 프로젝트만 표시</span>
        </div>
    </section>

    <section class="ds-dashboard-kpis">
        <article class="ds-dashboard-card">
            <div class="ds-kpi-label">담당 프로젝트</div>
            <div class="ds-kpi-value">3개</div>
            <div class="ds-kpi-sub">정상 2 · <span class="ds-text-warning">주의 1</span></div>
        </article>
        <article class="ds-dashboard-card">
            <div class="ds-kpi-label">평균 진행률</div>
            <div class="ds-kpi-value is-cyan">68%</div>
            <div class="ds-kpi-sub">계획 대비 -4%p</div>
        </article>
        <article class="ds-dashboard-card">
            <div class="ds-kpi-label">투입 인력</div>
            <div class="ds-kpi-value">14명</div>
            <div class="ds-kpi-sub"><span class="ds-text-danger">과투입 2명</span> · 가용 3명</div>
        </article>
        <article class="ds-dashboard-card">
            <div class="ds-kpi-label">미해결 이슈</div>
            <div class="ds-kpi-value">8건</div>
            <div class="ds-kpi-sub"><span class="ds-text-danger">높음 2건</span> · 보통 6건</div>
        </article>
    </section>

    <section class="ds-dashboard-columns">
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-head">
                <div class="ds-dashboard-card-title">담당 프로젝트 진행 현황</div>
                <a class="ds-dashboard-link" href="${pageContext.request.contextPath}/biz/bizList.do">프로젝트 목록 <i class="fa-solid fa-arrow-right"></i></a>
            </div>
            <div class="ds-dashboard-row">
                <div><strong>DevSync 고도화</strong><div class="ds-dashboard-progress"><i style="width:72%"></i></div></div>
                <span class="ds-dashboard-muted">72% / 계획 75%</span><span class="ds-dashboard-badge is-ok">정상</span>
            </div>
            <div class="ds-dashboard-row">
                <div><strong>TBN 연계 개발</strong><div class="ds-dashboard-progress"><i style="width:54%"></i></div></div>
                <span class="ds-dashboard-muted">54% / 계획 61%</span><span class="ds-dashboard-badge is-warn">주의</span>
            </div>
            <div class="ds-dashboard-row">
                <div><strong>데이터센터 유지관리</strong><div class="ds-dashboard-progress"><i style="width:81%"></i></div></div>
                <span class="ds-dashboard-muted">81% / 계획 80%</span><span class="ds-dashboard-badge is-ok">정상</span>
            </div>
        </article>
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-head"><div class="ds-dashboard-card-title">프로젝트 빠른 실행</div></div>
            <div class="ds-dashboard-quick">
                <a href="${pageContext.request.contextPath}/biz/bizList.do"><strong><i class="fa-solid fa-diagram-project"></i> 사업 관리</strong><span>목록 · 상세 · 등록</span></a>
                <a href="${pageContext.request.contextPath}/biz/contractList.do"><strong><i class="fa-solid fa-file-signature"></i> 계약 관리</strong><span>계약 · 고객사 · 이력</span></a>
                <a href="${pageContext.request.contextPath}/biz/mnpwList.do"><strong><i class="fa-solid fa-people-group"></i> 투입인력</strong><span>기간 · M/M · 역할</span></a>
                <a href="${pageContext.request.contextPath}/biz/schdlList.do"><strong><i class="fa-solid fa-list-check"></i> 프로세스</strong><span>작업 · 일정 · 산출물</span></a>
            </div>
        </article>
    </section>

    <section class="ds-dashboard-thirds">
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-title">마일스톤</div>
            <div class="ds-dashboard-notice"><strong>권한 구조 확정</strong><small class="ds-text-warning">D-2</small><p>업무공간별 화면 및 기능 검토</p></div>
            <div class="ds-dashboard-notice"><strong>계약관리 개발 완료</strong><small>D-14</small><p>통합 테스트 포함</p></div>
        </article>
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-title">인력 부하</div>
            <div class="ds-dashboard-notice"><strong>김대리 · 120%</strong><small class="ds-text-danger">과투입</small><p>프로젝트 3개 중복</p></div>
            <div class="ds-dashboard-notice"><strong>이사원 · 60%</strong><small class="ds-text-success">가용</small><p>8월부터 40% 추가 가능</p></div>
        </article>
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-title">비용 요약</div>
            <div class="ds-dashboard-notice"><strong>직접비 집행률</strong><small>62%</small><p>예산 8,000만 / 집행 4,960만</p></div>
            <div class="ds-dashboard-notice"><strong>예상 손익률</strong><small class="ds-text-success">18.4%</small><p>개인 급여·개인원가는 권한에 따라 비공개</p></div>
        </article>
    </section>
</div>
