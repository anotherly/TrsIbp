/**
 * DevSync - IT 개발사 스마트 대시보드 인터랙션 스크립트
 * 파일명: dashboard.js
 * 설명: index.jsp 에서 분리된 대시보드 UI 인터랙션 전용 JS
 *       JSP EL({{}})과 충돌 없이 백틱 템플릿 리터럴 자유롭게 사용 가능
 */

/* ============================================================
   1. 사이드바 아코디언 메뉴 토글
   ============================================================ */
function toggleSubmenu(id) {
    const menu = document.getElementById(id);
    const arrow = document.getElementById('arrow-' + id);

    if (menu.classList.contains('hidden')) {
        menu.classList.remove('hidden');
        arrow.classList.remove('fa-chevron-down');
        arrow.classList.add('fa-chevron-up');
        if (arrow.classList.contains('text-gray-500')) {
            arrow.classList.remove('text-gray-500');
            arrow.classList.add('text-cyan-400');
        }
    } else {
        menu.classList.add('hidden');
        arrow.classList.remove('fa-chevron-up');
        arrow.classList.add('fa-chevron-down');
        arrow.classList.remove('text-cyan-400');
        arrow.classList.add('text-gray-500');
    }
}

/* ============================================================
   2. 출퇴근 실시간 타이머 및 근무 컨트롤 인터랙션
   ============================================================ */
let timerInterval = null;
let totalSeconds = 0;
let isWorking = false;

function setWorkLocation(type) {
    const badge = document.getElementById('work-location-badge');
    badge.innerText = type + ' 근무';

    const types = ['본사', '재택', '외근', '상주'];
    types.forEach(function(loc) {
        const button = document.getElementById('loc-' + loc);
        if (loc === type) {
            button.className = 'py-1 text-xs rounded-lg font-semibold bg-brand-accent text-white border border-brand-accent transition';
        } else {
            button.className = 'py-1 text-xs rounded-lg font-semibold bg-slate-900 text-gray-400 border border-brand-border hover:text-white transition';
        }
    });
}

function triggerCheckIn() {
    if (isWorking) return;

    isWorking = true;
    const checkInBtn  = document.getElementById('btn-checkin');
    const checkOutBtn = document.getElementById('btn-checkout');

    checkInBtn.className  = 'w-full py-2.5 bg-slate-800 text-gray-500 border border-brand-border rounded-xl text-sm font-bold cursor-not-allowed transition flex items-center justify-center gap-2';
    checkInBtn.disabled   = true;

    checkOutBtn.className = 'w-full py-2.5 bg-gradient-to-r from-red-500 to-orange-500 hover:brightness-110 text-white rounded-xl text-sm font-bold shadow-lg shadow-red-500/10 transition flex items-center justify-center gap-2 cursor-pointer';
    checkOutBtn.disabled  = false;

    timerInterval = setInterval(function() {
        totalSeconds++;
        updateTimerDisplay();
    }, 1000);
}

function triggerCheckOut() {
    if (!isWorking) return;

    isWorking = false;
    clearInterval(timerInterval);

    const checkInBtn  = document.getElementById('btn-checkin');
    const checkOutBtn = document.getElementById('btn-checkout');

    checkInBtn.className  = 'w-full py-2.5 bg-gradient-to-r from-emerald-500 to-teal-500 hover:brightness-110 text-white rounded-xl text-sm font-bold shadow-lg shadow-emerald-500/10 transition flex items-center justify-center gap-2 cursor-pointer';
    checkInBtn.disabled   = false;

    checkOutBtn.className = 'w-full py-2.5 bg-slate-800 text-gray-500 border border-brand-border rounded-xl text-sm font-bold cursor-not-allowed transition flex items-center justify-center gap-2';
    checkOutBtn.disabled  = true;

    alert("오늘 하루 수고하셨습니다! 퇴근 처리가 완료되었습니다.");
}

function updateTimerDisplay() {
    const hours   = Math.floor(totalSeconds / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);
    const seconds = totalSeconds % 60;

    const format = function(num) { return String(num).padStart(2, '0'); };
    // ★ 별도 .js 파일이므로 백틱 템플릿 리터럴 자유롭게 사용 가능
    document.getElementById('timer-display').innerText = `${format(hours)} : ${format(minutes)} : ${format(seconds)}`;
}

