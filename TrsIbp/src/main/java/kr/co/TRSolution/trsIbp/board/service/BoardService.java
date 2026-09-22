package kr.co.TRSolution.trsIbp.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.co.TRSolution.trsIbp.board.vo.BoardVO;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

public interface BoardService {
    List<BoardVO> selectBoardList(BoardVO boardVO) throws Exception;
    BoardVO selectBoard(BoardVO boardVO) throws Exception;
    List<Map<String, Object>> selectBoardFileList(String coId, Long boardSn) throws Exception;
    void saveBoard(BoardVO boardVO, MultipartFile[] boardFiles, String deleteFileSns, UserVO loginUser) throws Exception;
    int deleteBoard(BoardVO boardVO, UserVO loginUser) throws Exception;
}
