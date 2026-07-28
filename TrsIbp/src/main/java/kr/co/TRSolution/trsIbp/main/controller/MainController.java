package kr.co.TRSolution.trsIbp.main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.TRSolution.trsIbp.user.vo.UserVO;

/**
 * 메인 화면 컨트롤러.
 *
 * <p>역할:</p>
 * <ul>
 *   <li>루트 index.jsp에서 세션 확인 후 이동하는 메인 대시보드 화면을 반환한다.</li>
 *   <li>실제 JSP 파일 위치는 /WEB-INF/jsp/main/main.jsp 이다.</li>
 * </ul>
 *
 * <p>URL:</p>
 * <ul>
 *   <li>/main/main.do</li>
 * </ul>
 */
@Controller
public class MainController {

    private static final Logger logger = LoggerFactory.getLogger(MainController.class);

    /**
     * 메인 대시보드 화면으로 이동한다.
     *
     * @param session 현재 HTTP 세션. login 속성은 LoginInterceptor 또는 JSP 공통 head에서 검증한다.
     * @param request 현재 요청 객체. 로그 기록 및 확장용으로 사용한다.
     * @return ViewResolver 기준 JSP 경로. /WEB-INF/jsp/main/main.jsp 로 해석된다.
     * @throws Exception 화면 이동 중 예외 발생 시 상위로 전달한다.
     */
    @RequestMapping(value = "/main/main.do")
    public String main(@RequestParam(value = "workspace", required = false) String workspace,
            HttpSession session, HttpServletRequest request) throws Exception {
        UserVO loginUser = (UserVO) session.getAttribute("login");
        String selectedWorkspace = resolveWorkspace(loginUser, workspace,
                (String) session.getAttribute("selectedWorkspace"));
        session.setAttribute("selectedWorkspace", selectedWorkspace);
        request.setAttribute("selectedWorkspace", selectedWorkspace);
        logger.debug("▶▶▶▶▶▶▶.메인 대시보드 화면 이동 : {}", request.getRequestURI());
        return "/main/main";
    }

    private String resolveWorkspace(UserVO loginUser, String requestedWorkspace, String currentWorkspace) {
        String candidate = requestedWorkspace == null || requestedWorkspace.trim().isEmpty()
                ? currentWorkspace : requestedWorkspace.trim().toLowerCase();
        if (candidate == null || candidate.isEmpty()) {
            return "work";
        }

        String authrtId = loginUser == null ? "USER" : loginUser.getAuthrtId();
        if ("USER".equals(authrtId)) {
            return "work";
        }
        if ("ADMIN".equals(authrtId)
                && ("work".equals(candidate) || "project".equals(candidate)
                        || "org".equals(candidate) || "management".equals(candidate))) {
            return candidate;
        }
        if ("MANAGER".equals(authrtId)
                && ("work".equals(candidate) || "project".equals(candidate)
                        || "org".equals(candidate) || "management".equals(candidate))) {
            return candidate;
        }
        return "work";
    }
}
