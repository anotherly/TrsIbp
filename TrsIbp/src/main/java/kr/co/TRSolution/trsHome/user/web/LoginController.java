package kr.co.TRSolution.trsHome.user.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.TRSolution.trsHome.user.service.UserService;
import kr.co.TRSolution.trsHome.user.vo.UserVO;

/**
 * 로그인/로그아웃 컨트롤러
 *
 * [흐름 설명]
 *  - GET  /user/login.do   → login.jsp 화면 표시
 *  - POST /user/loginAction.do → ID/PW 검증 후 세션 저장 → 대시보드(/) 이동
 *  - GET  /user/logout.do  → LoginInterceptor.preHandle에서 세션 제거 → login.jsp 이동
 *
 * [LoginInterceptor 연동]
 *  - /user/loginAction.do에 LoginInterceptor 매핑되어 있음
 *  - preHandle : 기존 로그인 세션 제거 (중복 로그인 방지)
 *  - postHandle: 로그인 성공 시 모델에 "user" 키로 UserVO가 있으면 세션에 저장
 *               + login_history INSERT (insertLogin)
 *
 * @author DevSync
 * @since 2026-05-28
 */
@Controller
public class LoginController {

    public static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    /** LoginInterceptor에서 세션 키 상수와 동일하게 맞춤 */
    public static final String SESSION_KEY = "login";

    @Resource(name = "userService")
    private UserService userService;

    /**
     * 로그인 화면 표시
     * - 이미 로그인된 경우 대시보드로 리다이렉트
     */
    @RequestMapping(value = "/user/login.do", method = RequestMethod.GET)
    public ModelAndView loginView(HttpServletRequest request) {
        logger.debug("▶ 로그인 화면 요청");

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute(SESSION_KEY) != null) {
            // 이미 로그인 → 대시보드로
            logger.debug("▶ 이미 로그인된 사용자 → 대시보드 리다이렉트");
            return new ModelAndView("redirect:/");
        }
        return new ModelAndView("/user/login");
    }

    /**
     * 로그인 처리 (POST)
     * LoginInterceptor.preHandle → 이 메서드 → LoginInterceptor.postHandle 순으로 실행
     *
     * postHandle에서 model에 "user" 키가 있으면:
     *   - httpSession.setAttribute("login", userVO)
     *   - insertLogin(loginHistory 기록)
     */
    @RequestMapping(value = "/user/loginAction.do", method = RequestMethod.POST)
    public ModelAndView loginAction(
            @ModelAttribute UserVO userVO,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        logger.debug("▶ 로그인 처리 시작: userId={}", userVO.getUserId());

        ModelAndView mav = new ModelAndView();

        try {
            // 1. ID로 사용자 조회 (비밀번호 포함)
            UserVO findVO = new UserVO();
            findVO.setUserId(userVO.getUserId());
            UserVO loginUser = userService.selectUserForLogin(findVO);

            // 2. 사용자 미존재
            if (loginUser == null) {
                logger.debug("▶ 사용자 미존재: {}", userVO.getUserId());
                redirectAttributes.addFlashAttribute("errorMsg", "아이디 또는 비밀번호가 올바르지 않습니다.");
                mav.setViewName("redirect:/user/login.do");
                return mav;
            }

            // 3. 사용 정지 계정 확인
            if (!"Y".equals(loginUser.getFlagUse())) {
                logger.debug("▶ 사용 정지 계정: {}", userVO.getUserId());
                redirectAttributes.addFlashAttribute("errorMsg", "사용이 정지된 계정입니다. 관리자에게 문의하세요.");
                mav.setViewName("redirect:/user/login.do");
                return mav;
            }

            // 4. BCrypt 비밀번호 검증
            boolean pwMatch = BCrypt.checkpw(userVO.getUserPw(), loginUser.getUserPw());
            if (!pwMatch) {
                logger.debug("▶ 비밀번호 불일치: {}", userVO.getUserId());
                redirectAttributes.addFlashAttribute("errorMsg", "아이디 또는 비밀번호가 올바르지 않습니다.");
                mav.setViewName("redirect:/user/login.do");
                return mav;
            }

            // 5. 접속 IP 기록
            String clientIp = getClientIp(request);
            logger.debug("▶ 로그인 성공: userId={}, IP={}", loginUser.getUserId(), clientIp);

            // 6. 모델에 "user" 키로 저장 → LoginInterceptor.postHandle에서 세션 저장 + login_history 기록
            mav.addObject("user", loginUser);
            mav.setViewName("redirect:/");

        } catch (IndexOutOfBoundsException | NullPointerException e) {
            // selectUser 결과가 비어있을 때 (사용자 없음)
            logger.debug("▶ 사용자 조회 실패 (없는 ID): {}", userVO.getUserId());
            redirectAttributes.addFlashAttribute("errorMsg", "아이디 또는 비밀번호가 올바르지 않습니다.");
            mav.setViewName("redirect:/user/login.do");
        } catch (Exception e) {
            logger.error("▶ 로그인 처리 중 예외 발생: {}", e.toString());
            redirectAttributes.addFlashAttribute("errorMsg", "로그인 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
            mav.setViewName("redirect:/user/login.do");
        }

        return mav;
    }

    /**
     * 로그아웃 처리
     * LoginInterceptor.preHandle에서 세션 제거 + logoutUpdate 처리 후 이 메서드 실행
     */
    @RequestMapping(value = "/user/logout.do")
    public ModelAndView logout(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        logger.debug("▶ 로그아웃 요청");

        // LoginInterceptor가 preHandle에서 이미 세션 제거하므로
        // 혹시 남은 세션이 있다면 추가 제거
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        redirectAttributes.addFlashAttribute("sessionMsg", "로그아웃되었습니다.");
        return new ModelAndView("redirect:/user/login.do");
    }

    /**
     * 클라이언트 실제 IP 추출 (프록시/로드밸런서 대응)
     */
    private String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        // 복수 IP인 경우 첫 번째만
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }
        return ip;
    }
}
