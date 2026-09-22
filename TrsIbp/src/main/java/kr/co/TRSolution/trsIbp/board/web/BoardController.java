package kr.co.TRSolution.trsIbp.board.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.TRSolution.trsIbp.board.service.BoardService;
import kr.co.TRSolution.trsIbp.board.vo.BoardVO;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

@Controller
public class BoardController {

    @Resource(name="boardService")
    private BoardService boardService;

    @RequestMapping("/board/boardList.do")
    public String boardList() {
        return "/board/boardList";
    }

    @RequestMapping("/board/boardList.ajax")
    public ModelAndView selectBoardList(@ModelAttribute BoardVO boardVO, HttpServletRequest request) throws Exception {
        UserVO loginUser = requireLogin(request);
        boardVO.setCoId(loginUser.getCoId());
        ModelAndView mav = jsonView();
        mav.addObject("list", boardService.selectBoardList(boardVO));
        mav.addObject("result", "OK");
        return mav;
    }

    @RequestMapping("/board/boardDetail.ajax")
    public ModelAndView selectBoardDetail(@ModelAttribute BoardVO boardVO, HttpServletRequest request) throws Exception {
        UserVO loginUser = requireLogin(request);
        boardVO.setCoId(loginUser.getCoId());
        BoardVO detail = boardService.selectBoard(boardVO);
        ModelAndView mav = jsonView();
        if (detail == null) {
            mav.addObject("result", "FAIL");
            mav.addObject("msg", "게시글을 찾을 수 없습니다.");
            return mav;
        }
        List<Map<String, Object>> files = boardService.selectBoardFileList(loginUser.getCoId(), detail.getBoardSn());
        boolean editable = loginUser.getUserId().equals(detail.getRgtrId())
                || "ADMIN".equals(loginUser.getAuthrtId()) || "MANAGER".equals(loginUser.getAuthrtId());
        mav.addObject("detail", detail);
        mav.addObject("files", files);
        mav.addObject("editable", editable);
        mav.addObject("result", "OK");
        return mav;
    }

    @RequestMapping(value="/board/boardSave.ajax", method=RequestMethod.POST)
    public ModelAndView saveBoard(@ModelAttribute BoardVO boardVO,
            @RequestParam(value="boardFiles", required=false) MultipartFile[] boardFiles,
            @RequestParam(value="deleteFileSns", required=false) String deleteFileSns,
            HttpServletRequest request) {
        ModelAndView mav = jsonView();
        try {
            UserVO loginUser = requireLogin(request);
            boardService.saveBoard(boardVO, boardFiles, deleteFileSns, loginUser);
            mav.addObject("result", "OK");
            mav.addObject("boardSn", boardVO.getBoardSn());
        } catch (Exception e) {
            mav.addObject("result", "FAIL");
            mav.addObject("msg", e.getMessage());
        }
        return mav;
    }

    @RequestMapping(value="/board/boardDelete.ajax", method=RequestMethod.POST)
    public ModelAndView deleteBoard(@ModelAttribute BoardVO boardVO, HttpServletRequest request) {
        ModelAndView mav = jsonView();
        try {
            UserVO loginUser = requireLogin(request);
            mav.addObject("result", boardService.deleteBoard(boardVO, loginUser) > 0 ? "OK" : "FAIL");
        } catch (Exception e) {
            mav.addObject("result", "FAIL");
            mav.addObject("msg", e.getMessage());
        }
        return mav;
    }

    private UserVO requireLogin(HttpServletRequest request) {
        UserVO loginUser = (UserVO) request.getSession().getAttribute("login");
        if (loginUser == null || loginUser.getCoId() == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }
        return loginUser;
    }

    private ModelAndView jsonView() {
        return new ModelAndView("jsonView");
    }
}
