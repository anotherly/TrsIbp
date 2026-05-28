package kr.co.TRSolution.trsHome.comm;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.TRSolution.trsHome.user.service.UserService;
import kr.co.TRSolution.trsHome.user.vo.UserVO;

/**
 * 로그인/로그아웃 인터셉터
 *
 * [동작 흐름]
 *  1. preHandle  : 로그인/로그아웃 URL 진입 전 기존 세션 제거 + logoutUpdate
 *  2. postHandle : 로그인 성공(model에 "user"키 존재) 시 세션 저장 + login_history INSERT
 *
 * [매핑 URL] dispatcher-servlet.xml에서 /user/loginAction.do, /user/logout.do 에 적용
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {

    public static final String LOGIN = "login";
    public static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

    @Resource(name = "userService")
    private UserService userService;

    /**
     * 핸들러 실행 전 - 기존 세션 제거 (로그아웃 처리)
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        logger.debug("▶ LoginInterceptor.preHandle 진입");
        HttpSession httpSession = request.getSession();
        logger.debug("▶ sessionId={}, loginAttr={}", httpSession.getId(), httpSession.getAttribute(LOGIN));

        try {
            // 기존 로그인 정보가 있으면 → 로그아웃 처리
            if (httpSession.getAttribute(LOGIN) != null) {
                logger.debug("▶ 기존 세션 제거 시작");
                UserVO logoutVo = new UserVO();
                String uid = SessionListener.getInstance().getUserID(httpSession);
                logoutVo.setUserId(uid);

                // SessionListener에서 세션 제거
                SessionListener.getInstance().removeSession(httpSession);
                // login_history FN_TIME 업데이트
                userService.logoutUpdate(logoutVo);
                logger.debug("▶ 기존 세션 제거 완료: userId={}", uid);
            }
        } catch (Exception e) {
            logger.debug("▶ preHandle 에러: {}", e.toString());
            return false;
        }
        return true;
    }

    /**
     * 핸들러 실행 후 - 로그인 성공 시 세션 저장 및 login_history 기록
     * redirect 응답이면 modelAndView가 null일 수 있으므로 null 체크 필수
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        logger.debug("▶ LoginInterceptor.postHandle 진입");

        // redirect 시 modelAndView가 null → 처리 스킵
        if (modelAndView == null) {
            logger.debug("▶ modelAndView is null (redirect), postHandle 스킵");
            return;
        }

        HttpSession httpSession = request.getSession();
        ModelMap modelMap = modelAndView.getModelMap();

        // LoginController에서 로그인 성공 시 addObject("user", loginUser) 한 값
        Object userVo = modelMap.get("user");

        try {
            if (userVo != null) {
                logger.debug("▶ 로그인 성공 - 세션 저장 시작");
                UserVO lvo = (UserVO) userVo;

                // 1. 세션에 로그인 정보 저장
                httpSession.setAttribute(LOGIN, lvo);

                // 2. SessionListener에 세션 등록 (접속자 추적)
                SessionListener.getInstance().setSession(httpSession, lvo.getUserId());

                // 3. 비정상 종료로 남은 이력 삭제 후 새 로그인 이력 INSERT
                userService.errloginDelete(lvo);
                userService.insertLogin(lvo);

                logger.debug("▶ 세션 저장 완료: userId={}, authCode={}", lvo.getUserId(), lvo.getAuthCode());
            }
        } catch (Exception e) {
            logger.debug("▶ postHandle 에러: {}", e.toString());
        }
    }
}
