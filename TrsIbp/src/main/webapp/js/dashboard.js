/**
 * DevSync - IT 개발사 스마트 대시보드 인터랙션 스크립트
 * 파일명: dashboard.js
 * 설명: index.jsp 비동기 통신 및 UI 제어 전용 스크립트 (jQuery 기반)
 * 수정이력: 2026-05-28 - 자동 출근 연동 및 근무지 상태 제어 함수 추가
 */

/* ============================================================
   0. 전역 변수 및 초기화 설정
   ============================================================ */
let timerInterval  = null;
let totalSeconds   = 0;
let isWorking      = false;       // 현재 근무 상태 플래그
let isCheckedOut   = false;       // 당일 마감 상태 플래그
let currentWorkLoc = 'OFFICE';    // 기본 근무지 코드 (OFFICE/HOME/OUTSIDE)

// JSP ContextPath 주입 확인 (미정의 시 기본값 빈 문자열 처리)
var ctxPath = (typeof ctxPath !== 'undefined') ? ctxPath : '';


/* ============================================================
   1. 당일 근태 현황 초기 조회 (AJAX GET)
   ============================================================ */
function loadTodayAttendStatus() {
    $.ajax({
        url     : ctxPath + '/attend/todayStatus.ajax',
        type    : 'GET',
        dataType: 'json',
        success : function(data) {
            // 세션 만료 시 로그인 페이지로 리다이렉트
            if (data.result === 'NO_SESSION') {
                window.location.href = ctxPath + '/login/login.do';
                return;
            }

            // 당일 자동 출근 기록이 존재하는 경우
            if (data.result === 'OK') {
                isWorking = true;

                if (data.checkInTime && data.checkInTime !== '') {
                    // 출근 인증 시각 표시
                    $('#checkin-time-display').text('출근 인증 : ' + data.checkInTime);
                    
                    // 초기 버튼 활성화 상태 세팅 (출근 잠금, 퇴근/외근 활성화)
                    $('#btn-checkout').prop('disabled', false)
                        .removeClass('bg-slate-800 text-gray-500 border-brand-border cursor-not-allowed')
                        .addClass('bg-gradient-to-r from-red-500 to-orange-500 hover:brightness-110 text-white shadow-lg shadow-red-500/10 cursor-pointer');
                    
                    $('#btn-outside').prop('disabled', false)
                        .removeClass('bg-slate-800 text-gray-500 border-brand-border cursor-not-allowed')
                        .addClass('bg-slate-900 text-gray-200 border-brand-border hover:text-white transition cursor-pointer');

                    // 퇴근 마감까지 완료된 경우
                    if (data.checkOutTime && data.checkOutTime !== '') {
                        isWorking    = false;
                        isCheckedOut = true;
                        stopTimer();
                        updateCheckOutUI(data.checkOutTime, data.workMinutes);
                    } else {
                        // 근무 중인 경우: 서버 출근 시각 기준으로 실시간 타이머 오차 보정 연산
                        try {
                            const parsedCheckIn = new Date(data.checkInTime.replace(/-/g, '/'));
                            const now = new Date();
                            const elapsedSec = Math.floor((now.getTime() - parsedCheckIn.getTime()) / 1000);
                            
                            if (elapsedSec > 0) {
                                startTimer(elapsedSec);
                            } else {
                                startTimer(0);
                            }
                        } catch (e) {
                            // 날짜 객체 파싱 예외 발생 시 백엔드 계산값(분) 백업 적용
                            const elapsedSec = (parseInt(data.workMinutes) || 0) * 60;
                            startTimer(elapsedSec);
                        }
                    }
                }

                // 근무지 코드에 따른 UI 상태 동기화
                if (data.workLocation) {
                    setWorkLocationUI(data.workLocation);
                }
            }
        },
        error: function() {
            console.warn('▶ [DevSync] 당일 근태 데이터 로드 실패 (통신 오류)');
        }
    });
}


/* ============================================================
   2. 외근 / 출장 비동기 전환 처리 (AJAX POST)
   ============================================================ */
