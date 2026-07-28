<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="ds-dashboard-stack">
    <section class="ds-dashboard-hero">
        <div>
            <p class="ds-dashboard-eyebrow">DevSync Workspace</p>
            <h1>경영 관리 대시보드</h1>
            <p>인사, 근태, 계약, 회계와 구매·자산의 주요 처리 현황을 종합합니다.</p>
        </div>
        <div class="ds-dashboard-scope">
            <strong><i class="fa-solid fa-shield-halved"></i> 조회 범위</strong>
            <span>부여된 경영 세부권한과 회사 범위에 해당하는 정보만 표시</span>
        </div>
    </section>

    <section class="ds-dashboard-kpis">
        <article class="ds-dashboard-card"><div class="ds-kpi-label">재직 인원</div><div class="ds-kpi-value">86명</div><div class="ds-kpi-sub">입사 예정 2 · 퇴사 예정 1</div></article>
        <article class="ds-dashboard-card"><div class="ds-kpi-label">승인 대기</div><div class="ds-kpi-value is-amber">12건</div><div class="ds-kpi-sub">인사 4 · 계약 3 · 구매 5</div></article>
        <article class="ds-dashboard-card"><div class="ds-kpi-label">미수금</div><div class="ds-kpi-value">1.8억</div><div class="ds-kpi-sub"><span class="ds-text-danger">기한 초과 2건</span></div></article>
        <article class="ds-dashboard-card"><div class="ds-kpi-label">당월 구매</div><div class="ds-kpi-value">23건</div><div class="ds-kpi-sub">요청 8 · 완료 15</div></article>
    </section>

    <section class="ds-dashboard-columns">
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-head"><div class="ds-dashboard-card-title">경영 업무 처리 현황</div><span class="ds-dashboard-link">승인 관리</span></div>
            <div class="ds-dashboard-row"><strong>근태 마감</strong><span class="ds-dashboard-muted">7월 전 직원</span><span class="ds-dashboard-badge is-warn">D-3</span></div>
            <div class="ds-dashboard-row"><strong>계약 갱신</strong><span class="ds-dashboard-muted">데이터센터 유지관리</span><span class="ds-dashboard-badge is-danger">검토 필요</span></div>
            <div class="ds-dashboard-row"><strong>구매 승인</strong><span class="ds-dashboard-muted">개발 노트북 4대</span><span class="ds-dashboard-badge">대기</span></div>
        </article>
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-head"><div class="ds-dashboard-card-title">경영 빠른 실행</div></div>
            <div class="ds-dashboard-quick">
                <a href="${pageContext.request.contextPath}/user/empList.do"><strong><i class="fa-solid fa-id-card"></i> 인사 관리</strong><span>사용자 · 인사정보</span></a>
                <a href="${pageContext.request.contextPath}/biz/contractList.do"><strong><i class="fa-solid fa-file-signature"></i> 계약 관리</strong><span>계약 · 고객사 · 이력</span></a>
                <a href="${pageContext.request.contextPath}/biz/accountList.do"><strong><i class="fa-solid fa-coins"></i> 회계·손익</strong><span>비용 · 수금 · 손익</span></a>
                <a href="#"><strong><i class="fa-solid fa-boxes-stacked"></i> 구매·자산</strong><span>요청 · 지급 · 반납</span></a>
            </div>
        </article>
    </section>

    <section class="ds-dashboard-thirds">
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-title">계약·수금</div>
            <div class="ds-dashboard-notice"><strong>신규 계약</strong><small>3건</small><p>이번 달 계약금액 4.2억</p></div>
            <div class="ds-dashboard-notice"><strong>수금 예정</strong><small>D-5</small><p>TBN 연계 8,000만원</p></div>
        </article>
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-title">인사·근태</div>
            <div class="ds-dashboard-notice"><strong>휴가 신청 대기</strong><small class="ds-text-warning">4건</small><p>담당자 검토 후 승인 요청</p></div>
            <div class="ds-dashboard-notice"><strong>인사서류 미제출</strong><small class="ds-text-danger">2명</small><p>민감서류는 인사 권한만 열람</p></div>
        </article>
        <article class="ds-dashboard-card">
            <div class="ds-dashboard-card-title">사업 손익</div>
            <div class="ds-dashboard-notice"><strong>평균 예상 손익률</strong><small class="ds-text-success">16.2%</small><p>진행 사업 14개 기준</p></div>
            <div class="ds-dashboard-notice"><strong>손익 주의 사업</strong><small class="ds-text-danger">2개</small><p>직접비 증가 원인 확인 필요</p></div>
        </article>
    </section>
</div>
