package kr.co.TRSolution.trsHome.comm;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AuthInterceptor extends HandlerInterceptorAdapter {

//	public static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
//
//	@Resource(name = "authService")
//	private AuthService authService;
//
//	/**
//	 * 컨트롤러 수행전에 세션 정보가 있는지 확인하는 처리..
//	 */
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//		logger.debug("☎☎☎☎☎☎☎☎☎☎☎☎☎☎☎☎.AUTH -  프리핸들 request : " + request);
//		logger.debug("☎☎☎☎☎☎☎☎☎☎☎☎☎☎☎☎.AUTH -  프리핸들 request.getSession() : " + request.getSession());
//		logger.debug(request.getRequestURL().toString());
//		String furl = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
//		boolean rtn = false;//최종 t/f 리턴값
//		boolean ynUrl = false; // 권한관리 체크에 포함된 url인지 아닌지
//		
//		// 모든 컨트롤러의 요청을 다 받음 로그인 빼고
//		// 그러면 common/main 같은건 디비에 없으니
//		// -> 디스패쳐 서블릿에서 설정함
//		
//		// 현재 모든 세션 불러와서 접속한 세션이랑 호출한 세션이랑 
//		// 권한정보가 다를시 메시지와 함께 튕겨냄
//		
//		//	체크해서 로그인 사용자가 아닌데 들어온경우
//		//	-> 이 부분은 해당 리퀘스트 세션을 가지고 체크해서
//		//	해당 세션으로 매핑된 사용자가 없을경우 튕겨버림
//		/*if(!SessionListener.getInstance().chkSessionNow(request, request.getSession())) {
//			return false;
//		}*/
//		
//		// 일단 동일한 사용자라는게 체크됬으면
//		// 디비 전체 권한 주소에 없는 주소 제외하고 있는 주소에서만 체크
//		// 그거 비교하는 if문 생성해야함
//		/*List<AuthVo> allUrlList = authService.authUrlList();
//		for (AuthVo urlVo : allUrlList) {
//			if(urlVo.getUrl().equals(furl)) {
//				ynUrl=true;
//			}
//		}	*/
//		// 새로고침이나 유효하지 않은 요청 제외하고는 권한체크
//		if (request.getSession().getAttribute("login") != null) {
//			logger.debug("☎☎☎☎☎☎☎☎☎☎☎☎☎☎☎☎.   request.getSession().getAttribute(login) : " + request.getSession().getAttribute("login"));
//			String nowUrl = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
//			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
//			UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
//			AuthVo avo = new AuthVo();
//			avo.setAuthCode(reqLoginVo.getAuthCode());
//			//25년 보안취약점 조치
//			//예외 케이스 명기
//			
//			if(//사용자,통신원,코드관리의 경우
//					nowUrl.equals("/user/userMain")||nowUrl.equals("/informer/informerMain")
//					||nowUrl.equals("/option/codeMng")
//					) {
//				avo.setCdFlag("3");
//			}else {
//				avo.setCdFlag("1");
//			}
//			//통신원등록창/등록수정
//			if(nowUrl.contains("/informer/")
//			 ||nowUrl.contains("/infrm/")
//			 ) {
//				nowUrl="/informer/informerMain";
//			}
//			//마일리지
//			if(nowUrl.contains("/mileage/")
//					) {
//				nowUrl="/informer/mileage/mileageMain";
//			}
//			//우수제보자
//			if(nowUrl.contains("/excellenceIfrm/")
//					) {
//				nowUrl="/informer/excellenceIfrm/excellenceIfrmMain";
//			}
//			//최고통신원
//			if(nowUrl.contains("/bestIfrm/")
//					) {
//				nowUrl="/informer/bestIfrm/bestIfrmMain";
//			}
//			//시상
//			if(nowUrl.contains("/award/")
//					) {
//				nowUrl="/informer/award/awardMain";
//			}
//			//행사
//			if(nowUrl.contains("/mileage/")
//					) {
//				nowUrl="/informer/mileage/mileageMain";
//			}
//			//통계관리
//			if(nowUrl.contains("/stats/")||nowUrl.contains("/stat/")
//					) {
//				nowUrl="/stats/standard";
//			}
//			//사용자관리
//			if(nowUrl.contains("/user/")
//					) {
//				nowUrl="/user/userMain";
//			}
//			
//			//코드관리
//			if(nowUrl.contains("/option/")
//					) {
//				//권한관리는 관리자만 조회 가능
//				if(nowUrl.contains("/auth/")) {
//					nowUrl="/option/auth/authList";
//				}else {
//					nowUrl="/option/reportType/main";
//				}
//			}
//			
//			avo.setUrl(nowUrl);
//			//예외주소 명기 종료
//			
//			List<AuthVo> alist = new ArrayList<>();
//			alist = authService.selectAuthUrl(avo);
//			if (alist.size() == 0) {// 현재 선택한 메뉴의 권한여부가 n일 경우
//				rtn =false;
//				return false;
//			}else {
//				rtn = true;
//			}
//		} else {
//			logger.debug("♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨세션 값이 존재하지 않음");
//			rtn =false;
//			return false;
//		}
//		
//		// 최초 로그인일 또는 새로고침의 경우
//		// 제보접수의 권한이 없을경우의 초기화면 처리
//		return rtn;
//	}
//
//	/**
//	 * 세션에 메뉴권한(SessionVO)이 있는지 여부로 메뉴권한 여부를 체크한다. 계정정보(SessionVO)가 없다면, 로그인 페이지로
//	 * 이동한다.
//	 */
//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//			ModelAndView modelAndView) throws Exception {
//		logger.debug("♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨.AUTH - postHandle 메소드 진입 : ");
//	}
//
//	/**
//	 * 
//	 */
//	@Override
//	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
//			throws Exception {
//		logger.info("★★★★★★★★★★★★★★★★★.Interceptor: afterCompletion");
//		super.afterCompletion(request, response, handler, ex);
//	}

} // end class