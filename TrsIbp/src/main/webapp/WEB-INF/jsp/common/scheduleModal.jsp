<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="scheduleModal" class="ds-modal hidden" aria-hidden="true">
    <div class="ds-modal-dim"></div>
    <div class="ds-modal-panel ds-schedule-modal-panel" role="dialog" aria-modal="true" aria-labelledby="scheduleModalTitle">
        <div class="ds-modal-head">
            <div><h3 id="scheduleModalTitle" class="ds-modal-title">일정 등록</h3><p class="ds-modal-desc">여러 대상자를 선택해 같은 일정을 한 번에 등록할 수 있습니다.</p></div>
            <button type="button" class="ds-modal-close" onclick="closeScheduleModal();">×</button>
        </div>
        <input type="hidden" id="frmSchdlSn">
        <input type="hidden" id="frmTargetUserIds">
        <div class="ds-schedule-modal-body">
            <div class="ds-form-grid ds-form-12">
                <div class="ds-field ds-col-6"><label class="required">일정구분</label><select id="frmCalSchdlSeCd" class="ds-select"></select></div>
                <div id="scheduleNameField" class="ds-field ds-col-6"><label class="required">일정명</label><input type="text" id="frmCalSchdlNm" class="ds-input" maxlength="100"></div>
                <div id="vacationTypeField" class="ds-field ds-col-6 hidden"><label class="required">휴가구분</label><select id="frmVacSeCd" class="ds-select"><option value="ANNUAL">연차</option><option value="HALF">반차</option><option value="HOURLY">시간대</option></select></div>
                <div class="ds-field ds-col-6"><label>프로젝트 명</label><select id="frmBizId" class="ds-select"><option value="">할당되지 않음</option></select></div>
                <div class="ds-field ds-col-6"><label>장소</label><input type="text" id="frmPlaceNm" class="ds-input" maxlength="100"></div>
                <div class="ds-field ds-col-12"><label class="required">대상자</label><div class="ds-input-action-row"><div id="scheduleTargetChips" class="ds-chip-box"></div><button type="button" id="scheduleTargetSelectButton" class="ds-btn ds-btn-outline" onclick="openUserSelectModal('scheduleMulti');">대상자 선택</button></div></div>
                <div id="scheduleConflictMessage" class="ds-schedule-conflict hidden ds-col-12" role="alert" aria-live="assertive"></div>
                <div class="ds-field ds-col-4"><label>종일여부</label><select id="frmAllDayYn" class="ds-select"><option value="N">시간 지정</option><option value="Y">종일</option></select></div>
                <div class="ds-field ds-col-4"><label class="required">시작일시</label><input type="text" id="frmBgngDt" class="ds-input ds-datetime-picker" readonly autocomplete="off"></div>
                <div class="ds-field ds-col-4"><label class="required">종료일시</label><input type="text" id="frmEndDt" class="ds-input ds-datetime-picker" readonly autocomplete="off"></div>
                <div class="ds-field ds-col-12"><label>상세내용</label><textarea id="frmCalSchdlCn" class="ds-textarea" maxlength="1000"></textarea></div>
            </div>
            <section id="scheduleHistorySection" class="ds-schedule-history hidden">
                <button type="button" id="scheduleHistoryToggle" class="ds-schedule-history-toggle" aria-expanded="false" onclick="toggleScheduleHistory();">
                    <span>일정 변경 이력</span><i aria-hidden="true">▽</i>
                </button>
                <div id="scheduleHistoryList" class="ds-schedule-history-list hidden"></div>
            </section>
        </div>
        <div class="ds-modal-actions ds-schedule-modal-actions"><button type="button" id="scheduleDeleteButton" class="ds-btn ds-btn-outline" data-authority-code="WORK_SCHEDULE_DEL" onclick="deleteScheduleFromModal();">삭제</button><button type="button" id="scheduleSaveButton" class="ds-btn ds-btn-primary" data-authority-any="WORK_SCHEDULE_REG,WORK_SCHEDULE_MDFCN" onclick="saveSchedule();">저장</button></div>
    </div>
</div>
