package kr.co.TRSolution.trsIbp.comm;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.TRSolution.trsIbp.user.vo.UserVO;
import kr.co.TRSolution.trsIbp.attend.service.AttendService;
import kr.co.TRSolution.trsIbp.attend.vo.AttendVO;

/**
 * 로그인/로그아웃 및 자동 근태 처리 인터셉터
 *
 * [동작 흐름]
 * 1. preHandle  : 로그인/로그아웃 URL 진입 전 기존 세션 제거
 * 2. postHandle : 로그인 성공 시 세션 저장 및 당일 최초 로그인일 경우 자동 출근 등록
 *
 * [매핑 URL] dispatcher-servlet.xml에서 /user/loginAction.do, /login/logout.do 에 적용
 * [패키지 명 명세] trsHome -> trsIbp 구조 변경 반영 완료
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {

    public static final String LOGIN = "login";
    
    // ★ 복구된 로거 선언문 (컴파일 에러 방지)
    public static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

    @Resource(name = "attendService")
    private AttendService attendService;

    /**
     * 핸들러 실행 전 - 기존 세션 제거 (중복 로그인 방지)
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        logger.debug("▶ LoginInterceptor.preHandle 진입");
        HttpSession httpSession = request.getSession();
        logger.debug("▶ sessionId={}, loginAttr={}", httpSession.getId(), httpSession.getAttribute(LOGIN));

        try {
            // 기존 로그인 정보가 있으면 -> 세션 제거
            if (httpSession.getAttribute(LOGIN) != null) {
                logger.debug("▶ 기존 세션 제거 시작");
                String uid = SessionListener.getInstance().getUserID(httpSession);
                // SessionListener에서 세션 제거
                SessionListener.getInstance().removeSession(httpSession);
                logger.debug("▶ 기존 세션 제거 완료: userId={}", uid);
            }
        } catch (Exception e) {
            logger.error("▶ preHandle 내부 에러 발생: {}", e.toString());
            return false;
        }
        return true;
    }

    /**
     * 핸들러 실행 후 - 로그인 성공 시 세션 바인딩 및 시스템 자동 출근 트랜잭션 처리
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        logger.debug("▶ LoginInterceptor.postHandle 진입");
        
        if (modelAndView == null) return;

        HttpSession httpSession = request.getSession();
        Object userVo = modelAndView.getModelMap().get("user");

        if (userVo != null) {
            UserVO lvo = (UserVO) userVo;
            
            // 1. 세션 기본 저장
            httpSession.setAttribute(LOGIN, lvo);
            SessionListener.getInstance().setSession(httpSession, lvo.getUserId());

            // 2. 로그인 연동 당일 자동 출근 검증 프로세스 가동
            try {
                AttendVO attendParam = new AttendVO();
                attendParam.setUserId(lvo.getUserId());
                
                // 오늘 자 출근 기록 선조회 (세션 만료 후 재로그인 시 중복 인서트 방지 방어코드)
                AttendVO todayRecord = attendService.selectTodayAttend(attendParam);
                
                if (todayRecord == null) {
                    // 당일 최초 로그인인 경우에만 출근 마스터 레코드 Insert
                    AttendVO checkInVO = new AttendVO();
                    checkInVO.setUserId(lvo.getUserId());
                    checkInVO.setPowkNm(attendService.selectDefaultPowkSeCd());
                    checkInVO.setWorkRmrkCn("로그인 시 시스템 자동 출근 처리");
                    
                    attendService.checkIn(checkInVO);
                    logger.debug("▶ [자동출근] 당일 최초 로그인 식별 -> 자동 출근 등록 완료 (userId: {})", lvo.getUserId());
                } else {
                    logger.debug("▶ [자동출근] 당일 근태 데이터 이미 존재 -> 세션 재연결 처리 (userId: {})", lvo.getUserId());
                }
            } catch (Exception e) {
                logger.error("▶ [자동출근 에러] 근태 데이터 인터페이스 연동 중 예외 발생: {}", e.toString());
            }

            // 인터셉터에서 직접 메인 대시보드로 리다이렉트 처리 후 모델 클리어
            response.sendRedirect(request.getContextPath() + "/");
            modelAndView.clear();
        }
    }
}
