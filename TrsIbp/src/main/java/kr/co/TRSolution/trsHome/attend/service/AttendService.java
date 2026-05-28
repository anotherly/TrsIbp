package kr.co.TRSolution.trsHome.attend.service;

import kr.co.TRSolution.trsHome.attend.vo.AttendVO;

/**
 * 근태관리 서비스 인터페이스
 *
 * @author DevSync
 * @since 2026-05-28
 */
public interface AttendService {

    /** 오늘 출근 기록 조회 */
    AttendVO selectTodayAttend(AttendVO attendVO);

    /** 출근 처리 */
    void checkIn(AttendVO attendVO);

    /** 퇴근 처리 */
    void checkOut(AttendVO attendVO);

    /** 근무지 변경 */
    void updateWorkLocation(AttendVO attendVO);
}