function toggleOutsideWork(status) {
    if (!isWorking || isCheckedOut) return;

    // GO: 외근/출장 출발, BACK: 회사 복귀
    const targetLoc = (status === 'GO') ? 'OUTSIDE' : 'OFFICE';
    
    $.ajax({
        url      : ctxPath + '/attend/changeStatus.ajax',
        type     : 'POST',
        data     : { workLocation : targetLoc },
        dataType : 'json',
        success  : function(data) {
            if (data.result === 'OK') {
                setWorkLocationUI(targetLoc);
                if (targetLoc === 'OUTSIDE') {
                    showToast('외근/출장 상태로 변경되었습니다.', 'info');
                } else {
                    showToast('사무실 복귀가 반영되었습니다.', 'success');
                }
            } else {
                showToast('상태 변경 중 오류가 발생했습니다.', 'error');
            }
        },
        error: function() {
            showToast('서버 통신 장애로 인해 상태 변경에 실패했습니다.', 'error');
        }
    });
}

// 근무지 상태값에 따른 상단 배지 및 토글 UI 변경
function setWorkLocationUI(locCode) {
    currentWorkLoc = locCode;
    const $badge = $('#work-location-badge');
    const $btnOutside = $('#btn-outside');

    if (locCode === 'OUTSIDE') {
        $badge.text('외근/출장 중').removeClass('bg-brand-accent/15 text-brand-neonBlue').addClass('bg-orange-500/15 text-orange-400');
        $btnOutside.html('<i class="fa-solid fa-house"></i> 본사복귀 완료');
        $btnOutside.attr('onclick', "toggleOutsideWork('BACK')");
    } else {
        $badge.text('본사 근무').removeClass('bg-orange-500/15 text-orange-400').addClass('bg-brand-accent/15 text-brand-neonBlue');
        $btnOutside.html('<i class="fa-solid fa-briefcase"></i> 외근/출장 출발');
        $btnOutside.attr('onclick', "toggleOutsideWork('GO')");
    }

    // 하단 라디오 칩스 동기화 선택 처리
    const types = ['OFFICE', 'HOME'];
    types.forEach(function(loc) {
        const $btn = $('#loc-' + loc);
        if (!$btn.length) return;
        if (loc === locCode) {
            $btn.attr('class', 'py-1 text-xs rounded-lg font-semibold bg-brand-accent text-white border border-brand-accent transition');
        } else {
            $btn.attr('class', 'py-1 text-xs rounded-lg font-semibold bg-slate-900 text-gray-400 border border-brand-border hover:text-white transition');
        }
    });
}


/* ============================================================
   3. 퇴근 마감 처리 (AJAX POST)
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
                showToast('퇴근 처리가 마감되었습니다.', 'success');
            } else if (data.result === 'ALREADY_CHECKED_OUT') {
                isWorking    = false;
                isCheckedOut = true;
                stopTimer();
                updateCheckOutUI(data.checkOutTime, data.workMinutes);
                showToast('이미 퇴근 마감된 레코드입니다.', 'info');
            } else {
                showToast(data.msg || '퇴근 처리 중 오류가 발생했습니다.', 'error');
            }
        },
        error: function() {
            showToast('서버 통신 장애로 인해 퇴근 마감에 실패했습니다.', 'error');
        }
    });
}

// 퇴근 마감 완료에 따른 제어 장치 전면 잠금
function updateCheckOutUI(checkOutTime, workMinutes) {
    $('#btn-checkout, #btn-outside')
        .prop('disabled', true)
        .removeClass('from-red-500 to-orange-500 hover:brightness-110 cursor-pointer shadow-lg hover:text-white transition')
        .addClass('bg-slate-800 text-gray-500 border-brand-border cursor-not-allowed');

    if (checkOutTime) {
        $('#checkout-time-display').text('퇴근 마감 : ' + checkOutTime.substring(11, 16));
    }
    
    if (workMinutes) {
        const mins = parseInt(workMinutes) || 0;
        const h    = Math.floor(mins / 60);
        const m    = mins % 60;
        $('#work-time-display').html(`<span class="text-brand-neonBlue font-bold">확정 근무시간: ${h}시간 ${m}분</span>`);
    }
}


/* ============================================================
   4. 실시간 누적 근무 시간 타이머 엔진
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

    $('#timer-display').text(`${format(hours)} : ${format(minutes)} : ${format(seconds)}`);
}


/* ============================================================
   5. 아코디언 서브메뉴 토글 함수
   ============================================================ */
