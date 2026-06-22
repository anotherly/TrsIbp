
package kr.co.TRSolution.trsIbp.biz.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.TRSolution.trsIbp.biz.service.BizService;
import kr.co.TRSolution.trsIbp.biz.vo.BizVO;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

@Controller
public class BizController {

    @Resource(name = "bizService")
    private BizService bizService;

    @RequestMapping(value = "/biz/bizList.do")
    public String bizList() throws Exception {
        return "/biz/bizList";
    }

    @RequestMapping(value = "/biz/bizDetail.do")
    public String bizDetail() throws Exception {
        return "/biz/bizDetail";
    }

    @RequestMapping(value = "/biz/bizList.ajax")
    public ModelAndView selectBizList(@ModelAttribute("bizVO") BizVO bizVO) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        List<BizVO> list = bizService.selectBizList(bizVO);
        int totalCnt = bizService.selectBizListCnt(bizVO);

        mav.addObject("result", "OK");
        mav.addObject("list", list);
        mav.addObject("totalCnt", totalCnt);

        return mav;
    }

    @RequestMapping(value = "/biz/bizDetail.ajax")
    public ModelAndView selectBizDetail(@ModelAttribute("bizVO") BizVO bizVO) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        BizVO detail = bizService.selectBizDetail(bizVO);
        BizVO summary = bizService.selectBizProfitSummary(bizVO);

        mav.addObject("result", detail == null ? "NO_DATA" : "OK");
        mav.addObject("detail", detail);
        mav.addObject("summary", summary);

        return mav;
    }

    @RequestMapping(value = "/biz/bizSave.ajax")
    public ModelAndView saveBiz(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO loginVO = getLoginUser(request);

        if (loginVO != null) {
            bizVO.setRgtrId(loginVO.getUserId());
            bizVO.setMdfrId(loginVO.getUserId());
            bizVO.setCoId(loginVO.getCoId());
        }

        int cnt;
        if (bizVO.getBizSn() == null || bizVO.getBizSn() == 0) {
            cnt = bizService.insertBiz(bizVO);
        } else {
            cnt = bizService.updateBiz(bizVO);
        }

        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");
        mav.addObject("bizSn", bizVO.getBizSn());

        return mav;
    }

    @RequestMapping(value = "/biz/bizDelete.ajax")
    public ModelAndView deleteBiz(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO loginVO = getLoginUser(request);

        if (loginVO != null) {
            bizVO.setMdfrId(loginVO.getUserId());
        }

        int cnt = bizService.deleteBiz(bizVO);

        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");
        return mav;
    }

    @RequestMapping(value = "/biz/custList.ajax")
    public ModelAndView selectCustList(@ModelAttribute("bizVO") BizVO bizVO) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        List<BizVO> list = bizService.selectCustList(bizVO);

        mav.addObject("result", "OK");
        mav.addObject("list", list);

        return mav;
    }

    @RequestMapping(value = "/biz/custSave.ajax")
    public ModelAndView saveCust(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO loginVO = getLoginUser(request);

        if (loginVO != null) {
            bizVO.setRgtrId(loginVO.getUserId());
            bizVO.setMdfrId(loginVO.getUserId());
        }

        int cnt;
        if (bizVO.getCustSn() == null || bizVO.getCustSn() == 0) {
            cnt = bizService.insertCust(bizVO);
        } else {
            cnt = bizService.updateCust(bizVO);
        }

        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");
        mav.addObject("custSn", bizVO.getCustSn());

        return mav;
    }

    @RequestMapping(value = "/biz/custDelete.ajax")
    public ModelAndView deleteCust(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO loginVO = getLoginUser(request);
        if (loginVO != null) {
            bizVO.setMdfrId(loginVO.getUserId());
        }

        int cnt = bizService.deleteCust(bizVO);
        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }

    @RequestMapping(value = "/biz/custRelList.ajax")
    public ModelAndView selectBizCustRelList(@ModelAttribute("bizVO") BizVO bizVO) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        List<BizVO> list = bizService.selectBizCustRelList(bizVO);

        mav.addObject("result", "OK");
        mav.addObject("list", list);

        return mav;
    }

    @RequestMapping(value = "/biz/custRelSave.ajax")
    public ModelAndView saveBizCustRel(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO loginVO = getLoginUser(request);

        if (loginVO != null) {
            bizVO.setRgtrId(loginVO.getUserId());
            bizVO.setMdfrId(loginVO.getUserId());
        }

        int cnt;
        if (bizVO.getBizCustRelSn() == null || bizVO.getBizCustRelSn() == 0) {
            cnt = bizService.insertBizCustRel(bizVO);
        } else {
            cnt = bizService.updateBizCustRel(bizVO);
        }

        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }

    @RequestMapping(value = "/biz/custRelDelete.ajax")
    public ModelAndView deleteBizCustRel(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO loginVO = getLoginUser(request);
        if (loginVO != null) {
            bizVO.setMdfrId(loginVO.getUserId());
        }

        int cnt = bizService.deleteBizCustRel(bizVO);
        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }

    @RequestMapping(value = "/biz/mnpwList.ajax")
    public ModelAndView selectBizMnpwList(@ModelAttribute("bizVO") BizVO bizVO) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        List<BizVO> list = bizService.selectBizMnpwList(bizVO);

        mav.addObject("result", "OK");
        mav.addObject("list", list);

        return mav;
    }

    @RequestMapping(value = "/biz/mnpwSave.ajax")
    public ModelAndView saveBizMnpw(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO loginVO = getLoginUser(request);

        if (loginVO != null) {
            bizVO.setRgtrId(loginVO.getUserId());
            bizVO.setMdfrId(loginVO.getUserId());
        }

        int cnt;
        if (bizVO.getBizMnpwSn() == null || bizVO.getBizMnpwSn() == 0) {
            cnt = bizService.insertBizMnpw(bizVO);
        } else {
            cnt = bizService.updateBizMnpw(bizVO);
        }

        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }

    @RequestMapping(value = "/biz/mnpwDelete.ajax")
    public ModelAndView deleteBizMnpw(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO loginVO = getLoginUser(request);
        if (loginVO != null) {
            bizVO.setMdfrId(loginVO.getUserId());
        }

        int cnt = bizService.deleteBizMnpw(bizVO);
        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }

    @RequestMapping(value = "/biz/cstList.ajax")
    public ModelAndView selectBizCstList(@ModelAttribute("bizVO") BizVO bizVO) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        List<BizVO> list = bizService.selectBizCstList(bizVO);

        mav.addObject("result", "OK");
        mav.addObject("list", list);

        return mav;
    }

    @RequestMapping(value = "/biz/cstSave.ajax")
    public ModelAndView saveBizCst(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO loginVO = getLoginUser(request);

        if (loginVO != null) {
            bizVO.setRgtrId(loginVO.getUserId());
            bizVO.setMdfrId(loginVO.getUserId());
        }

        int cnt;
        if (bizVO.getBizCstSn() == null || bizVO.getBizCstSn() == 0) {
            cnt = bizService.insertBizCst(bizVO);
        } else {
            cnt = bizService.updateBizCst(bizVO);
        }

        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }

    @RequestMapping(value = "/biz/cstDelete.ajax")
    public ModelAndView deleteBizCst(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO loginVO = getLoginUser(request);
        if (loginVO != null) {
            bizVO.setMdfrId(loginVO.getUserId());
        }

        int cnt = bizService.deleteBizCst(bizVO);
        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }

    @RequestMapping(value = "/biz/schdlList.ajax")
    public ModelAndView selectBizSchdlList(@ModelAttribute("bizVO") BizVO bizVO) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        List<BizVO> list = bizService.selectBizSchdlList(bizVO);

        mav.addObject("result", "OK");
        mav.addObject("list", list);

        return mav;
    }

    @RequestMapping(value = "/biz/schdlSave.ajax")
    public ModelAndView saveBizSchdl(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO loginVO = getLoginUser(request);

        if (loginVO != null) {
            bizVO.setRgtrId(loginVO.getUserId());
            bizVO.setMdfrId(loginVO.getUserId());
        }

        int cnt;
        if (bizVO.getBizSchdlSn() == null || bizVO.getBizSchdlSn() == 0) {
            cnt = bizService.insertBizSchdl(bizVO);
        } else {
            cnt = bizService.updateBizSchdl(bizVO);
        }

        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }

    @RequestMapping(value = "/biz/schdlDelete.ajax")
    public ModelAndView deleteBizSchdl(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO loginVO = getLoginUser(request);
        if (loginVO != null) {
            bizVO.setMdfrId(loginVO.getUserId());
        }

        int cnt = bizService.deleteBizSchdl(bizVO);
        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }

    @RequestMapping(value = "/biz/profitSummary.ajax")
    public ModelAndView selectBizProfitSummary(@ModelAttribute("bizVO") BizVO bizVO) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        BizVO summary = bizService.selectBizProfitSummary(bizVO);

        mav.addObject("result", "OK");
        mav.addObject("summary", summary);

        return mav;
    }

    private UserVO getLoginUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }

        Object loginObj = session.getAttribute("login");
        if (loginObj instanceof UserVO) {
            return (UserVO) loginObj;
        }

        return null;
    }
}
