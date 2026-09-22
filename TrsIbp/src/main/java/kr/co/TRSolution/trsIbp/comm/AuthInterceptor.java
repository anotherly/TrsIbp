package kr.co.TRSolution.trsIbp.comm;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.TRSolution.trsIbp.authority.service.AuthorityService;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

/**
 * DB 메뉴 권한을 화면 URL과 Ajax 기능 요청에 함께 적용한다.
 */
public class AuthInterceptor extends HandlerInterceptorAdapter {

    private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

    @Resource(name = "authorityService")
    private AuthorityService authorityService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        UserVO loginUser = (UserVO) request.getSession().getAttribute("login");
        if (loginUser == null) {
            return true;
        }

        authorityService.refreshSessionAuthority(request.getSession(), loginUser);

        String requestUrl = request.getRequestURI().substring(request.getContextPath().length());
        if ("/main/dashboardDetail.ajax".equals(requestUrl)) {
            return true;
        }
        /*
         * 메인 대시보드의 스마트 캘린더는 메뉴 권한 대상이 아니다.
         * 일정관리 화면의 등록/수정/삭제 권한과 분리하여 로그인 사용자라면 조회 가능하게 한다.
         */
        if ("/schedule/dashboardSchedule.ajax".equals(requestUrl)
                || ("/schedule/scheduleMeta.ajax".equals(requestUrl)
                        && "Y".equalsIgnoreCase(request.getParameter("dashboardYn")))) {
            return true;
        }
        if (isOwnUserRequest(requestUrl, request, loginUser)) {
            return true;
        }
        if (requestUrl.startsWith("/biz/") && !"ADMIN".equals(loginUser.getAuthrtId())
                && !authorityService.isBizAccessAllowed(loginUser, request.getParameter("bizId"))) {
            logger.warn("사업 접근 범위 거부 userId=" + loginUser.getUserId()
                    + ", bizId=" + request.getParameter("bizId")
                    + ", url=" + requestUrl);
            if (requestUrl.endsWith(".ajax")) {
                writeDeniedJson(response);
            } else {
                response.sendRedirect(request.getContextPath() + "/main/main.do?authDenied=Y");
            }
            return false;
        }
        if (requiresScheduleScope(requestUrl, request)
                && !authorityService.isScheduleAccessAllowed(loginUser,
                        request.getParameter("schdlSn"), isScheduleOwnerOnlyRequest(requestUrl))) {
            logger.warn("일정 접근 범위 거부 userId=" + loginUser.getUserId()
                    + ", schdlSn=" + request.getParameter("schdlSn")
                    + ", url=" + requestUrl);
            if (requestUrl.endsWith(".ajax")) {
                writeDeniedJson(response);
            } else {
                response.sendRedirect(request.getContextPath() + "/main/main.do?authDenied=Y");
            }
            return false;
        }
        String menuTypeNm = resolveMenuType(requestUrl, request);
        try {
            if (authorityService.isRequestGranted(loginUser, requestUrl, menuTypeNm)) {
                return true;
            }
        } catch (DataAccessException ex) {
            logger.warn("권한 migration 적용 전 요청을 기존 방식으로 허용합니다. url=" + requestUrl);
            return true;
        }

