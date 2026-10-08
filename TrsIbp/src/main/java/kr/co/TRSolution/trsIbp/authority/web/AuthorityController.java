package kr.co.TRSolution.trsIbp.authority.web;

import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.TRSolution.trsIbp.authority.service.AuthorityService;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

@Controller
public class AuthorityController {

    @Resource(name = "authorityService")
    private AuthorityService authorityService;

    @RequestMapping(value = "/authority/authorityManage.do")
    public ModelAndView authorityManage(HttpServletRequest request) {
        requirePermission(request, "MANAGEMENT_AUTHRT_SCREEN");
        return new ModelAndView("/authority/authorityManage");
    }

    @RequestMapping(value = "/authority/authorityData.ajax")
    public ModelAndView authorityData(
            @RequestParam(value = "authrtId", required = false) String authrtId,
            HttpServletRequest request) {
        UserVO loginUser = requirePermission(request, "MANAGEMENT_AUTHRT_LIST");
        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("authorityList", authorityService.selectAuthorityList(loginUser.getCoId()));
        mav.addObject("menuList", authrtId == null || authrtId.trim().isEmpty()
                ? Collections.emptyList() : authorityService.selectMenuAuthorityList(loginUser.getCoId(), authrtId));
        mav.addObject("result", "OK");
        return mav;
    }

    @RequestMapping(value = "/authority/authoritySave.ajax", method = RequestMethod.POST)
    public ModelAndView authoritySave(
            @RequestParam("authrtId") String authrtId,
            @RequestParam(value = "menuSn", required = false) List<Long> menuSnList,
            @RequestParam(value = "dataScopeCd", required = true) String dataScopeCd,
            HttpServletRequest request) {
        UserVO loginUser = requirePermission(request, "MANAGEMENT_AUTHRT_SAVE");
        ModelAndView mav = new ModelAndView("jsonView");
        try {
            authorityService.saveAuthorityMenu(loginUser.getCoId(), authrtId, menuSnList, dataScopeCd, loginUser.getUserId());
            mav.addObject("result", "OK");
        } catch (IllegalArgumentException ex) {
            mav.addObject("result", "FAIL");
            mav.addObject("msg", ex.getMessage());
        }
        return mav;
    }

    @RequestMapping(value = "/authority/authorityInsert.ajax", method = RequestMethod.POST)
    public ModelAndView authorityInsert(
            @RequestParam("authrtNm") String authrtNm,
            @RequestParam(value = "authrtExpln", required = false) String authrtExpln,
            HttpServletRequest request) {
        UserVO loginUser = requirePermission(request, "MANAGEMENT_AUTHRT_REG");
        ModelAndView mav = new ModelAndView("jsonView");
        try {
            String authrtId = authorityService.insertAuthority(loginUser.getCoId(), authrtNm, authrtExpln);
            mav.addObject("result", "OK");
            mav.addObject("authrtId", authrtId);
        } catch (IllegalArgumentException ex) {
            mav.addObject("result", "FAIL");
            mav.addObject("msg", ex.getMessage());
        }
        return mav;
    }

    @RequestMapping(value = "/authority/authorityUpdate.ajax", method = RequestMethod.POST)
    public ModelAndView authorityUpdate(
            @RequestParam("authrtId") String authrtId,
            @RequestParam("authrtNm") String authrtNm,
            @RequestParam(value = "authrtExpln", required = false) String authrtExpln,
            HttpServletRequest request) {
        UserVO loginUser = requirePermission(request, "MANAGEMENT_AUTHRT_MDFCN");
        return saveAuthorityResult(new AuthorityAction() {
            @Override
            public void execute() {
                authorityService.updateAuthority(loginUser.getCoId(), authrtId, authrtNm, authrtExpln);
            }
        });
    }

    @RequestMapping(value = "/authority/authorityDelete.ajax", method = RequestMethod.POST)
    public ModelAndView authorityDelete(
            @RequestParam("authrtId") String authrtId,
            HttpServletRequest request) {
        UserVO loginUser = requirePermission(request, "MANAGEMENT_AUTHRT_DEL");
        return saveAuthorityResult(new AuthorityAction() {
            @Override
            public void execute() {
                authorityService.deleteAuthority(loginUser.getCoId(), authrtId);
            }
        });
    }

    private ModelAndView saveAuthorityResult(AuthorityAction action) {
        ModelAndView mav = new ModelAndView("jsonView");
        try {
            action.execute();
            mav.addObject("result", "OK");
        } catch (IllegalArgumentException ex) {
            mav.addObject("result", "FAIL");
            mav.addObject("msg", ex.getMessage());
        }
        return mav;
    }

    private UserVO requirePermission(HttpServletRequest request, String menuCode) {
        UserVO loginUser = (UserVO) request.getSession().getAttribute("login");
        if (loginUser == null) {
            throw new PermissionDeniedException("로그인이 필요합니다.");
        }
        if ("ADMIN".equals(loginUser.getAuthrtId()) || "SYS_ADMIN".equals(loginUser.getAuthrtId())) {
            return loginUser;
        }
        Object granted = request.getSession().getAttribute("grantedMenuCodes");
        if (!(granted instanceof java.util.Set) || !((java.util.Set<?>) granted).contains(menuCode)) {
            throw new PermissionDeniedException("해당 권한관리 기능을 사용할 권한이 없습니다.");
        }
        return loginUser;
    }

    @ResponseStatus(HttpStatus.FORBIDDEN)
    private static final class PermissionDeniedException extends RuntimeException {
        private static final long serialVersionUID = 1L;
        private PermissionDeniedException(String message) { super(message); }
    }

    private interface AuthorityAction {
        void execute();
    }
}