/* ============================================================
   3. 스마트 일정 위젯 - 퀵 필터 탭 클릭 인터랙션
   ============================================================ */
function filterEvents(category) {
    const tabs = ['all', 'my', 'project', 'team'];

    tabs.forEach(function(tab) {
        const btn = document.getElementById('tab-' + tab);
        if (tab === category) {
            btn.className = 'px-4 py-1.5 text-xs font-semibold rounded-lg text-white bg-brand-accent transition shadow-md';
        } else {
            btn.className = 'px-4 py-1.5 text-xs font-semibold rounded-lg text-gray-400 hover:text-white transition';
        }
    });

    const cards = document.querySelectorAll('.event-card-item');
    cards.forEach(function(card) {
        const cardCategory = card.getAttribute('data-category');
        if (category === 'all' || cardCategory === category) {
            card.style.display = 'flex';
        } else {
            card.style.display = 'none';
        }
    });
}

/* ============================================================
   4. 달력 날짜 변경 및 해당 날짜의 일정 데이터 렌더링
   ============================================================ */
const mockEventsByDate = {
    26: [
        {
            time: "10:00", duration: "30m", cat: "my", catLabel: "스프린트 미팅",
            title: "Daily Scrum & UI/UX 설계안 중간 검토",
            desc: "스프린트 24차 진행도 검수 및 피드백 통합 정리",
            loc: "3층 미팅룸 B", action: true, actionType: "zoom"
        },
        {
            time: "14:00", duration: "1h", cat: "project", catLabel: "인프라/배포",
            title: "PG 결제대행 실서버 핫픽스 배포",
            desc: "모바일 팝업 결제 에러 현상 개선안 마스터 브랜치 배포 예정",
            loc: "DEV-402", action: false
        },
        {
            time: "All Day", duration: "", cat: "team", catLabel: "휴가/재택",
            title: "김민서 Senior Dev - 대체 휴가",
            desc: "주말 정기 배포 장애 대응 온콜(On-Call) 실적에 따른 보상 적립 연차 사용",
            loc: "", action: false,
            avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=60&h=60"
        }
    ],
    27: [
        {
            time: "13:00", duration: "2h", cat: "project", catLabel: "인프라 작업",
            title: "AWS RDS 데이터베이스 마이그레이션",
            desc: "고객 수 증가에 따른 읽기 전용 복제본 스케일 아웃 및 분산 작업",
            loc: "Cloud DB", action: false
        },
        {
            time: "16:00", duration: "1h", cat: "my", catLabel: "정기 회의",
            title: "전사 개발 표준화 테크 세미나",
            desc: "사내 공통 컴포넌트 라이브러리 v2.0 공유 및 토론회",
            loc: "Zoom 온라인 세션", action: true, actionType: "zoom"
        }
    ],
    28: [
        {
            time: "11:00", duration: "1h", cat: "team", catLabel: "클라이언트 미팅",
            title: "네이버 비즈니스 커머스 협력 미팅 (대면)",
            desc: "API 연동 제휴 관련 요구사항 검수 및 일정 협의",
            loc: "1층 고객 미팅 센터", action: false
        }
    ]
};