function toggleSubmenu(id) {
    const $menu  = $('#' + id);
    const $arrow = $('#arrow-' + id);

    if ($menu.hasClass('hidden')) {
        $menu.removeClass('hidden');
        $arrow.removeClass('fa-chevron-down text-gray-500').addClass('fa-chevron-up text-cyan-400');
    } else {
        $menu.addClass('hidden');
        $arrow.removeClass('fa-chevron-up text-cyan-400').addClass('fa-chevron-down text-gray-500');
    }
}


/* ============================================================
   6. 대시보드 공통 알림 컴포넌트 (Toast 메커니즘)
   ============================================================ */
function showToast(msg, type) {
    $('#devsync-toast').remove();

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
        setTimeout(function() { $(toast).remove(); }, 300);
    }, 3000);
}


/* ============================================================
   7. 일정 스케줄러 분류 퀵 필터링 제어
   ============================================================ */
function filterEvents(category) {
    var tabs = ['all', 'my', 'project', 'team'];
    tabs.forEach(function(tab) {
        var $btn = $('#tab-' + tab);
        if (!$btn.length) return;
        if (tab === category) {
            $btn.attr('class', 'px-4 py-1.5 text-xs font-semibold rounded-lg text-white bg-brand-accent transition shadow-md');
        } else {
            $btn.attr('class', 'px-4 py-1.5 text-xs font-semibold rounded-lg text-gray-400 hover:text-white transition');
        }
    });

    $('.event-card-item').each(function() {
        var cardCategory = $(this).attr('data-category');
        if (category === 'all' || cardCategory === category) {
            $(this).css('display', 'flex');
        } else {
            $(this).css('display', 'none');
        }
    });
}


/* ============================================================
   8. 달력 일자 변경 및 타임라인 동적 빌드 (임시 목업 데이터 적용)
   ============================================================ */
