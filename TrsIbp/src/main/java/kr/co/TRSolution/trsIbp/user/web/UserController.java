package kr.co.TRSolution.trsIbp.user.web;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.TRSolution.trsIbp.user.service.UserService;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

/**
 * 사용자 컨트롤러 클래스
 * @author 솔루션사업팀 정다빈
 * @since 2021.07.23
 * @version 1.0
 * @see
 *
 * << 개정이력(Modification Information) >>
 *
 *   수정일            수정자              수정내용
 *  -------    -------- ---------------------------
 *  2021.07.23  정다빈           최초 생성
 */

@Controller
public class UserController {
	
	public static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Resource(name="userService")
	private UserService userService;

	public String url="";
	public boolean isClose = false;
	
	
	//주소에 맞게 매핑
	@RequestMapping(value="/user/*.do")
	public String userUrlMapping(HttpSession httpSession, HttpServletRequest request,Model model) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.user 최초 컨트롤러 진입 httpSession : "+httpSession);
		logger.debug("▶▶▶▶▶▶▶.request.getRequestURL() : "+request.getRequestURL());
		logger.debug("▶▶▶▶▶▶▶.request.getRequestURI() : "+request.getRequestURI());
		logger.debug("▶▶▶▶▶▶▶.request.getContextPath() : "+request.getContextPath());
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return url;
	}
	
	//22.03.16 긴급생성
	//1.  소메뉴 존재 항목에 관하여 권한 별 분기처리
	@RequestMapping(value="/user/first.do")
	public ModelAndView first(HttpSession httpSession, HttpServletRequest request,Model model) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		
		// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
		UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
		
		return mav;
	}
	
	//초기 검색버튼 활성화
	@RequestMapping(value= {"/user/userMain.do"})
	public ModelAndView userMain(HttpServletRequest request) throws Exception {
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView(url);
		// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
		UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
		return mav;
	}
	
	
	//사용자 목록 조회
	@RequestMapping(value="/user/userList.do")
	public @ResponseBody ModelAndView userList( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		UserVO uvo = new UserVO();
		//url로 h,g 판별하여 해당하는 값만 조회
		ModelAndView mav = new ModelAndView("jsonView");
		List<UserVO> userList= null;
		try {
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			if(userVO.getSearchValue()!=null) {
				uvo=userVO;
			}
			if(!(nlVo.getAuthrtId().equals("999"))) {//999 관리자 권한
				//관리자 권한이 아닐경우 관리자는 목록조회 안되도록
				uvo.setAuthrtId("998");
			}
			userList = userService.selectUserList(uvo);
			mav.setViewName("/user/userList");
			mav.addObject("userList", userList);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}

	/**
	 * 사용자 등록, 상세 페이지 이동 분기
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user/editUser.do")
	public ModelAndView editUser(HttpServletRequest request, @ModelAttribute UserVO userVO, RedirectAttributes redirectAttributes) throws Exception {
		ModelAndView mv = new ModelAndView("/user/userEdit");
		UserVO uvo = new UserVO();
		UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
		
		if (request.getParameter("pr1")!=null&&!(request.getParameter("pr1").equals(""))) {
			uvo.setUserId(request.getParameter("pr1"));
			uvo=userService.selectUser(uvo);
			mv.addObject("editDiv", "update");
			mv.setViewName("/user/userDetail");
		} else {
			mv.setViewName("/user/userInsert");
			mv.addObject("editDiv", "new");
		}
		mv.addObject("userInfo", uvo);
		return mv;
	}
	
	//사용자 등록
	@RequestMapping(value="/user/insertUser.ajax", method=RequestMethod.POST)
	public ModelAndView insertUser(HttpServletRequest request, @ModelAttribute UserVO userVO, RedirectAttributes redirectAttributes) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.request.getRequestURL() : "+request.getRequestURL());
		logger.debug("▶▶▶▶▶▶▶.request.getRequestURI() : "+request.getRequestURI());
		logger.debug("▶▶▶▶▶▶▶.request.getContextPath() : "+request.getContextPath());
		ModelAndView mav = new ModelAndView("jsonView");
		int cnt = 0;
		try {
			String authUrl = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
			//패스워드 암호화 처리
			logger.debug("변환전 uservo: "+userVO.toString());
			String hashedPw = BCrypt.hashpw(userVO.getUserEnpswd(), BCrypt.gensalt());
			userVO.setUserEnpswd(hashedPw);
			logger.debug("변환후 uservo: "+userVO.toString());
			userService.insertUser(userVO);
			cnt=1;
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		mav.addObject("cnt", cnt);
		return mav;
	}

	//검색한 id 조회
	@RequestMapping(value="/user/findUserId.do")
	public @ResponseBody ModelAndView findUserId( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		UserVO disUser= null;
		try {
			disUser = userService.selectUser(userVO);
			mav.addObject("data", disUser.getUserId());
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","search_not");
		}
		return mav;
	}

	//사용자 수정 페이지 진입
	@RequestMapping(value="/user/userUpdate.do")
	public @ResponseBody ModelAndView userUpdate( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		UserVO disUser= null;
		try {
			disUser = userService.selectUser(userVO);
			logger.debug("▶▶▶▶▶▶▶.시험코드 결과값들:"+disUser);
			
			mav.addObject("data", disUser);
			mav.setViewName(url);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	//사용자 수정 반영
	@RequestMapping(value="/user/userUpdate.ajax")
	public @ResponseBody ModelAndView userUpdateForm( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 수정!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		//비밀번호 암호화
		if(userVO.getUserEnpswd() != null && !"".equals(userVO.getUserEnpswd())) {
			String hashedPw = BCrypt.hashpw(userVO.getUserEnpswd(), BCrypt.gensalt());
			userVO.setUserEnpswd(hashedPw);
		}
		
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			userService.updateUser(userVO);
			
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}

	//사용자 삭제
	@RequestMapping(value="/user/userDelete.ajax")
	public @ResponseBody ModelAndView userDelete(  @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 삭제!!!!!!!!!!!!!!!!");
		int cnt = 0;
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			userService.deleteUser(userVO);
			cnt=1;
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","에러가 발생했습니다.");
		}
		mav.addObject("msg","현재 접속중인 사용자는 삭제할 수 없습니다!");
		mav.addObject("cnt", cnt);
		return mav;
	}
	
	/**
	 * 사용자 권한 등급 설정
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/user/authorityMgmt.do")
	public ModelAndView authorityMgmt(@ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception {
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		UserVO disUser= null;
		try {
			disUser = userService.selectUser(userVO);
			logger.debug("▶▶▶▶▶▶▶.시험코드 결과값들:"+disUser);
			
			List<UserVO> userList= null;
			
			mav.addObject("authList", userList);
			mav.setViewName(url);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","에러가 발생했습니다.");
		}
		return mav;
	}
	
	
	//사용자 로그인이력 조회
	@RequestMapping(value="/user/loginHistoryList.do")
	public @ResponseBody ModelAndView loginHistory( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		UserVO uvo = new UserVO();
		//url로 h,g 판별하여 해당하는 값만 조회
		ModelAndView mav = new ModelAndView("jsonView");
		List<UserVO> userList= null;
		try {
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			if(userVO.getSearchValue()!=null) {
				uvo=userVO;
			}
			mav.setViewName("/user/loginHistoryList");
			mav.addObject("userList", userList);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	//사용자 사용이력 조회
	@RequestMapping(value="/user/useHistoryList.do")
	public @ResponseBody ModelAndView useHistoryList( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		UserVO uvo = new UserVO();
		//url로 h,g 판별하여 해당하는 값만 조회
		ModelAndView mav = new ModelAndView("jsonView");
		List<UserVO> userList= null;
		try {
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			if(userVO.getSearchValue()!=null) {
				uvo=userVO;
			}
			mav.setViewName("/user/useHistoryList");
			mav.addObject("userList", userList);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
    /**
     * 사용자(직원) 관리 목록 화면으로 이동한다.
     * @param request 현재 요청 객체
     * @return 사용자 목록 JSP 경로
     * @throws Exception 화면 이동 중 예외 발생 시 전달
     */
    @RequestMapping(value="/user/empList.do")
    public ModelAndView empListPage(HttpServletRequest request) throws Exception {
        return new ModelAndView("/user/empList");
    }

    /**
     * 사용자(직원) 등록 화면으로 이동한다.
     * @param request 현재 요청 객체
     * @return 사용자 등록 JSP 경로
     * @throws Exception 화면 이동 중 예외 발생 시 전달
     */
    @RequestMapping(value="/user/empInsert.do")
    public ModelAndView empInsertPage(HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("/user/empInsert");
        mav.addObject("mode", "insert");
        return mav;
    }

    /**
     * 사용자(직원) 상세 화면으로 이동한다.
     * @param request 현재 요청 객체
     * @param userVO userId를 포함한 사용자 조회 조건
     * @return 사용자 상세 JSP 경로
     * @throws Exception 화면 이동 중 예외 발생 시 전달
     */
    @RequestMapping(value="/user/empDetail.do")
    public ModelAndView empDetailPage(HttpServletRequest request, @ModelAttribute("userVO") UserVO userVO) throws Exception {
        ModelAndView mav = new ModelAndView("/user/empDetail");
        mav.addObject("userId", userVO.getUserId());
        mav.addObject("mode", "detail");
        return mav;
    }

    /**
     * 사용자(직원) 수정 화면으로 이동한다.
     * @param request 현재 요청 객체
     * @param userVO userId를 포함한 사용자 조회 조건
     * @return 사용자 수정 JSP 경로
     * @throws Exception 화면 이동 중 예외 발생 시 전달
     */
    @RequestMapping(value="/user/empUpdate.do")
    public ModelAndView empUpdatePage(HttpServletRequest request, @ModelAttribute("userVO") UserVO userVO) throws Exception {
        ModelAndView mav = new ModelAndView("/user/empUpdate");
        mav.addObject("userId", userVO.getUserId());
        mav.addObject("mode", "update");
        return mav;
    }

    /**
     * 로그인 사용자 회사 기준 사용자(직원) 목록을 조회한다.
     * @param userVO 검색어, 부서, 권한, 사용여부 등 조회 조건
     * @param request 현재 요청 객체
     * @return 사용자 목록 JSON
     * @throws Exception 조회 중 예외 발생 시 전달
     */
    @RequestMapping(value="/user/empList.ajax")
    public ModelAndView selectEmpList(@ModelAttribute("userVO") UserVO userVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        userVO.setCoId(reqLoginVo.getCoId());
        List<UserVO> userList = userService.selectUserManageList(userVO);
        mav.addObject("userList", userList);
        return mav;
    }

    /**
     * 사용자(직원) 등록/수정/상세 화면에서 사용할 부서, 권한 목록을 조회한다.
     * @param userVO 조회 조건 VO
     * @param request 현재 요청 객체
     * @return 부서 목록, 권한 목록 JSON
     * @throws Exception 조회 중 예외 발생 시 전달
     */
    @RequestMapping(value="/user/empMeta.ajax")
    public ModelAndView selectEmpMeta(@ModelAttribute("userVO") UserVO userVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        userVO.setCoId(reqLoginVo.getCoId());
        mav.addObject("deptList", userService.selectDeptListByCoId(userVO));
        mav.addObject("authList", userService.selectAuthList());
        return mav;
    }

    /**
     * 로그인 사용자 회사 기준 사용자(직원) 단건을 조회한다.
     * @param userVO userId를 포함한 사용자 조회 조건
     * @param request 현재 요청 객체
     * @return 사용자 단건 JSON
     * @throws Exception 조회 중 예외 발생 시 전달
     */
    @RequestMapping(value="/user/empDetail.ajax")
    public ModelAndView selectEmpDetail(@ModelAttribute("userVO") UserVO userVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        userVO.setCoId(reqLoginVo.getCoId());
        mav.addObject("user", userService.selectUserManage(userVO));
        return mav;
    }

    /**
     * 사용자ID 중복 여부를 조회한다.
     * @param userVO userId를 포함한 조회 조건
     * @param request 현재 요청 객체
     * @return 중복 건수 JSON
     * @throws Exception 조회 중 예외 발생 시 전달
     */
    @RequestMapping(value="/user/empIdCheck.ajax")
    public ModelAndView checkEmpId(@ModelAttribute("userVO") UserVO userVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("cnt", userService.selectUserIdCount(userVO));
        return mav;
    }

    /**
     * 사용자(직원)를 등록하거나 수정한다.
     * @param userVO 저장할 사용자 정보
     * @param request 현재 요청 객체
     * @return 저장 결과 JSON
     * @throws Exception 저장 중 예외 발생 시 전달
     */
    @RequestMapping(value="/user/empSave.ajax", method=RequestMethod.POST)
    public ModelAndView saveEmp(@ModelAttribute("userVO") UserVO userVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        userVO.setCoId(reqLoginVo.getCoId());

        try {
            if (userVO.getUseYn() == null || "".equals(userVO.getUseYn())) {
                userVO.setUseYn("Y");
            }
            if (userVO.getUserId() == null || "".equals(userVO.getUserId().trim())) {
                mav.addObject("result", "FAIL");
                mav.addObject("msg", "사용자ID를 입력해 주세요.");
                return mav;
            }
            if (userVO.getUserNm() == null || "".equals(userVO.getUserNm().trim())) {
                mav.addObject("result", "FAIL");
                mav.addObject("msg", "사용자명을 입력해 주세요.");
                return mav;
            }
            if ("insert".equals(userVO.getSaveMode())) {
                if (userVO.getUserEnpswd() == null || "".equals(userVO.getUserEnpswd().trim())) {
                    mav.addObject("result", "FAIL");
                    mav.addObject("msg", "초기 비밀번호를 입력해 주세요.");
                    return mav;
                }
                if (userService.selectUserIdCount(userVO) > 0) {
                    mav.addObject("result", "DUP");
                    mav.addObject("msg", "이미 사용 중인 사용자ID입니다.");
                    return mav;
                }
                userVO.setUserEnpswd(BCrypt.hashpw(userVO.getUserEnpswd(), BCrypt.gensalt()));
                userService.insertUserManage(userVO);
            } else {
                if (userVO.getUserEnpswd() != null && !"".equals(userVO.getUserEnpswd().trim())) {
                    userVO.setUserEnpswd(BCrypt.hashpw(userVO.getUserEnpswd(), BCrypt.gensalt()));
                }
                userService.updateUserManage(userVO);
            }
            mav.addObject("result", "OK");
        } catch (Exception e) {
            logger.error("사용자 저장 중 오류 발생 userId : " + userVO.getUserId(), e);
            mav.addObject("result", "FAIL");
            mav.addObject("msg", "사용자 저장 중 오류가 발생했습니다.");
        }
        return mav;
    }

    /**
     * 사용자(직원)를 사용중지 처리한다.
     * @param userVO userId를 포함한 삭제 조건
     * @param request 현재 요청 객체
     * @return 삭제 결과 JSON
     * @throws Exception 삭제 중 예외 발생 시 전달
     */
    @RequestMapping(value="/user/empDelete.ajax", method=RequestMethod.POST)
    public ModelAndView deleteEmp(@ModelAttribute("userVO") UserVO userVO, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("jsonView");
        UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
        userVO.setCoId(reqLoginVo.getCoId());
        try {
            if (reqLoginVo.getUserId().equals(userVO.getUserId())) {
                mav.addObject("result", "FAIL");
                mav.addObject("msg", "현재 로그인 사용자는 삭제할 수 없습니다.");
                return mav;
            }
            userService.deleteUserManage(userVO);
            mav.addObject("result", "OK");
        } catch (Exception e) {
            logger.error("사용자 삭제 중 오류 발생 userId : " + userVO.getUserId(), e);
            mav.addObject("result", "FAIL");
            mav.addObject("msg", "사용자 삭제 중 오류가 발생했습니다.");
        }
        return mav;
    }

}
