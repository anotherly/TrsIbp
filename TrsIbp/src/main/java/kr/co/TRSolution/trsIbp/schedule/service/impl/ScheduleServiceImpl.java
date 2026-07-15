package kr.co.TRSolution.trsIbp.schedule.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

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
    public ScheduleVO selectSchedule(ScheduleVO scheduleVO) throws Exception {
        return scheduleMapper.selectSchedule(scheduleVO);
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

    /**
     * 일정 기본정보와 대상자 관계를 저장한다.
     * @param scheduleVO 저장할 일정 기본정보와 콤마 구분 대상자ID 목록
     * @throws Exception 저장 중 예외 발생 시 전달
     */
    @Override
    public void saveSchedule(ScheduleVO scheduleVO) throws Exception {
        String[] userIds = splitTargetUserIds(scheduleVO.getTargetUserIds());
        for (String userId : userIds) {
            scheduleVO.setTargetUserId(userId);
            if (scheduleMapper.selectScheduleConflictCount(scheduleVO) > 0) {
                throw new IllegalArgumentException("선택한 대상자 중 이미 같은 시간대에 등록된 일정이 있습니다. 대상자와 일정을 확인하세요.");
            }
        }

        if (scheduleVO.getSchdlSn() == null) {
            scheduleMapper.insertSchedule(scheduleVO);
        } else {
            scheduleMapper.updateSchedule(scheduleVO);
            scheduleMapper.deleteScheduleUserRel(scheduleVO);
        }
        for (String userId : userIds) {
            scheduleVO.setTargetUserId(userId);
            scheduleMapper.insertScheduleUserRel(scheduleVO);
        }
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

    @Override
    public void deleteSchedule(ScheduleVO scheduleVO) throws Exception {
        scheduleMapper.deleteSchedule(scheduleVO);
    }
}