var mockEventsByDate = {
    26: [
        { time: "10:00", duration: "30m", cat: "my", catLabel: "스프린트 미팅", title: "Daily Scrum & UI/UX 설계안 중간 검토", desc: "스프린트 24차 진행도 검수 및 피드백 통합 정리", loc: "3층 미팅룸 B", action: true, actionType: "zoom" },
        { time: "14:00", duration: "1h", cat: "project", catLabel: "인프라/배포", title: "PG 결제대행 실서버 핫픽스 배포", desc: "모바일 팝업 결제 에러 현상 개선안 마스터 브랜치 배포 예정", loc: "DEV-402", action: false },
        { time: "All Day", duration: "", cat: "team", catLabel: "휴가/재택", title: "김민서 Senior Dev - 대체 휴가", desc: "주말 정기 배포 장애 대응 온콜(On-Call) 실적에 따른 보상 적립 연차 사용", loc: "", action: false, avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=60&h=60" }
    ],
    27: [
        { time: "13:00", duration: "2h", cat: "project", catLabel: "인프라 작업", title: "AWS RDS 데이터베이스 마이그레이션", desc: "고객 수 증가에 따른 읽기 전용 복제본 스케일 아웃 및 분산 작업", loc: "Cloud DB", action: false },
        { time: "16:00", duration: "1h", cat: "my", catLabel: "정기 회의", title: "전사 개발 표준화 테크 세미나", desc: "사내 공통 컴포넌트 라이브러리 v2.0 공유 및 토론회", loc: "Zoom 온라인 세션", action: true, actionType: "zoom" }
    ],
    28: [
        { time: "11:00", duration: "1h", cat: "team", catLabel: "클라이언트 미팅", title: "네이버 비즈니스 커머스 협력 미팅 (대면)", desc: "API 연동 제휴 관련 요구사항 검수 및 일정 협의", loc: "1층 고객 미팅 센터", action: false }
    ]
};

function selectCalendarDate(day) {
    $('#timeline-date-label').text(`5월 ${day}일`);

    var dates = [26, 27, 28];
    dates.forEach(function(d) {
        var $cell = $('#cal-date-' + d);
        if (!$cell.length) return;
        if (d === day) {
            $cell.attr('class', 'text-white py-2 bg-brand-accent/40 border border-brand-accent rounded-lg cursor-pointer relative flex flex-col items-center justify-center font-bold');
        } else {
            $cell.attr('class', 'text-gray-300 py-2 hover:bg-slate-900 rounded-lg cursor-pointer relative flex flex-col items-center justify-center');
        }
    });

    var $container = $('#timeline-events-container');
    if (!$container.length) return;
    $container.empty();

    var events = mockEventsByDate[day];
    if (!events || events.length === 0) {
        $container.html(`
            <div class="text-center py-12 text-xs text-gray-500">
                <i class="fa-regular fa-calendar-xmark text-4xl mb-3 block text-gray-600"></i>
                해당 날짜에 등록된 일정이 없습니다.
            </div>`);
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
                <a href="https://zoom.us" target="_blank" class="px-3 py-1.5 bg-blue-500 hover:bg-blue-600 text-white rounded-lg text-xs font-bold flex items-center gap-1.5 transition">
                    <i class="fa-solid fa-video"></i> 화상회의
                </a>`;
        } else if (ev.avatar) {
            actionHtml = `<img src="${ev.avatar}" alt="Avatar" class="w-8 h-8 rounded-full border border-emerald-500 object-cover">`;
        }

        var locHtml = ev.loc ? `<span class="text-[11px] text-gray-500"><i class="fa-solid fa-map-pin"></i> ${ev.loc}</span>` : '';

        var cardHtml = `
            <div class="event-card-item bg-slate-900 border-l-4 ${borderCol} p-4 rounded-r-xl border-y border-r border-brand-border/60 flex items-center justify-between gap-4" data-category="${ev.cat}">
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
                <div class="flex items-center gap-2">${actionHtml}</div>
            </div>`;
        $container.append(cardHtml);
    });
}


/* ============================================================
   9. 신규 일정 등록 모달 제어 함수
   ============================================================ */
function openAddEventModal() { $('#add-event-modal').removeClass('hidden'); }
function closeAddEventModal() { $('#add-event-modal').addClass('hidden'); }

function addNewEvent(e) {
    e.preventDefault();
    var cat      = $('#new-event-cat').val();
    var title    = $('#new-event-title').val();
    var time     = $('#new-event-time').val();
    var duration = $('#new-event-duration').val();
    var loc      = $('#new-event-loc').val();
    var desc     = $('#new-event-desc').val();

    var catLabelMap = { my: '내 스케줄', project: '프로젝트', team: '부서 휴가/공유' };
    var newEv = { time: time, duration: duration, cat: cat, catLabel: catLabelMap[cat] || '기타', title: title, desc: desc || '회의 상세 안건 공유 예정', loc: loc, action: loc.includes('Zoom'), actionType: 'zoom' };

    if (!mockEventsByDate[26]) { mockEventsByDate[26] = []; }
    mockEventsByDate[26].push(newEv);
    selectCalendarDate(26);

    $('#new-event-title, #new-event-desc').val('');
    closeAddEventModal();
    showToast('새로운 일정이 등록되었습니다.', 'success');
}


/* ============================================================
   10. jQuery DOM Ready 진입점 (엔진 초기 구동)
   ============================================================ */
$(document).ready(function() {
    // 최초 화면 로딩 시 당일 자동 출근 검증 프로세스 연동 스캔
    loadTodayAttendStatus();
});