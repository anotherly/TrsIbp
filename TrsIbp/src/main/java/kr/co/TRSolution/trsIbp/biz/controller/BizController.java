
package kr.co.TRSolution.trsIbp.biz.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

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
        logger.debug("▶▶▶▶▶▶▶.보내려는 url : " + url);
        return url;
    }

    @RequestMapping(value = "/biz/bizList.ajax")
    public ModelAndView selectBizList(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());

        List<BizVO> list = bizService.selectBizList(bizVO);
        int totalCnt = bizService.selectBizListCnt(bizVO);

        mav.addObject("result", "OK");
        mav.addObject("list", list);
        mav.addObject("totalCnt", totalCnt);

        return mav;
    }

    @RequestMapping(value = "/biz/bizDetail.ajax")
    public ModelAndView selectBizDetail(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());

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

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());
        bizVO.setRgtrId(reqLoginVo.getUserId());
        bizVO.setMdfrId(reqLoginVo.getUserId());

        clearContractFieldsWhenReady(bizVO);

        int cnt;
        if (bizVO.getBizId() == null || bizVO.getBizId().trim().isEmpty()) {
            bizVO.setBizId(createBizId());
            bizVO.setBizCd(createBizCd(bizVO, reqLoginVo.getCoCd()));
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

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());
        bizVO.setRgtrId(reqLoginVo.getUserId());
        bizVO.setMdfrId(reqLoginVo.getUserId());

        int cnt = bizService.deleteBiz(bizVO);

        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");
        return mav;
    }

    @RequestMapping(value = "/biz/custList.ajax")
    public ModelAndView selectCustList(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());

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

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());
        bizVO.setRgtrId(reqLoginVo.getUserId());
        bizVO.setMdfrId(reqLoginVo.getUserId());

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

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());
        bizVO.setRgtrId(reqLoginVo.getUserId());
        bizVO.setMdfrId(reqLoginVo.getUserId());

        int cnt = bizService.deleteCust(bizVO);
        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }

    @RequestMapping(value = "/biz/custRelList.ajax")
    public ModelAndView selectBizCustRelList(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());

        List<BizVO> list = bizService.selectBizCustRelList(bizVO);

        mav.addObject("result", "OK");
        mav.addObject("list", list);

        return mav;
    }

    @RequestMapping(value = "/biz/custRelSave.ajax")
    public ModelAndView saveBizCustRel(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());
        bizVO.setRgtrId(reqLoginVo.getUserId());
        bizVO.setMdfrId(reqLoginVo.getUserId());

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

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());
        bizVO.setRgtrId(reqLoginVo.getUserId());
        bizVO.setMdfrId(reqLoginVo.getUserId());

        int cnt = bizService.deleteBizCustRel(bizVO);
        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }


    /**
     * 투입시작일과 투입종료일 기준으로 투입 M/M을 계산한다.
     * @param inputBgngYmd 투입시작일(yyyy-MM-dd)
     * @param inputEndYmd 투입종료일(yyyy-MM-dd)
     * @return 계산된 투입 M/M. 날짜가 없거나 형식이 잘못되면 null 반환
     */
    private BigDecimal calculateInputMcnt(String inputBgngYmd, String inputEndYmd) {
        if (inputBgngYmd == null || inputBgngYmd.trim().isEmpty()
                || inputEndYmd == null || inputEndYmd.trim().isEmpty()) {
            return null;
        }

        try {
            LocalDate startDate = LocalDate.parse(inputBgngYmd);
            LocalDate endDate = LocalDate.parse(inputEndYmd);
            if (startDate.isAfter(endDate)) {
                return null;
            }

            long inputDays = ChronoUnit.DAYS.between(startDate, endDate) + 1;
            return BigDecimal.valueOf(inputDays)
                    .divide(BigDecimal.valueOf(30), 2, RoundingMode.HALF_UP);
        } catch (RuntimeException e) {
            logger.error("투입 M/M 계산 중 날짜 변환 실패"
                    + " inputBgngYmd : " + inputBgngYmd
                    + " inputEndYmd : " + inputEndYmd, e);
            return null;
        }
    }

    @RequestMapping(value = "/biz/mnpwList.ajax")
    public ModelAndView selectBizMnpwList(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());

        List<BizVO> list = bizService.selectBizMnpwList(bizVO);

        mav.addObject("result", "OK");
        mav.addObject("list", list);

        return mav;
    }

    @RequestMapping(value = "/biz/mnpwSave.ajax")
    public ModelAndView saveBizMnpw(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());
        bizVO.setRgtrId(reqLoginVo.getUserId());
        bizVO.setMdfrId(reqLoginVo.getUserId());

        bizVO.setInputMcnt(calculateInputMcnt(bizVO.getInputBgngYmd(), bizVO.getInputEndYmd()));

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

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());
        bizVO.setRgtrId(reqLoginVo.getUserId());
        bizVO.setMdfrId(reqLoginVo.getUserId());

        int cnt = bizService.deleteBizMnpw(bizVO);
        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }

    @RequestMapping(value = "/biz/cstList.ajax")
    public ModelAndView selectBizCstList(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());

        List<BizVO> list = bizService.selectBizCstList(bizVO);

        mav.addObject("result", "OK");
        mav.addObject("list", list);

        return mav;
    }

    @RequestMapping(value = "/biz/cstSave.ajax")
    public ModelAndView saveBizCst(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());
        bizVO.setRgtrId(reqLoginVo.getUserId());
        bizVO.setMdfrId(reqLoginVo.getUserId());

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

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());
        bizVO.setRgtrId(reqLoginVo.getUserId());
        bizVO.setMdfrId(reqLoginVo.getUserId());

        int cnt = bizService.deleteBizCst(bizVO);
        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }

    @RequestMapping(value = "/biz/schdlList.ajax")
    public ModelAndView selectBizSchdlList(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());

        List<BizVO> list = bizService.selectBizSchdlList(bizVO);

        mav.addObject("result", "OK");
        mav.addObject("list", list);

        return mav;
    }

    @RequestMapping(value = "/biz/schdlSave.ajax")
    public ModelAndView saveBizSchdl(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());
        bizVO.setRgtrId(reqLoginVo.getUserId());
        bizVO.setMdfrId(reqLoginVo.getUserId());

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

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());
        bizVO.setRgtrId(reqLoginVo.getUserId());
        bizVO.setMdfrId(reqLoginVo.getUserId());

        int cnt = bizService.deleteBizSchdl(bizVO);
        mav.addObject("result", cnt > 0 ? "OK" : "FAIL");

        return mav;
    }

    @RequestMapping(value = "/biz/profitSummary.ajax")
    public ModelAndView selectBizProfitSummary(@ModelAttribute("bizVO") BizVO bizVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");

        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        bizVO.setCoId(reqLoginVo.getCoId());

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
     * 로그인 사용자 세션에 적재된 회사코드(CO_INFO.CO_CD)를 기준으로 사업코드를 생성한다.
     *
     * @param bizVO 회사ID가 설정된 사업 VO. 다음 일련번호 조회 시 CO_ID와 사업코드 prefix를 사용한다.
     * @param coCd 로그인 사용자 회사코드(CO_INFO.CO_CD)
     * @return 회사코드-연도-일련번호 형식의 사업코드. 예: TR-26-0001
     * @throws Exception 다음 일련번호 조회 중 예외 발생 시 전달
     */
    private String createBizCd(BizVO bizVO, String coCd) throws Exception {
        String coPrefix = normalizeCompanyCode(coCd);
        String yy = new SimpleDateFormat("yy").format(new Date());
        String prefix = coPrefix + "-" + yy + "-";
        bizVO.setBizCdPrefix(prefix);
        int nextSeq = bizService.selectNextBizCdSeq(bizVO);
        return prefix + String.format("%04d", nextSeq);
    }

    /**
     * 사업코드 생성에 사용할 회사코드를 영문/숫자 대문자 형태로 정규화한다.
     *
     * @param coCd 로그인 사용자 회사코드(CO_INFO.CO_CD)
     * @return 정규화된 회사코드. 회사코드가 비어 있으면 기본값 CO 반환
     */
    private String normalizeCompanyCode(String coCd) {
        if (coCd == null || coCd.trim().isEmpty()) {
            return "CO";
        }
        String normalized = coCd.replaceAll("[^A-Za-z0-9]", "").toUpperCase();
        return normalized.isEmpty() ? "CO" : normalized;
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