function selectCalendarDate(day) {
    const label = document.getElementById('timeline-date-label');
    label.innerText = `5월 ${day}일`;   // ★ 외부 JS이므로 백틱 OK

    const dates = [26, 27, 28];
    dates.forEach(function(d) {
        const cell = document.getElementById('cal-date-' + d);
        if (d === day) {
            cell.className = 'text-white py-2 bg-brand-accent/40 border border-brand-accent rounded-lg cursor-pointer relative flex flex-col items-center justify-center font-bold';
        } else {
            cell.className = 'text-gray-300 py-2 hover:bg-slate-900 rounded-lg cursor-pointer relative flex flex-col items-center justify-center';
        }
    });

    const container = document.getElementById('timeline-events-container');
    container.innerHTML = '';

    const events = mockEventsByDate[day];
    if (!events || events.length === 0) {
        container.innerHTML = `
            <div class="text-center py-12 text-xs text-gray-500">
                <i class="fa-regular fa-calendar-xmark text-4xl mb-3 block text-gray-600"></i>
                해당 날짜에 등록된 일정이 없습니다.
            </div>`;
        return;
    }

    events.forEach(function(ev) {
        let borderCol  = 'border-brand-accent';
        let catBadgeCol = 'bg-blue-500/10 border-blue-500/20 text-blue-400';

        if (ev.cat === 'project') {
            borderCol   = 'border-red-500';
            catBadgeCol = 'bg-red-500/10 border-red-500/20 text-red-400';
        } else if (ev.cat === 'team') {
            borderCol   = 'border-emerald-500';
            catBadgeCol = 'bg-emerald-500/10 border-emerald-500/20 text-emerald-400';
        }

        let actionHtml = '';
        if (ev.action && ev.actionType === 'zoom') {
            actionHtml = `
                <a href="https://zoom.us" target="_blank"
                   class="px-3 py-1.5 bg-blue-500 hover:bg-blue-600 text-white rounded-lg text-xs font-bold flex items-center gap-1.5 transition">
                    <i class="fa-solid fa-video"></i> 화상회의
                </a>`;
        } else if (ev.avatar) {
            actionHtml = `<img src="${ev.avatar}" alt="Avatar" class="w-8 h-8 rounded-full border border-emerald-500 object-cover">`;
        }

        const locHtml = ev.loc
            ? `<span class="text-[11px] text-gray-500"><i class="fa-solid fa-map-pin"></i> ${ev.loc}</span>`
            : '';

        // ★ 외부 JS이므로 백틱 템플릿 리터럴 맘껏 사용
        const cardHtml = `
            <div class="event-card-item bg-slate-900 border-l-4 ${borderCol} p-4 rounded-r-xl border-y border-r border-brand-border/60 flex items-center justify-between gap-4"
                 data-category="${ev.cat}">
                <div class="flex items-start gap-4">
                    <div class="text-center font-mono text-xs text-gray-400 bg-slate-950 px-2 py-1.5 rounded-lg border border-brand-border/80">
                        <span class="block text-gray-100 font-bold">${ev.time}</span>
                        <span>${ev.duration}</span>
                    </div>
                    <div>
                        <div class="flex items-center gap-2 mb-1">
                            <span class="px-1.5 py-0.5 ${catBadgeCol} text-[10px] rounded font-bold">${ev.catLabel}</span>
                            ${locHtml}
                        </div>
                        <h4 class="font-bold text-sm text-white">${ev.title}</h4>
                        <p class="text-xs text-gray-400 mt-1">${ev.desc}</p>
                    </div>
                </div>
                <div class="flex items-center gap-2">
                    ${actionHtml}
                </div>
            </div>`;

        container.innerHTML += cardHtml;
    });
}

/* ============================================================
   5. 모달 제어 기능
   ============================================================ */
function openAddEventModal() {
    document.getElementById('add-event-modal').classList.remove('hidden');
}

function closeAddEventModal() {
    document.getElementById('add-event-modal').classList.add('hidden');
}

function addNewEvent(e) {
    e.preventDefault();

    const cat      = document.getElementById('new-event-cat').value;
    const title    = document.getElementById('new-event-title').value;
    const time     = document.getElementById('new-event-time').value;
    const duration = document.getElementById('new-event-duration').value;
    const loc      = document.getElementById('new-event-loc').value;
    const desc     = document.getElementById('new-event-desc').value;

    const catLabelMap = { my: '내 스케줄', project: '프로젝트', team: '부서 휴가/공유' };

    const newEv = {
        time      : time,
        duration  : duration,
        cat       : cat,
        catLabel  : catLabelMap[cat] || '기타',
        title     : title,
        desc      : desc || '회의 상세 안건 공유 예정',
        loc       : loc,
        action    : loc.includes('Zoom'),
        actionType: 'zoom'
    };

    if (!mockEventsByDate[26]) { mockEventsByDate[26] = []; }
    mockEventsByDate[26].push(newEv);

    selectCalendarDate(26);

    document.getElementById('new-event-title').value = '';
    document.getElementById('new-event-desc').value  = '';
    closeAddEventModal();

    alert('새로운 일정이 등록되었습니다.');
}
