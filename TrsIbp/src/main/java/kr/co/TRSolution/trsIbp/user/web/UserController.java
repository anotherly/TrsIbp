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
	
}
