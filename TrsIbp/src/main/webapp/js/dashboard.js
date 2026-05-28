/**
 * DevSync - IT 개발사 스마트 대시보드 인터랙션 스크립트
 * 파일명: dashboard.js
 * 설명: index.jsp 에서 분리된 대시보드 UI 인터랙션 전용 JS
 *       JSP EL과 충돌 없이 백틱 템플릿 리터럴 자유롭게 사용 가능
 * 최종수정: 2026-05-28 - 출퇴근 AJAX 서버 연동 추가
 */

/* ============================================================
   0. 전역 변수
   ============================================================ */
let timerInterval  = null;
let totalSeconds   = 0;
let isWorking      = false;       // 현재 출근 중 여부
let isCheckedOut   = false;       // 오늘 퇴근 완료 여부
let currentWorkLoc = 'OFFICE';    // 현재 근무지 (OFFICE/HOME/OUTSIDE)

// 컨텍스트 경로 (JSP에서 주입, 없으면 기본값 '')
// index.jsp에서 <script> var ctxPath = '<%=request.getContextPath()%>'; </script> 로 주입
var ctxPath = (typeof ctxPath !== 'undefined') ? ctxPath : '';


/* ============================================================
   1. 사이드바 아코디언 메뉴 토글
   ============================================================ */
