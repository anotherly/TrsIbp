package kr.co.TRSolution.trsIbp.schedule.service.impl;

import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.TRSolution.trsIbp.schedule.mapper.ScheduleMapper;
import kr.co.TRSolution.trsIbp.schedule.service.ScheduleService;
import kr.co.TRSolution.trsIbp.schedule.vo.ScheduleVO;

/**
 * 종합 일정 캘린더 Service 구현체
 */
@Service("scheduleService")
public class ScheduleServiceImpl implements ScheduleService {

    @Resource(name = "scheduleMapper")
    private ScheduleMapper scheduleMapper;

    @Override
    public List<ScheduleVO> selectScheduleCodeList(ScheduleVO scheduleVO) throws Exception {
        return scheduleMapper.selectScheduleCodeList(scheduleVO);
    }

    @Override
    public List<ScheduleVO> selectMonthScheduleSummaryList(ScheduleVO scheduleVO) throws Exception {
        return scheduleMapper.selectMonthScheduleSummaryList(scheduleVO);
    }

    @Override
    public List<ScheduleVO> selectDayScheduleList(ScheduleVO scheduleVO) throws Exception {
        return scheduleMapper.selectDayScheduleList(scheduleVO);
    }

    @Override
    public List<ScheduleVO> selectUserDayScheduleList(ScheduleVO scheduleVO) throws Exception {
        return scheduleMapper.selectUserDayScheduleList(scheduleVO);
    }

    @Override
    public ScheduleVO selectSchedule(ScheduleVO scheduleVO) throws Exception {
        return scheduleMapper.selectSchedule(scheduleVO);
    }

    @Override
    public List<ScheduleVO> selectScheduleHistoryList(ScheduleVO scheduleVO) throws Exception {
        return scheduleMapper.selectScheduleHistoryList(scheduleVO);
    }

    /**
     * 특정 대상자의 일정 중 저장하려는 시간대와 겹치는 일정 건수를 조회한다.
     * @param scheduleVO 회사ID, 대상자ID, 시작일시, 종료일시, 수정 시 일정일련번호를 포함한 조회조건
     * @return 겹치는 일정 건수
     * @throws Exception 조회 중 예외 발생 시 전달
     */
    @Override
    public int selectScheduleConflictCount(ScheduleVO scheduleVO) throws Exception {
        return scheduleMapper.selectScheduleConflictCount(scheduleVO);
    }

    @Override
    public List<ScheduleVO> selectScheduleConflictList(ScheduleVO scheduleVO) throws Exception {
        return scheduleMapper.selectScheduleConflictList(scheduleVO);
    }

