
package kr.co.TRSolution.trsIbp.biz.controller;

import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.TRSolution.trsIbp.biz.service.BizService;
import kr.co.TRSolution.trsIbp.biz.vo.BizVO;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

@Controller
public class BizController {

    public static final Logger logger = LoggerFactory.getLogger(BizController.class);
    private static final SecureRandom BIZ_ID_RANDOM = new SecureRandom();
    private static final char[] BIZ_ID_CHARS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();

    @Resource(name = "bizService")
    private BizService bizService;

    /**
     * /biz 하위 .do 요청을 같은 경로의 JSP로 연결한다.
     * @param httpSession 현재 사용자 세션
     * @param request 요청 URI 확인용 HttpServletRequest
     * @param model 화면 전달 모델
     * @return ViewResolver prefix/suffix가 적용될 JSP 경로
     * @throws Exception 공통 화면 매핑 중 예외 발생 시 전달
     */
    @RequestMapping("/biz/**/*.do")
    public String urlMapping(HttpSession httpSession, HttpServletRequest request, Model model) throws Exception {
        logger.debug("▶▶▶▶▶▶▶.사업관리 최초 컨트롤러");
        String url = request.getRequestURI()
                .substring(request.getContextPath().length())
                .replaceFirst("\\.do$", "");
        logger.debug("▶▶▶▶▶▶▶.보내려는 url : {}", url);
        return url;
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

        clearContractFieldsWhenReady(bizVO);

        int cnt;
        if (bizVO.getBizId() == null || bizVO.getBizId().trim().isEmpty()) {
            bizVO.setBizId(createBizId());
            bizVO.setBizCd(createBizCd(bizVO));
            cnt = bizService.insertBiz(bizVO);
        } else {
            cnt = bizService.updateBiz(bizVO);
        }

        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");
        mav.addObject("bizId", bizVO.getBizId());

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

    /**
     * 고객사 기본정보를 등록하거나 수정한다.
     * @param bizVO 고객사 일련번호, 고객사명, 고객구분, 사업자등록번호, 대표자명, 연락처, 주소 값을 담은 VO
     * @param request 로그인 사용자 회사ID/등록자/수정자 확인용 HttpServletRequest
     * @return jsonView: result, custSn
     * @throws Exception 고객사 저장 중 예외 발생 시 전달
     */
    @RequestMapping(value = "/biz/custSave.ajax")
    public ModelAndView saveCust(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO loginVO = getLoginUser(request);

        if (loginVO != null) {
            bizVO.setRgtrId(loginVO.getUserId());
            bizVO.setMdfrId(loginVO.getUserId());
            bizVO.setCoId(loginVO.getCoId());
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

    /**
     * 사업상태가 준비(READY)인 경우 계약 관련 입력값을 저장하지 않도록 제거한다.
     * @param bizVO 저장 요청 사업 VO
     * @return 없음
     */
    private void clearContractFieldsWhenReady(BizVO bizVO) {
        if (!"READY".equals(bizVO.getBizSttsCd())) {
            return;
        }
        bizVO.setCtrtYmd(null);
        bizVO.setOtstYmd(null);
        bizVO.setBizBgngYmd(null);
        bizVO.setBizEndYmd(null);
        bizVO.setCtrtAmt(null);
        bizVO.setGiveMthdCd(null);
        bizVO.setGiveMthdCn(null);
        bizVO.setGiveDdtYmd(null);
        bizVO.setDfrpGrnteBgngYmd(null);
        bizVO.setDfrpGrnteEndYmd(null);
    }

    /**
     * 회사코드-연도-일련번호 형식의 사업코드를 생성한다.
     * @param bizVO 회사ID가 설정된 사업 VO
     * @return 예: TR-26-0001
     * @throws Exception 다음 일련번호 조회 중 예외 발생 시 전달
     */
    private String createBizCd(BizVO bizVO) throws Exception {
        String coPrefix = resolveCompanyCode(bizVO.getCoId());
        String yy = new SimpleDateFormat("yy").format(new Date());
        String prefix = coPrefix + "-" + yy + "-";
        bizVO.setBizCdPrefix(prefix);
        int nextSeq = bizService.selectNextBizCdSeq(bizVO);
        return prefix + String.format("%04d", nextSeq);
    }

    /**
     * 회사ID 기준 사업코드 회사 접두어를 반환한다.
     * @param coId 로그인 사용자의 회사ID
     * @return 사업코드 회사 접두어
     */
    private String resolveCompanyCode(String coId) {
        if ("COMP001".equals(coId)) {
            return "TR";
        }
        if (coId == null || coId.trim().isEmpty()) {
            return "CO";
        }
        String normalized = coId.replaceAll("[^A-Za-z0-9]", "").toUpperCase();
        if (normalized.length() >= 2) {
            return normalized.substring(0, 2);
        }
        return (normalized + "CO").substring(0, 2);
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

    /**
     * 화면에 노출하지 않는 사업 PK를 생성한다.
     * @param 없음
     * @return B + yyyyMMddHHmmss + 영문/숫자 랜덤 5자리로 구성된 20자리 사업ID
     */
    private String createBizId() {
        StringBuilder builder = new StringBuilder("B");
        builder.append(new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
        for (int i = 0; i < 5; i++) {
            builder.append(BIZ_ID_CHARS[BIZ_ID_RANDOM.nextInt(BIZ_ID_CHARS.length)]);
        }
        return builder.toString();
    }
}
