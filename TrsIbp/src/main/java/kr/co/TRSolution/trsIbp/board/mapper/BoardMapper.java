package kr.co.TRSolution.trsIbp.board.mapper;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.TRSolution.trsIbp.board.vo.BoardVO;

@Mapper("boardMapper")
public interface BoardMapper {
    List<BoardVO> selectBoardList(BoardVO boardVO) throws Exception;
    BoardVO selectBoard(BoardVO boardVO) throws Exception;
    int insertBoard(BoardVO boardVO) throws Exception;
    int updateBoard(BoardVO boardVO) throws Exception;
    int deleteBoard(BoardVO boardVO) throws Exception;
    int deactivateBoardFile(BoardVO boardVO) throws Exception;
}
