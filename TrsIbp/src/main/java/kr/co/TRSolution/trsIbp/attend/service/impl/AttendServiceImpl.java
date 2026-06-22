package kr.co.TRSolution.trsIbp.attend.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.TRSolution.trsIbp.attend.mapper.AttendMapper;
import kr.co.TRSolution.trsIbp.attend.service.AttendService;
import kr.co.TRSolution.trsIbp.attend.vo.AttendVO;

/**
 * 근태관리 서비스 구현
 *
 * @author DevSync
 * @since 2026-05-28
 */
@Service("attendService")
public class AttendServiceImpl implements AttendService {

    @Resource(name = "attendMapper")
    private AttendMapper attendMapper;

    @Override
    public AttendVO selectTodayAttend(AttendVO attendVO) {
        return attendMapper.selectTodayAttend(attendVO);
    }

    @Override
    public void checkIn(AttendVO attendVO) {
        attendMapper.insertCheckIn(attendVO);
    }

    @Override
    public void checkOut(AttendVO attendVO) {
        attendMapper.updateCheckOut(attendVO);
    }

    @Override
    public void updatePowkNm(AttendVO attendVO) {
        attendMapper.updatePowkNm(attendVO);
    }
}