    /**
     * 일정 기본정보와 대상자 관계를 저장한다.
     * @param scheduleVO 저장할 일정 기본정보와 콤마 구분 대상자ID 목록
     * @throws Exception 저장 중 예외 발생 시 전달
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveSchedule(ScheduleVO scheduleVO) throws Exception {
        String[] userIds = splitTargetUserIds(scheduleVO.getTargetUserIds());
        java.util.ArrayList<ScheduleVO> conflictList = new java.util.ArrayList<ScheduleVO>();
        for (String userId : userIds) {
            scheduleVO.setTargetUserId(userId);
            conflictList.addAll(scheduleMapper.selectScheduleConflictList(scheduleVO));
        }
        if (!conflictList.isEmpty() && !"Y".equals(scheduleVO.getConflictConfirmedYn())) {
            throw new IllegalArgumentException(buildConflictMessage(conflictList));
        }

        ScheduleVO beforeSchedule = null;
        if (scheduleVO.getSchdlSn() == null) {
            scheduleMapper.insertSchedule(scheduleVO);
        } else {
            beforeSchedule = scheduleMapper.selectSchedule(scheduleVO);
            if (beforeSchedule == null) {
                throw new IllegalStateException("수정할 일정을 찾을 수 없습니다.");
            }
            scheduleMapper.updateSchedule(scheduleVO);
            scheduleMapper.deleteScheduleUserRel(scheduleVO);
        }
        for (String userId : userIds) {
            scheduleVO.setTargetUserId(userId);
            scheduleMapper.insertScheduleUserRel(scheduleVO);
        }
        if (beforeSchedule != null) {
            ScheduleVO afterSchedule = scheduleMapper.selectSchedule(scheduleVO);
            insertScheduleHistoryList(beforeSchedule, afterSchedule, scheduleVO.getMdfrId());
        }
    }

    /** 일정 수정 전후 값을 비교해 실제 변경된 항목만 이력으로 저장한다. */
    private void insertScheduleHistoryList(ScheduleVO before, ScheduleVO after, String modifierId) throws Exception {
        if (after == null) {
            throw new IllegalStateException("수정된 일정 정보를 다시 조회하지 못했습니다.");
        }
        String modificationGroupId = UUID.randomUUID().toString();
        addScheduleHistoryByKey(after.getSchdlSn(), modificationGroupId, "일정구분", before.getSchdlSeNm(), after.getSchdlSeNm(), before.getSchdlSeCd(), after.getSchdlSeCd(), modifierId);
        addScheduleHistoryByKey(after.getSchdlSn(), modificationGroupId, "휴가구분", vacationTypeName(before.getVacSeCd()), vacationTypeName(after.getVacSeCd()), before.getVacSeCd(), after.getVacSeCd(), modifierId);
        addScheduleHistoryByKey(after.getSchdlSn(), modificationGroupId, "프로젝트", defaultText(before.getBizNm(), "할당되지 않음"), defaultText(after.getBizNm(), "할당되지 않음"), before.getBizId(), after.getBizId(), modifierId);
        addScheduleHistory(after.getSchdlSn(), modificationGroupId, "일정명", before.getSchdlNm(), after.getSchdlNm(), modifierId);
        boolean allDayChanged = !defaultText(before.getAllDayYn(), "N").equals(defaultText(after.getAllDayYn(), "N"));
        if (!isAutomaticAllDayDateTimeChange(before.getBgngDt(), after.getBgngDt(), before.getAllDayYn(), after.getAllDayYn(), true, allDayChanged)) {
            addScheduleHistory(after.getSchdlSn(), modificationGroupId, "시작일시", before.getBgngDt(), after.getBgngDt(), modifierId);
        }
        if (!isAutomaticAllDayDateTimeChange(before.getEndDt(), after.getEndDt(), before.getAllDayYn(), after.getAllDayYn(), false, allDayChanged)) {
            addScheduleHistory(after.getSchdlSn(), modificationGroupId, "종료일시", before.getEndDt(), after.getEndDt(), modifierId);
        }
        addScheduleHistory(after.getSchdlSn(), modificationGroupId, "종일여부", yesNoName(before.getAllDayYn()), yesNoName(after.getAllDayYn()), modifierId);
        addScheduleHistory(after.getSchdlSn(), modificationGroupId, "장소", before.getPlaceNm(), after.getPlaceNm(), modifierId);
        addScheduleHistoryByKey(after.getSchdlSn(), modificationGroupId, "대상자", before.getTargetUserNms(), after.getTargetUserNms(), before.getTargetUserIds(), after.getTargetUserIds(), modifierId);
        addScheduleHistory(after.getSchdlSn(), modificationGroupId, "상세내용", before.getSchdlCn(), after.getSchdlCn(), modifierId);
    }

    private void addScheduleHistory(Long schdlSn, String modificationGroupId, String itemName,
            String beforeValue, String afterValue, String modifierId) throws Exception {
        addScheduleHistoryByKey(schdlSn, modificationGroupId, itemName,
                beforeValue, afterValue, beforeValue, afterValue, modifierId);
    }

    private void addScheduleHistoryByKey(Long schdlSn, String modificationGroupId, String itemName,
            String beforeValue, String afterValue, String beforeKey, String afterKey, String modifierId) throws Exception {
        String normalizedBefore = defaultText(beforeValue, "");
        String normalizedAfter = defaultText(afterValue, "");
        if (defaultText(beforeKey, "").equals(defaultText(afterKey, ""))) return;
        ScheduleVO history = new ScheduleVO();
        history.setSchdlSn(schdlSn);
        history.setMdfcnGroupId(modificationGroupId);
        history.setChgItemNm(itemName);
        history.setBfrChgCn(normalizedBefore);
        history.setAftrChgCn(normalizedAfter);
        history.setMdfrId(modifierId);
        scheduleMapper.insertScheduleHistory(history);
    }

