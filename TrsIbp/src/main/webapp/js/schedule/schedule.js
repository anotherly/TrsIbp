/* =========================================================
 * 종합 일정 캘린더
 * ========================================================= */
(function(window, $) {
    'use strict';

    var today = new Date();
    var currentDate = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    var selectedDate = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    var viewType = 'all';
    var monthSummary = {};
    var scheduleCodes = [];
    var selectedUsers = {};
    var previousBgngTime = '09:00';
    var previousEndTime = '18:00';

    function pad(n) { return n < 10 ? '0' + n : '' + n; }
    function ymd(d) { return d.getFullYear() + '-' + pad(d.getMonth() + 1) + '-' + pad(d.getDate()); }
    function ymLabel(d) { return d.getFullYear() + '년 ' + (d.getMonth() + 1) + '월'; }
    function nvl(v, d) { return v === null || v === undefined || v === '' ? (d || '') : v; }
    function escapeHtml(v) { return String(nvl(v, '')).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;'); }
    function toDatetimeLocal(v) { return nvl(v, '').replace(' ', 'T'); }
    function toDisplayTime(v, allDayYn) { return allDayYn === 'Y' ? 'All Day' : nvl(v, '').substring(11, 16); }
    function colorClass(colorType) { return 'ds-schedule-' + (colorType || 'etc'); }
    /**
     * date/datetime-local 입력값을 비교 가능한 Date 객체로 변환한다.
     * @param {string} v 날짜 또는 일시 입력값
     * @param {boolean} isEndOfDay 날짜만 입력된 경우 종료일 끝 시각 적용 여부
     * @returns {Date|null} 변환된 Date 객체. 입력값이 없으면 null
     */
    function parseInputDateTime(v, isEndOfDay) {
        if (!v) return null;
        var normalized = v.indexOf('T') >= 0 || v.indexOf(' ') >= 0
            ? v.replace(' ', 'T')
            : v + (isEndOfDay ? 'T23:59:59' : 'T00:00:00');
        return new Date(normalized);
    }

    /**
     * 종합 일정 캘린더 화면을 초기화한다.
     * @returns {void}
     */
    window.initSchedulePage = function() {
        $('#frmAllDayYn').on('change', function() {
            applyAllDayInputMode($(this).val() === 'Y');
        });
        $('#frmBgngDt,#frmEndDt').on('change', function() {
            this.blur();
        });
        loadScheduleMeta(function() {
            loadScheduleList();
        });
    };

    /**
     * 대시보드 일정 위젯을 초기화한다.
     * @returns {void}
     */
    window.initDashboardScheduleWidget = function() {
        viewType = 'all';
        loadScheduleList(true);
    };

    function loadScheduleMeta(callback) {
        $.ajax({
            url: ctxPath + '/schedule/scheduleMeta.ajax',
            type: 'GET',
            dataType: 'json',
            success: function(res) {
                scheduleCodes = res.codeList || [];
                renderScheduleCodeOptions();
                if (typeof callback === 'function') callback();
            },
            error: function() {
                alert('일정 구분 정보를 조회하지 못했습니다.');
            }
        });
    }

    function renderScheduleCodeOptions() {
        var html = '<option value="">선택</option>';
        scheduleCodes.forEach(function(code) {
            if (['PROJECT', 'HOME', 'REMOTE'].indexOf(code.schdlSeCd) >= 0) return;
            html += '<option value="' + escapeHtml(code.schdlSeCd) + '">' + escapeHtml(code.schdlSeNm) + '</option>';
        });
        $('#frmCalSchdlSeCd').html(html);
    }

    function loadScheduleList(isDashboard) {
        $.ajax({
            url: ctxPath + (isDashboard ? '/schedule/dashboardSchedule.ajax' : '/schedule/scheduleList.ajax'),
            type: 'GET',
            dataType: 'json',
            data: { selectedYmd: ymd(selectedDate), viewType: viewType },
            success: function(res) {
                monthSummary = buildMonthSummary(res.monthList || []);
                if (isDashboard) {
                    renderDashboardCalendar(res.dayList || []);
                } else {
                    renderCalendar();
                    renderDayList(res.dayList || []);
                }
            },
            error: function() {
                if (!isDashboard) alert('일정 목록을 조회하지 못했습니다.');
            }
        });
    }

    function buildMonthSummary(list) {
        var map = {};
        list.forEach(function(row) {
            var date = nvl(row.bgngDt, '').substring(0, 10);
            if (!map[date]) map[date] = [];
            if (map[date].indexOf(row.colorType) < 0) map[date].push(row.colorType);
        });
        return map;
    }

    function renderCalendar() {
        $('#scheduleMonthLabel').text(ymLabel(currentDate));
        $('#scheduleSelectedDateTitle').text(ymd(selectedDate) + ' 일정');
        var first = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
        var start = new Date(first);
        start.setDate(first.getDate() - first.getDay());
        var html = '<span class="ds-weekday sun">일</span><span class="ds-weekday">월</span><span class="ds-weekday">화</span><span class="ds-weekday">수</span><span class="ds-weekday">목</span><span class="ds-weekday">금</span><span class="ds-weekday">토</span>';
        for (var i = 0; i < 42; i++) {
            var d = new Date(start);
            d.setDate(start.getDate() + i);
            var key = ymd(d);
            var dots = monthSummary[key] || [];
            html += '<button type="button" class="ds-calendar-day ' + (d.getMonth() !== currentDate.getMonth() ? 'is-muted ' : '') + (key === ymd(selectedDate) ? 'is-selected ' : '') + '" onclick="selectScheduleDate(\'' + key + '\');">'
                + '<span>' + d.getDate() + '</span><em>' + dots.map(function(c) { return '<i class="ds-dot ds-dot-' + escapeHtml(c || 'etc') + '"></i>'; }).join('') + '</em></button>';
        }
        $('#scheduleCalendarGrid').html(html);
    }

    function renderDayList(list) {
        if (list.length === 0) {
            $('#scheduleDayList').html('<div class="ds-empty">조회된 일정이 없습니다.</div>');
            return;
        }
        var html = '';
        list.forEach(function(row) {
            html += '<div class="ds-schedule-card ' + colorClass(row.colorType) + '">'
                + '<div><strong>' + escapeHtml(row.schdlNm) + '</strong>'
                + '<p>' + escapeHtml(row.schdlSeNm) + ' · ' + escapeHtml(toDisplayTime(row.bgngDt, row.allDayYn)) + ' · ' + escapeHtml(row.targetUserNms || '-') + '</p>'
                + (row.placeNm ? '<p>' + escapeHtml(row.placeNm) + '</p>' : '')
                + '</div><button type="button" class="ds-btn ds-btn-outline" onclick="openScheduleModal(' + row.schdlSn + ');">수정</button></div>';
        });
        $('#scheduleDayList').html(html);
    }

    /**
     * 일정 탭을 변경한다.
     * @param {string} type 조회 탭 유형(all/my/project/team)
     * @returns {void}
     */
    window.changeScheduleView = function(type) {
        viewType = type || 'all';
        $('.ds-tab').removeClass('is-active');
        $('.ds-tab[data-view-type="' + viewType + '"]').addClass('is-active');
        loadScheduleList();
    };

    /**
     * 달력 월을 이동한다.
     * @param {number} diff 이동할 월 수
     * @returns {void}
     */
    window.moveScheduleMonth = function(diff) {
        currentDate = new Date(currentDate.getFullYear(), currentDate.getMonth() + diff, 1);
        selectedDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
        loadScheduleList();
    };

    /**
     * 달력에서 일자를 선택한다.
     * @param {string} dateYmd 선택일자 yyyy-MM-dd
     * @returns {void}
     */
    window.selectScheduleDate = function(dateYmd) {
        selectedDate = new Date(dateYmd);
        currentDate = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), 1);
        loadScheduleList();
    };

    /**
     * 일정 등록/수정 모달을 연다.
     * @param {number=} schdlSn 일정 순번. 없으면 등록 모드
     * @returns {void}
     */
    window.openScheduleModal = function(schdlSn) {
        clearScheduleForm();
        $('#scheduleModal').removeClass('hidden').attr('aria-hidden', 'false');
        if (schdlSn) {
            $('#scheduleModalTitle').text('일정 수정');
            $.ajax({
                url: ctxPath + '/schedule/scheduleDetail.ajax',
                type: 'GET',
                dataType: 'json',
                data: { schdlSn: schdlSn },
                success: function(res) { bindScheduleForm(res.schedule || {}); }
            });
        } else {
            $('#scheduleModalTitle').text('일정 등록');
            $('#frmBgngDt').val(ymd(selectedDate) + 'T09:00');
            $('#frmEndDt').val(ymd(selectedDate) + 'T18:00');
            previousBgngTime = '09:00';
            previousEndTime = '18:00';
            applyAllDayInputMode(false);
        }
    };

    window.closeScheduleModal = function() { $('#scheduleModal').addClass('hidden').attr('aria-hidden', 'true'); };

    /**
     * 일정 등록·수정 폼과 대상자 선택 상태를 기본값으로 초기화한다.
     * @returns {void}
     */
    function clearScheduleForm() {
        $('#frmSchdlSn,#frmCalSchdlNm,#frmPlaceNm,#frmCalSchdlCn,#frmTargetUserIds').val('');
        $('#frmCalSchdlSeCd').val('');
        $('#frmAllDayYn').val('N');
        previousBgngTime = '09:00';
        previousEndTime = '18:00';
        applyAllDayInputMode(false);
        selectedUsers = {};
        renderScheduleTargetChips();
    }

    /**
     * 조회한 일정 상세정보를 수정 폼과 대상자 선택 상태에 반영한다.
     * @param {Object} row 일정 상세정보
     * @returns {void}
     */
    function bindScheduleForm(row) {
        $('#frmSchdlSn').val(nvl(row.schdlSn));
        $('#frmCalSchdlSeCd').val(nvl(row.schdlSeCd));
        $('#frmCalSchdlNm').val(nvl(row.schdlNm));
        $('#frmBgngDt').val(toDatetimeLocal(row.bgngDt));
        $('#frmEndDt').val(toDatetimeLocal(row.endDt));
        $('#frmAllDayYn').val(nvl(row.allDayYn, 'N'));
        $('#frmPlaceNm').val(nvl(row.placeNm));
        $('#frmCalSchdlCn').val(nvl(row.schdlCn));
        selectedUsers = {};
        var ids = nvl(row.targetUserIds).split(',');
        var nms = nvl(row.targetUserNms).split(', ');
        ids.forEach(function(id, idx) { if (id) selectedUsers[id] = { userId: id, userNm: nms[idx] || id }; });
        renderScheduleTargetChips();
        rememberScheduleTimes(row.bgngDt, row.endDt);
        applyAllDayInputMode(row.allDayYn === 'Y');
    }

    /**
     * 저장된 일정 또는 현재 입력값에서 종일 해제 시 복원할 시작·종료 시각을 기억한다.
     * @param {string} bgngDt 시작일시
     * @param {string} endDt 종료일시
     * @returns {void}
     */
    function rememberScheduleTimes(bgngDt, endDt) {
        var bgngTime = nvl(bgngDt, '').substring(11, 16);
        var endTime = nvl(endDt, '').substring(11, 16);
        if (bgngTime && bgngTime !== '00:00') previousBgngTime = bgngTime;
        if (endTime && endTime !== '23:59') previousEndTime = endTime;
    }

    /**
     * 종일 여부에 따라 날짜 입력 형식을 전환하고 기존 시각을 복원한다.
     * @param {boolean} allDay 종일 일정 여부
     * @returns {void}
     */
    function applyAllDayInputMode(allDay) {
        var $bgng = $('#frmBgngDt');
        var $end = $('#frmEndDt');
        var bgngValue = $bgng.val();
        var endValue = $end.val();
        if (allDay) {
            rememberScheduleTimes(bgngValue, endValue);
            $bgng.attr('type', 'date').val(nvl(bgngValue, '').substring(0, 10));
            $end.attr('type', 'date').val(nvl(endValue, '').substring(0, 10));
            return;
        }
        var bgngYmd = nvl(bgngValue, ymd(selectedDate)).substring(0, 10);
        var endYmd = nvl(endValue, bgngYmd).substring(0, 10);
        $bgng.attr('type', 'datetime-local').val(bgngYmd + 'T' + (previousBgngTime || '09:00'));
        $end.attr('type', 'datetime-local').val(endYmd + 'T' + (previousEndTime || '18:00'));
    }

    /**
     * 사용자 선택 모달에서 선택한 여러 사용자를 일정 대상자로 반영한다.
     * @param {Array} users 선택 사용자 목록
     * @returns {void}
     */
    window.setScheduleSelectedUsers = function(users) {
        selectedUsers = {};
        (users || []).forEach(function(user) {
            if (user.userId) selectedUsers[user.userId] = user;
        });
        renderScheduleTargetChips();
    };

    /**
     * 사용자 선택 모달을 다시 열 때 유지할 현재 일정 대상자 목록을 반환한다.
     * @returns {Array} 현재 선택된 사용자 목록
     */
    window.getScheduleSelectedUsers = function() {
        return Object.keys(selectedUsers).map(function(id) { return selectedUsers[id]; });
    };

    function renderScheduleTargetChips() {
        var ids = Object.keys(selectedUsers);
        $('#frmTargetUserIds').val(ids.join(','));
        if (ids.length === 0) {
            $('#scheduleTargetChips').html('<span class="ds-chip-placeholder">대상자를 선택하세요.</span>');
            return;
        }
        $('#scheduleTargetChips').html(ids.map(function(id) { return '<span class="ds-chip ds-chip-selected">' + escapeHtml(selectedUsers[id].userNm || id) + '<button type="button" onclick="removeScheduleTarget(\'' + escapeHtml(id) + '\');">×</button></span>'; }).join(''));
    }

    window.removeScheduleTarget = function(userId) { delete selectedUsers[userId]; renderScheduleTargetChips(); };

    window.saveSchedule = function() {
        if (!$('#frmCalSchdlSeCd').val()) { alert('일정구분을 선택하세요.'); return; }
        if (!$('#frmCalSchdlNm').val()) { alert('일정명을 입력하세요.'); return; }
        if (!$('#frmTargetUserIds').val()) { alert('대상자를 선택하세요.'); return; }
        if (!$('#frmBgngDt').val() || !$('#frmEndDt').val()) { alert('시작일시와 종료일시를 입력하세요.'); return; }
        var allDay = $('#frmAllDayYn').val() === 'Y';
        var bgngDt = parseInputDateTime($('#frmBgngDt').val(), false);
        var endDt = parseInputDateTime($('#frmEndDt').val(), allDay);
        if (!bgngDt || !endDt || isNaN(bgngDt.getTime()) || isNaN(endDt.getTime())) { alert('시작일시 또는 종료일시 형식이 올바르지 않습니다.'); return; }
        if (endDt <= bgngDt) { alert('종료일시는 시작일시보다 이후여야 합니다.'); return; }
        $.ajax({
            url: ctxPath + '/schedule/scheduleSave.ajax',
            type: 'POST',
            dataType: 'json',
            data: {
                schdlSn: $('#frmSchdlSn').val(),
                schdlSeCd: $('#frmCalSchdlSeCd').val(),
                schdlNm: $('#frmCalSchdlNm').val(),
                targetUserIds: $('#frmTargetUserIds').val(),
                bgngDt: $('#frmBgngDt').val(),
                endDt: $('#frmEndDt').val(),
                allDayYn: $('#frmAllDayYn').val(),
                placeNm: $('#frmPlaceNm').val(),
                schdlCn: $('#frmCalSchdlCn').val()
            },
            success: function(res) {
                if (res.result === 'OK') { closeScheduleModal(); loadScheduleList(); }
                else alert(res.message || '일정 저장에 실패했습니다.');
            },
            error: function() { alert('일정 저장 중 오류가 발생했습니다.'); }
        });
    };

    window.deleteScheduleFromModal = function() {
        var sn = $('#frmSchdlSn').val();
        if (!sn) { closeScheduleModal(); return; }
        if (!confirm('일정을 삭제하시겠습니까?')) return;
        $.ajax({
            url: ctxPath + '/schedule/scheduleDelete.ajax', type: 'POST', dataType: 'json', data: { schdlSn: sn },
            success: function(res) { if (res.result === 'OK') { closeScheduleModal(); loadScheduleList(); } }
        });
    };

    function renderDashboardCalendar(dayList) {
        var $month = $('#dashScheduleMonthLabel');
        if ($month.length === 0) return;
        $month.text(ymLabel(currentDate));
        $('#dashScheduleSelectedTitle').text(ymd(selectedDate) + ' 일정');
        renderCalendarTo('#dashScheduleCalendarGrid', 'selectDashboardScheduleDate');
        renderDashboardDayList(dayList);
    }

    function renderCalendarTo(selector, clickFn) {
        var first = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
        var start = new Date(first); start.setDate(first.getDate() - first.getDay());
        var html = '<span class="ds-weekday sun">일</span><span class="ds-weekday">월</span><span class="ds-weekday">화</span><span class="ds-weekday">수</span><span class="ds-weekday">목</span><span class="ds-weekday">금</span><span class="ds-weekday">토</span>';
        for (var i=0; i<42; i++) {
            var d = new Date(start); d.setDate(start.getDate()+i);
            var key = ymd(d); var dots = monthSummary[key] || [];
            html += '<button type="button" class="ds-calendar-day ' + (d.getMonth() !== currentDate.getMonth() ? 'is-muted ' : '') + (key === ymd(selectedDate) ? 'is-selected ' : '') + '" onclick="' + clickFn + '(\'' + key + '\');"><span>' + d.getDate() + '</span><em>' + dots.map(function(c){return '<i class="ds-dot ds-dot-' + c + '"></i>';}).join('') + '</em></button>';
        }
        $(selector).html(html);
    }

    function renderDashboardDayList(list) {
        if (list.length === 0) { $('#dashScheduleDayList').html('<div class="ds-empty">조회된 일정이 없습니다.</div>'); return; }
        $('#dashScheduleDayList').html(list.map(function(row) {
            return '<div class="ds-schedule-card ' + colorClass(row.colorType) + '"><div><strong>' + escapeHtml(row.schdlNm) + '</strong><p>' + escapeHtml(row.schdlSeNm) + ' · ' + escapeHtml(toDisplayTime(row.bgngDt, row.allDayYn)) + ' · ' + escapeHtml(row.targetUserNms || '-') + '</p></div></div>';
        }).join(''));
    }

    window.selectDashboardScheduleDate = function(dateYmd) { selectedDate = new Date(dateYmd); currentDate = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), 1); loadScheduleList(true); };
    window.moveDashboardScheduleMonth = function(diff) { currentDate = new Date(currentDate.getFullYear(), currentDate.getMonth()+diff, 1); selectedDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1); loadScheduleList(true); };
    window.changeDashboardScheduleView = function(type) { viewType = type || 'all'; $('.dash-schedule-tab').removeClass('is-active'); $('.dash-schedule-tab[data-view-type="'+viewType+'"]').addClass('is-active'); loadScheduleList(true); };
})(window, jQuery);
