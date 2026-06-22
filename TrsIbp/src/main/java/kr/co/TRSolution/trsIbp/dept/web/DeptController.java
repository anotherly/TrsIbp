package kr.co.TRSolution.trsIbp.dept.web;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import kr.co.TRSolution.trsIbp.dept.service.DeptService;
import kr.co.TRSolution.trsIbp.dept.vo.DeptVO;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

@Controller
public class DeptController {

    public static final Logger logger = LoggerFactory.getLogger(DeptController.class);

    @Resource(name = "deptService")
    private DeptService deptService;

    /**
	 * [신규 API] 회원가입 시 선택한 회사의 소속 부서 풀 동적 반환
	 */
	@RequestMapping(value = "/login/selectDeptList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView selectDeptList(@ModelAttribute UserVO userVO) {
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			logger.debug("▶ [부서 트리 엔진 가동] 요청 회사 ID: {}", userVO.getCoId());

			// List<UserVO> 대신 List<Map<String, Object>> 형태로 서비스 레이어 호출 교체
			List<DeptVO> deptTreeList = deptService.selectDeptList(userVO);

			// Ajax 응답용 데이터 바인딩
			mav.addObject("list", deptTreeList);
			mav.addObject("result", "OK");
		} catch (Exception e) {
			logger.error("▶ 부서 로드 런타임 장애: {}", e.toString());
		}
		return mav;
	}
    
    /**
     * [C] 부서 신규 등록 API (비동기 AJAX)
     */
    @RequestMapping(value = "/dept/insertDept.ajax", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView insertDept(@ModelAttribute DeptVO deptVO) {
        ModelAndView mav = new ModelAndView("jsonView");
        try {
            logger.debug("▶ [부서 등록 요청] 부서명: {}, 상위부서ID: {}", deptVO.getDeptNm(), deptVO.getUpDeptId());
            deptService.insertDept(deptVO);
            mav.addObject("result", "OK");
        } catch (Exception e) {
            logger.error("▶ 부서 등록 장애: {}", e.toString());
            mav.addObject("result", "ERROR");
            mav.addObject("msg", "부서 코드 중복 또는 기타 오류로 등록에 실패했습니다.");
        }
        return mav;
    }

    /**
     * [R-1] 회사별 부서 리스트 전체 조회 (트리 구조 빌드용 데이터 피드)
     */
    @RequestMapping(value = "/dept/selectDeptTreeList.ajax", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView selectDeptTreeList(@ModelAttribute DeptVO deptVO) {
        ModelAndView mav = new ModelAndView("jsonView");
        try {
            // jstree 친화형 트리구조 리스트 반환 수용
            List<Map<String, Object>> treeList = deptService.selectDeptTreeList(deptVO);
            mav.addObject("list", treeList);
            mav.addObject("result", "OK");
        } catch (Exception e) {
            logger.error("▶ 부서 트리 조회 장애: {}", e.toString());
            mav.addObject("result", "ERROR");
        }
        return mav;
    }

    /**
     * [R-2] 특정 부서 단건 상세 조회
     */
    @RequestMapping(value = "/dept/selectDeptDetail.ajax", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView selectDeptDetail(@ModelAttribute DeptVO deptVO) {
        ModelAndView mav = new ModelAndView("jsonView");
        try {
            DeptVO detail = deptService.selectDeptDetail(deptVO);
            mav.addObject("detail", detail);
            mav.addObject("result", "OK");
        } catch (Exception e) {
            logger.error("▶ 부서 상세 조회 장애: {}", e.toString());
            mav.addObject("result", "ERROR");
        }
        return mav;
    }

    /**
     * [U] 부서 정보 수정 API
     */
    @RequestMapping(value = "/dept/updateDept.ajax", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView updateDept(@ModelAttribute DeptVO deptVO) {
        ModelAndView mav = new ModelAndView("jsonView");
        try {
            logger.debug("▶ [부서 수정 요청] 부서ID: {}, 변경부서명: {}", deptVO.getDeptId(), deptVO.getDeptNm());
            deptService.updateDept(deptVO);
            mav.addObject("result", "OK");
        } catch (Exception e) {
            logger.error("▶ 부서 수정 장애: {}", e.toString());
            mav.addObject("result", "ERROR");
        }
        return mav;
    }

    /**
     * [D] 부서 정보 삭제 (실무적 안전장치: USE_YN = 'N' 처리)
     */
    @RequestMapping(value = "/dept/deleteDept.ajax", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView deleteDept(@ModelAttribute DeptVO deptVO) {
        ModelAndView mav = new ModelAndView("jsonView");
        try {
            logger.debug("▶ [부서 삭제 요청] 부서ID: {}", deptVO.getDeptId());
            deptService.deleteDept(deptVO);
            mav.addObject("result", "OK");
        } catch (Exception e) {
            logger.error("▶ 부서 삭제 장애: {}", e.toString());
            mav.addObject("result", "ERROR");
        }
        return mav;
    }
}