    /**
     * 종일 여부 전환 과정에서 같은 날짜의 시각만 기본값으로 자동 보정된 경우인지 확인한다.
     * 날짜까지 직접 바뀌었거나 기본 시각과 다른 값이 지정된 경우에는 실제 변경으로 기록한다.
     */
    private boolean isAutomaticAllDayDateTimeChange(String beforeDateTime, String afterDateTime,
            String beforeAllDayYn, String afterAllDayYn, boolean startDateTime, boolean allDayChanged) {
        if (!allDayChanged || !datePart(beforeDateTime).equals(datePart(afterDateTime))) {
            return false;
        }
        if ("Y".equals(afterAllDayYn)) {
            return (startDateTime ? "00:00" : "23:59").equals(timePart(afterDateTime));
        }
        if ("Y".equals(beforeAllDayYn)) {
            String beforeAutomaticTime = startDateTime ? "00:00" : "23:59";
            String afterAutomaticTime = startDateTime ? "09:00" : "18:00";
            return beforeAutomaticTime.equals(timePart(beforeDateTime))
                    && afterAutomaticTime.equals(timePart(afterDateTime));
        }
        return false;
    }

    private String datePart(String dateTime) {
        String value = defaultText(dateTime, "");
        return value.length() >= 10 ? value.substring(0, 10) : value;
    }

    private String timePart(String dateTime) {
        String value = defaultText(dateTime, "");
        return value.length() >= 16 ? value.substring(11, 16) : "";
    }

    private String defaultText(String value, String defaultValue) {
        return value == null || value.trim().isEmpty() ? defaultValue : value.trim();
    }

    private String vacationTypeName(String value) {
        if ("ANNUAL".equals(value)) return "연차";
        if ("HALF".equals(value)) return "반차";
        if ("HOURLY".equals(value)) return "시간대";
        return "해당 없음";
    }

    private String yesNoName(String value) {
        return "Y".equals(value) ? "종일" : "시간 지정";
    }

    /**
     * 콤마 구분 대상자ID 문자열을 중복 제거된 배열로 변환한다.
     * @param targetUserIds 콤마 구분 대상자ID 문자열
     * @return 공백과 중복을 제거한 대상자ID 배열
     */
    private String[] splitTargetUserIds(String targetUserIds) {
        if (targetUserIds == null || targetUserIds.trim().isEmpty()) {
            return new String[0];
        }
        java.util.LinkedHashSet<String> userIdSet = new java.util.LinkedHashSet<String>();
        String[] userIds = targetUserIds.split(",");
        for (String userId : userIds) {
            if (userId != null && !userId.trim().isEmpty()) {
                userIdSet.add(userId.trim());
            }
        }
        return userIdSet.toArray(new String[userIdSet.size()]);
    }

    /**
     * 충돌 대상자, 기간, 일정구분과 일정명을 한 번에 확인할 수 있는 안내문을 만든다.
     */
    private String buildConflictMessage(List<ScheduleVO> conflictList) {
        StringBuilder message = new StringBuilder("해당 기간 내 다른 일정이 있는 사용자가 존재합니다. 확인 후 저장해주세요.");
        for (ScheduleVO conflict : conflictList) {
            message.append("\n- ")
                   .append(conflict.getTargetUserNm() == null ? conflict.getTargetUserId() : conflict.getTargetUserNm())
                   .append(": ")
                   .append(conflict.getBgngDt())
                   .append(" ~ ")
                   .append(conflict.getEndDt())
                   .append(" [")
                   .append(conflict.getSchdlSeNm() == null ? conflict.getSchdlSeCd() : conflict.getSchdlSeNm())
                   .append("] ")
                   .append(conflict.getSchdlNm());
        }
        return message.toString();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteSchedule(ScheduleVO scheduleVO) throws Exception {
        scheduleMapper.deleteSchedule(scheduleVO);
    }
}
