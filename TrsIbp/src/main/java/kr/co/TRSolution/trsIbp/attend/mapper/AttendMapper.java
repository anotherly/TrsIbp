package kr.co.TRSolution.trsIbp.attend.mapper;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.TRSolution.trsIbp.attend.vo.AttendVO;

/**
 * 근태관리 MyBatis 매퍼 인터페이스
 *
 * @author DevSync
 * @since 2026-05-28
 */
@Mapper("attendMapper")
public interface AttendMapper {

    /**
     * 오늘 출근 기록 조회 (userId + 오늘날짜)
     */
    AttendVO selectTodayAttend(AttendVO attendVO);

    /**
     * 출근 기록 INSERT
     */
    void insertCheckIn(AttendVO attendVO);

    /**
     * 퇴근 시간 UPDATE
     */
    void updateCheckOut(AttendVO attendVO);

    /**
     * 근무지 업데이트
     */
    void updateWorkLocation(AttendVO attendVO);
}