        logger.warn("메뉴 권한 거부 userId=" + loginUser.getUserId()
                + ", authrtId=" + loginUser.getAuthrtId()
                + ", url=" + requestUrl
                + ", type=" + menuTypeNm);
        if (requestUrl.endsWith(".ajax")) {
            writeDeniedJson(response);
        } else {
            response.sendRedirect(request.getContextPath() + "/main/main.do?authDenied=Y");
        }
        return false;
    }

    private String resolveMenuType(String requestUrl, HttpServletRequest request) {
        if (requestUrl.endsWith(".do")) {
            return "SCREEN";
        }
        if (requestUrl.contains("Delete") || requestUrl.contains("delete")) {
            return "DEL";
        }
        if (requestUrl.contains("Detail") || requestUrl.contains("detail")) {
            return "DETAIL";
        }
        if (requestUrl.contains("Meta") || requestUrl.contains("meta")
                || requestUrl.contains("Summary") || requestUrl.contains("summary")
                || requestUrl.contains("Check") || requestUrl.contains("check")
                || requestUrl.contains("dashboardSchedule")
                || requestUrl.contains("userWorkHourSchedule")) {
            return "LIST";
        }
        if (requestUrl.contains("List") || requestUrl.contains("list")
                || requestUrl.contains("Data") || requestUrl.contains("organizationData")) {
            return "LIST";
        }
        if (requestUrl.contains("Insert") || requestUrl.contains("insert")) {
            return "REG";
        }
        if (requestUrl.contains("Update") || requestUrl.contains("update")
                || requestUrl.endsWith("/authority/authoritySave.ajax")) {
            return "MDFCN";
        }
        if (requestUrl.contains("Save") || requestUrl.contains("save")) {
            return resolveSaveMenuType(requestUrl, request);
        }
        return "SCREEN";
    }

    private String resolveSaveMenuType(String requestUrl, HttpServletRequest request) {
        String saveMode = request.getParameter("saveMode");
        if ("insert".equalsIgnoreCase(saveMode)) {
            return "REG";
        }
        if ("update".equalsIgnoreCase(saveMode)) {
            return "MDFCN";
        }
        String identifier = null;
        if (requestUrl.endsWith("/biz/bizSave.ajax")) {
            identifier = "bizId";
        } else if (requestUrl.endsWith("/biz/custSave.ajax")) {
            identifier = "custSn";
        } else if (requestUrl.endsWith("/biz/custRelSave.ajax")) {
            identifier = "bizCustRelSn";
        } else if (requestUrl.endsWith("/biz/mnpwSave.ajax")) {
            identifier = "bizMnpwSn";
        } else if (requestUrl.endsWith("/biz/cstSave.ajax")) {
            identifier = "bizCstSn";
        } else if (requestUrl.endsWith("/biz/schdlSave.ajax")) {
            identifier = "bizSchdlSn";
        } else if (requestUrl.endsWith("/schedule/scheduleSave.ajax")) {
            identifier = "schdlSn";
        } else if (requestUrl.endsWith("/expense/expenseSave.ajax")) {
            identifier = "claimSn";
        } else if (requestUrl.endsWith("/worklog/dailySave.ajax")) {
            identifier = "workItemSn";
        } else if (requestUrl.endsWith("/notice/noticeSave.ajax")) {
            identifier = "noticeSn";
        } else if (requestUrl.endsWith("/resource/resourceSave.ajax")) {
            identifier = "resourceSn";
        } else if (requestUrl.endsWith("/resource/reservationSave.ajax")) {
            identifier = "reservationSn";
        }
        String value = identifier == null ? null : request.getParameter(identifier);
        return value != null && !value.trim().isEmpty() && !"0".equals(value.trim())
                ? "MDFCN" : "REG";
    }

    private boolean isOwnUserRequest(String requestUrl, HttpServletRequest request, UserVO loginUser) {
        boolean ownTargetUrl = "/user/empDetail.do".equals(requestUrl)
                || "/user/empDetail.ajax".equals(requestUrl)
                || "/user/empUpdate.do".equals(requestUrl)
                || ("/user/empSave.ajax".equals(requestUrl)
                        && "update".equalsIgnoreCase(request.getParameter("saveMode")));
        if (!ownTargetUrl) {
            return false;
        }
        String targetUserId = request.getParameter("userId");
        return targetUserId != null && targetUserId.equals(loginUser.getUserId());
    }

    private boolean requiresScheduleScope(String requestUrl, HttpServletRequest request) {
        String schdlSn = request.getParameter("schdlSn");
        if (schdlSn == null || schdlSn.trim().isEmpty()) {
            return false;
        }
        return requestUrl.endsWith("/schedule/scheduleDetail.ajax")
                || requestUrl.endsWith("/schedule/scheduleSave.ajax")
                || requestUrl.endsWith("/schedule/scheduleDelete.ajax");
    }

    private boolean isScheduleOwnerOnlyRequest(String requestUrl) {
        return requestUrl.endsWith("/schedule/scheduleDelete.ajax");
    }

    private void writeDeniedJson(HttpServletResponse response) throws IOException {
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write("{\"result\":\"DENIED\",\"msg\":\"해당 기능을 사용할 권한이 없습니다.\"}");
    }
}