function toggleSubmenu(id) {
    const menu  = document.getElementById(id);
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
   2. 근무지 선택 (UI + AJAX)
   ============================================================ */
// 근무지 한글 ↔ 영문 코드 매핑
var locKrToEn = { '본사': 'OFFICE', '재택': 'HOME', '외근': 'OUTSIDE', '상주': 'OUTSIDE' };
var locEnToKr = { 'OFFICE': '본사', 'HOME': '재택', 'OUTSIDE': '외근' };

function setWorkLocation(type) {
    const badge   = document.getElementById('work-location-badge');
    const locCode = locKrToEn[type] || 'OFFICE';

    badge.innerText    = type + ' 근무';
    currentWorkLoc     = locCode;

    const types = ['본사', '재택', '외근', '상주'];
    types.forEach(function(loc) {
        const btn = document.getElementById('loc-' + loc);
        if (loc === type) {
            btn.className = 'py-1 text-xs rounded-lg font-semibold bg-brand-accent text-white border border-brand-accent transition';
        } else {
            btn.className = 'py-1 text-xs rounded-lg font-semibold bg-slate-900 text-gray-400 border border-brand-border hover:text-white transition';
        }
    });

    // 출근 중일 때만 서버에 근무지 변경 반영
    if (isWorking) {
        $.ajax({
            url     : ctxPath + '/attend/workLocation.ajax',
            type    : 'POST',
            data    : { workLocation: locCode },
            dataType: 'json',
            success : function(data) {
                if (data.result === 'OK') {
                    showToast('근무지가 [' + type + ']으로 변경되었습니다.', 'info');
                }
            }
        });
    }
}


/* ============================================================
   3. 출근 처리 (AJAX → 서버 저장 → UI 업데이트)
   ============================================================ */
function triggerCheckIn() {
    if (isWorking || isCheckedOut) return;

    $.ajax({
        url     : ctxPath + '/attend/checkIn.ajax',
        type    : 'POST',
        data    : { workLocation: currentWorkLoc },
        dataType: 'json',
        success : function(data) {
            if (data.result === 'OK') {
                isWorking = true;
                startTimer(0);
                updateCheckInUI(data.checkInTime);
                showToast('출근 처리 완료! (' + data.checkInTime + ')', 'success');
            } else if (data.result === 'ALREADY_CHECKED_IN') {
                isWorking = true;
                showToast('이미 출근 처리가 되어 있습니다. (' + data.checkInTime + ')', 'info');
                updateCheckInUI(data.checkInTime);
            } else {
                showToast('출근 처리 중 오류가 발생했습니다.', 'error');
            }
        },
        error: function() {
            showToast('서버와 통신 중 오류가 발생했습니다.', 'error');
        }
    });
}

function updateCheckInUI(checkInTime) {
    const checkInBtn  = document.getElementById('btn-checkin');
    const checkOutBtn = document.getElementById('btn-checkout');
    const infoSpan    = document.getElementById('checkin-time-display');

    // 출근 버튼 비활성화
    checkInBtn.className = 'w-full py-2.5 bg-slate-800 text-gray-500 border border-brand-border rounded-xl text-sm font-bold cursor-not-allowed transition flex items-center justify-center gap-2';
    checkInBtn.disabled  = true;

    // 퇴근 버튼 활성화
    checkOutBtn.className = 'w-full py-2.5 bg-gradient-to-r from-red-500 to-orange-500 hover:brightness-110 text-white rounded-xl text-sm font-bold shadow-lg shadow-red-500/10 transition flex items-center justify-center gap-2 cursor-pointer';
    checkOutBtn.disabled  = false;

    // 출근 시간 표시
    if (infoSpan && checkInTime) {
        infoSpan.innerText = '출근: ' + checkInTime;
    }
}


/* ============================================================
   4. 퇴근 처리 (AJAX → 서버 저장 → UI 업데이트)
   ============================================================ */
function triggerCheckOut() {
    if (!isWorking || isCheckedOut) return;

    if (!confirm('퇴근 처리 하시겠습니까?')) return;

    $.ajax({
        url     : ctxPath + '/attend/checkOut.ajax',
        type    : 'POST',
        dataType: 'json',
        success : function(data) {
            if (data.result === 'OK') {
                isWorking    = false;
                isCheckedOut = true;
                stopTimer();
                updateCheckOutUI(data.checkOutTime, data.workMinutes);
                showToast('퇴근 처리 완료! 오늘도 수고하셨습니다 😊', 'success');
            } else if (data.result === 'NO_CHECK_IN') {
                showToast('출근 기록이 없습니다. 먼저 출근 처리를 해주세요.', 'error');
            } else if (data.result === 'ALREADY_CHECKED_OUT') {
                showToast('이미 퇴근 처리가 완료되었습니다.', 'info');
                isWorking    = false;
                isCheckedOut = true;
                stopTimer();
                updateCheckOutUI(data.checkOutTime, data.workMinutes);
            } else {
                showToast('퇴근 처리 중 오류가 발생했습니다.', 'error');
            }
        },
        error: function() {
            showToast('서버와 통신 중 오류가 발생했습니다.', 'error');
        }
    });
}

function updateCheckOutUI(checkOutTime, workMinutes) {
    const checkInBtn  = document.getElementById('btn-checkin');
    const checkOutBtn = document.getElementById('btn-checkout');
    const outSpan     = document.getElementById('checkout-time-display');
    const workTimeSpan= document.getElementById('work-time-display');

    // 두 버튼 모두 비활성화 (오늘 퇴근 완료)
    checkInBtn.className  = 'w-full py-2.5 bg-slate-800 text-gray-500 border border-brand-border rounded-xl text-sm font-bold cursor-not-allowed transition flex items-center justify-center gap-2';
    checkInBtn.disabled   = true;
    checkOutBtn.className = 'w-full py-2.5 bg-slate-800 text-gray-500 border border-brand-border rounded-xl text-sm font-bold cursor-not-allowed transition flex items-center justify-center gap-2';
    checkOutBtn.disabled  = true;

    if (outSpan && checkOutTime) {
        outSpan.innerText = '퇴근: ' + checkOutTime;
    }
    // 근무시간 표시 (분 → 시간:분)
    if (workTimeSpan && workMinutes) {
        const mins = parseInt(workMinutes) || 0;
        const h    = Math.floor(mins / 60);
        const m    = mins % 60;
        workTimeSpan.innerText = `총 ${h}시간 ${m}분 근무`;
    }
}


/* ============================================================
   5. 실시간 타이머
   ============================================================ */
function startTimer(initSeconds) {
    totalSeconds  = initSeconds || 0;
    clearInterval(timerInterval);
    timerInterval = setInterval(function() {
        totalSeconds++;
        updateTimerDisplay();
    }, 1000);
}

function stopTimer() {
    clearInterval(timerInterval);
    timerInterval = null;
}

function updateTimerDisplay() {
    const hours   = Math.floor(totalSeconds / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);
    const seconds = totalSeconds % 60;
    const format  = function(num) { return String(num).padStart(2, '0'); };

    // ★ 외부 .js 파일이므로 백틱 템플릿 리터럴 자유롭게 사용 가능
    const timerEl = document.getElementById('timer-display');
    if (timerEl) {
        timerEl.innerText = `${format(hours)} : ${format(minutes)} : ${format(seconds)}`;
    }
}


/* ============================================================
   6. 페이지 로드 시 오늘 출퇴근 현황 조회 (AJAX)
   ============================================================ */
function loadTodayAttendStatus() {
    $.ajax({
        url     : ctxPath + '/attend/todayStatus.ajax',
        type    : 'GET',
        dataType: 'json',
        success : function(data) {
            if (data.result === 'NO_SESSION') {
                // 세션 만료 → 로그인 페이지로
                window.location.href = ctxPath + '/user/login.do';
                return;
            }

            if (data.result === 'OK') {
                if (data.checkInTime && data.checkInTime !== '') {
                    // 출근 기록 있음
                    isWorking = true;
                    updateCheckInUI(data.checkInTime);

                    if (data.checkOutTime && data.checkOutTime !== '') {
                        // 퇴근까지 완료
                        isWorking    = false;
                        isCheckedOut = true;
                        stopTimer();
                        updateCheckOutUI(data.checkOutTime, data.workMinutes);
                    } else {
                        // 출근만 한 상태 → 타이머 시작 (분 → 초로 변환)
                        const elapsedSec = (parseInt(data.workMinutes) || 0) * 60;
                        startTimer(elapsedSec);
                    }
                }

                // 근무지 UI 동기화
                if (data.workLocation) {
                    const locKr = locEnToKr[data.workLocation] || '본사';
                    setWorkLocationUI(locKr);
                }
            }
            // NO_RECORD이면 초기 상태 유지 (출근 전)
        },
        error: function() {
            console.warn('출퇴근 현황 조회 실패');
        }
    });
}

// UI만 업데이트 (AJAX 없이 - 근무지 표시 동기화용)
function setWorkLocationUI(type) {
    const badge   = document.getElementById('work-location-badge');
    const locCode = locKrToEn[type] || 'OFFICE';
    if (badge) badge.innerText = type + ' 근무';
    currentWorkLoc = locCode;

    const types = ['본사', '재택', '외근', '상주'];
    types.forEach(function(loc) {
        const btn = document.getElementById('loc-' + loc);
        if (!btn) return;
        if (loc === type) {
            btn.className = 'py-1 text-xs rounded-lg font-semibold bg-brand-accent text-white border border-brand-accent transition';
        } else {
            btn.className = 'py-1 text-xs rounded-lg font-semibold bg-slate-900 text-gray-400 border border-brand-border hover:text-white transition';
        }
    });
}


/* ============================================================
   7. Toast 알림 메시지
   ============================================================ */
function showToast(msg, type) {
    // 기존 토스트 제거
    var existing = document.getElementById('devsync-toast');
    if (existing) existing.remove();

    var colorMap = {
        'success': 'bg-emerald-500/90 border-emerald-400',
        'error'  : 'bg-red-500/90 border-red-400',
        'info'   : 'bg-blue-500/90 border-blue-400'
    };
    var iconMap = {
        'success': 'fa-circle-check',
        'error'  : 'fa-circle-xmark',
        'info'   : 'fa-circle-info'
    };

    var colorClass = colorMap[type] || colorMap['info'];
    var iconClass  = iconMap[type]  || iconMap['info'];

    var toast = document.createElement('div');
    toast.id  = 'devsync-toast';
    toast.style.cssText = 'position:fixed;bottom:24px;right:24px;z-index:9999;transition:opacity 0.3s;';
    toast.innerHTML = `
        <div class="${colorClass} border text-white text-sm font-semibold px-5 py-3 rounded-xl shadow-2xl flex items-center gap-3 backdrop-blur-sm">
            <i class="fa-solid ${iconClass}"></i>
            <span>${msg}</span>
        </div>`;
    document.body.appendChild(toast);

    setTimeout(function() {
        toast.style.opacity = '0';
        setTimeout(function() { toast.remove(); }, 300);
    }, 3000);
}


/* ============================================================
   8. 스마트 일정 위젯 - 퀵 필터 탭 클릭 인터랙션
   ============================================================ */
function filterEvents(category) {
    var tabs = ['all', 'my', 'project', 'team'];
    tabs.forEach(function(tab) {
        var btn = document.getElementById('tab-' + tab);
        if (!btn) return;
        if (tab === category) {
            btn.className = 'px-4 py-1.5 text-xs font-semibold rounded-lg text-white bg-brand-accent transition shadow-md';
        } else {
            btn.className = 'px-4 py-1.5 text-xs font-semibold rounded-lg text-gray-400 hover:text-white transition';
        }
    });

    var cards = document.querySelectorAll('.event-card-item');
    cards.forEach(function(card) {
        var cardCategory = card.getAttribute('data-category');
        if (category === 'all' || cardCategory === category) {
            card.style.display = 'flex';
        } else {
            card.style.display = 'none';
        }
    });
}


/* ============================================================
   9. 달력 날짜 변경 및 해당 날짜의 일정 데이터 렌더링
   ============================================================ */
var mockEventsByDate = {
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
    var label = document.getElementById('timeline-date-label');
    if (label) label.innerText = `5월 ${day}일`;   // ★ 외부 JS이므로 백틱 OK

    var dates = [26, 27, 28];
    dates.forEach(function(d) {
        var cell = document.getElementById('cal-date-' + d);
        if (!cell) return;
        if (d === day) {
            cell.className = 'text-white py-2 bg-brand-accent/40 border border-brand-accent rounded-lg cursor-pointer relative flex flex-col items-center justify-center font-bold';
        } else {
            cell.className = 'text-gray-300 py-2 hover:bg-slate-900 rounded-lg cursor-pointer relative flex flex-col items-center justify-center';
        }
    });

    var container = document.getElementById('timeline-events-container');
    if (!container) return;
    container.innerHTML = '';

    var events = mockEventsByDate[day];
    if (!events || events.length === 0) {
        container.innerHTML = `
            <div class="text-center py-12 text-xs text-gray-500">
                <i class="fa-regular fa-calendar-xmark text-4xl mb-3 block text-gray-600"></i>
                해당 날짜에 등록된 일정이 없습니다.
            </div>`;
        return;
    }

    events.forEach(function(ev) {
        var borderCol   = 'border-brand-accent';
        var catBadgeCol = 'bg-blue-500/10 border-blue-500/20 text-blue-400';

        if (ev.cat === 'project') {
            borderCol   = 'border-red-500';
            catBadgeCol = 'bg-red-500/10 border-red-500/20 text-red-400';
        } else if (ev.cat === 'team') {
            borderCol   = 'border-emerald-500';
            catBadgeCol = 'bg-emerald-500/10 border-emerald-500/20 text-emerald-400';
        }

        var actionHtml = '';
        if (ev.action && ev.actionType === 'zoom') {
            actionHtml = `
                <a href="https://zoom.us" target="_blank"
                   class="px-3 py-1.5 bg-blue-500 hover:bg-blue-600 text-white rounded-lg text-xs font-bold flex items-center gap-1.5 transition">
                    <i class="fa-solid fa-video"></i> 화상회의
                </a>`;
        } else if (ev.avatar) {
            actionHtml = `<img src="${ev.avatar}" alt="Avatar" class="w-8 h-8 rounded-full border border-emerald-500 object-cover">`;
        }

        var locHtml = ev.loc
            ? `<span class="text-[11px] text-gray-500"><i class="fa-solid fa-map-pin"></i> ${ev.loc}</span>`
            : '';

        var cardHtml = `
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
   10. 일정 추가 모달 제어
   ============================================================ */
function openAddEventModal() {
    var modal = document.getElementById('add-event-modal');
    if (modal) modal.classList.remove('hidden');
}

function closeAddEventModal() {
    var modal = document.getElementById('add-event-modal');
    if (modal) modal.classList.add('hidden');
}

function addNewEvent(e) {
    e.preventDefault();

    var cat      = document.getElementById('new-event-cat').value;
    var title    = document.getElementById('new-event-title').value;
    var time     = document.getElementById('new-event-time').value;
    var duration = document.getElementById('new-event-duration').value;
    var loc      = document.getElementById('new-event-loc').value;
    var desc     = document.getElementById('new-event-desc').value;

    var catLabelMap = { my: '내 스케줄', project: '프로젝트', team: '부서 휴가/공유' };

    var newEv = {
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
    showToast('새로운 일정이 등록되었습니다.', 'success');
}


/* ============================================================
   11. 페이지 초기화 (DOM 로드 완료 후 실행)
   ============================================================ */
document.addEventListener('DOMContentLoaded', function() {
    // 오늘 출퇴근 현황 서버 조회
    loadTodayAttendStatus();
});
