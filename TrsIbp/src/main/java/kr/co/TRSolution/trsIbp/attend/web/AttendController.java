package kr.co.TRSolution.trsIbp.attend.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.TRSolution.trsIbp.attend.service.AttendService;
import kr.co.TRSolution.trsIbp.attend.vo.AttendVO;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

/**
 * 근태관리 컨트롤러
 *
 * [API 목록]
 *  POST /attend/checkIn.ajax   - 출근 처리
 *  POST /attend/checkOut.ajax  - 퇴근 처리
 *  GET  /attend/todayStatus.ajax - 오늘 출퇴근 현황 조회 (대시보드 로드 시)
 *  POST /attend/workLocation.ajax - 근무지 변경
 *
 * 모든 API는 JSON 응답 (jsonView)
 * 세션에서 userId를 꺼내 처리하므로 프론트에서 userId 파라미터 불필요
 *
 * @author DevSync
 * @since 2026-05-28
 */
@Controller
public class AttendController {

    public static final Logger logger = LoggerFactory.getLogger(AttendController.class);

    @Resource(name = "attendService")
    private AttendService attendService;

    /**
     * 오늘 출퇴근 현황 조회 (대시보드 로드 시 호출)
     * Response: { checkInTime, checkOutTime, workLocation, workMinutes }
     */
    @RequestMapping(value = "/attend/todayStatus.ajax", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView todayStatus(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("jsonView");
        try {
            UserVO loginUser = (UserVO) request.getSession().getAttribute("login");
            if (loginUser == null) {
                mav.addObject("result", "NO_SESSION");
                return mav;
            }

            AttendVO param = new AttendVO();
            param.setUserId(loginUser.getUserId());

            AttendVO todayAttend = attendService.selectTodayAttend(param);

            if (todayAttend != null) {
                mav.addObject("result", "OK");
                mav.addObject("checkInTime",  todayAttend.getCheckInTime());
                mav.addObject("checkOutTime", todayAttend.getCheckOutTime());
                mav.addObject("workLocation", todayAttend.getWorkLocation());
                mav.addObject("workMinutes",  todayAttend.getWorkMinutes());
            } else {
                mav.addObject("result", "NO_RECORD");
                mav.addObject("checkInTime",  "");
                mav.addObject("checkOutTime", "");
                mav.addObject("workLocation", "OFFICE");
                mav.addObject("workMinutes",  "0");
            }
        } catch (Exception e) {
            logger.error("▶ todayStatus 오류: {}", e.toString());
            mav.addObject("result", "ERROR");
            mav.addObject("msg", e.getMessage());
        }
        return mav;
    }

    /**
     * 출근 처리
     * Request: workLocation (OFFICE/HOME/OUTSIDE)
     * Response: { result, checkInTime }
     */
    @RequestMapping(value = "/attend/checkIn.ajax", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView checkIn(
            @ModelAttribute AttendVO attendVO,
            HttpServletRequest request) {

        ModelAndView mav = new ModelAndView("jsonView");
        try {
            UserVO loginUser = (UserVO) request.getSession().getAttribute("login");
            if (loginUser == null) {
                mav.addObject("result", "NO_SESSION");
                return mav;
            }

            attendVO.setUserId(loginUser.getUserId());

            // 이미 출근 기록이 있는지 확인
            AttendVO existing = attendService.selectTodayAttend(attendVO);
            if (existing != null && existing.getCheckInTime() != null && !existing.getCheckInTime().isEmpty()) {
                mav.addObject("result", "ALREADY_CHECKED_IN");
                mav.addObject("checkInTime", existing.getCheckInTime());
                return mav;
            }

            // 근무지 기본값
            if (attendVO.getWorkLocation() == null || attendVO.getWorkLocation().isEmpty()) {
                attendVO.setWorkLocation("OFFICE");
            }

            attendService.checkIn(attendVO);

            // 저장 후 다시 조회
            AttendVO saved = attendService.selectTodayAttend(attendVO);
            mav.addObject("result", "OK");
            mav.addObject("checkInTime", saved != null ? saved.getCheckInTime() : "");
            logger.debug("▶ 출근 처리 완료: userId={}, location={}", loginUser.getUserId(), attendVO.getWorkLocation());

        } catch (Exception e) {
            logger.error("▶ checkIn 오류: {}", e.toString());
            mav.addObject("result", "ERROR");
            mav.addObject("msg", "출근 처리 중 오류가 발생했습니다.");
        }
        return mav;
    }

    /**
     * 퇴근 처리
     * Response: { result, checkOutTime, workMinutes }
     */
    @RequestMapping(value = "/attend/checkOut.ajax", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView checkOut(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("jsonView");
        try {
            UserVO loginUser = (UserVO) request.getSession().getAttribute("login");
            if (loginUser == null) {
                mav.addObject("result", "NO_SESSION");
                return mav;
            }

            AttendVO param = new AttendVO();
            param.setUserId(loginUser.getUserId());

            // 출근 기록 확인
            AttendVO existing = attendService.selectTodayAttend(param);
            if (existing == null || existing.getCheckInTime() == null || existing.getCheckInTime().isEmpty()) {
                mav.addObject("result", "NO_CHECK_IN");
                return mav;
            }
            if (existing.getCheckOutTime() != null && !existing.getCheckOutTime().isEmpty()) {
                mav.addObject("result", "ALREADY_CHECKED_OUT");
                mav.addObject("checkOutTime", existing.getCheckOutTime());
                mav.addObject("workMinutes",  existing.getWorkMinutes());
                return mav;
            }

            attendService.checkOut(param);

            // 저장 후 다시 조회
            AttendVO saved = attendService.selectTodayAttend(param);
            mav.addObject("result",       "OK");
            mav.addObject("checkOutTime", saved != null ? saved.getCheckOutTime() : "");
            mav.addObject("workMinutes",  saved != null ? saved.getWorkMinutes()  : "0");
            logger.debug("▶ 퇴근 처리 완료: userId={}", loginUser.getUserId());

        } catch (Exception e) {
            logger.error("▶ checkOut 오류: {}", e.toString());
            mav.addObject("result", "ERROR");
            mav.addObject("msg", "퇴근 처리 중 오류가 발생했습니다.");
        }
        return mav;
    }

    /**
     * 근무지 변경 (출근 전/후 모두 허용)
     * Request: workLocation (OFFICE/HOME/OUTSIDE)
     * Response: { result, workLocation }
     */
    @RequestMapping(value = "/attend/workLocation.ajax", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView updateWorkLocation(
            @ModelAttribute AttendVO attendVO,
            HttpServletRequest request) {

        ModelAndView mav = new ModelAndView("jsonView");
        try {
            UserVO loginUser = (UserVO) request.getSession().getAttribute("login");
            if (loginUser == null) {
                mav.addObject("result", "NO_SESSION");
                return mav;
            }
            attendVO.setUserId(loginUser.getUserId());
            attendService.updateWorkLocation(attendVO);
            mav.addObject("result", "OK");
            mav.addObject("workLocation", attendVO.getWorkLocation());
            logger.debug("▶ 근무지 변경: userId={}, location={}", loginUser.getUserId(), attendVO.getWorkLocation());

        } catch (Exception e) {
            logger.error("▶ updateWorkLocation 오류: {}", e.toString());
            mav.addObject("result", "ERROR");
        }
        return mav;
    }
}
