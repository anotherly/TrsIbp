package kr.co.TRSolution.trsIbp.board.service.impl;

import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.TRSolution.trsIbp.board.mapper.BoardMapper;
import kr.co.TRSolution.trsIbp.board.service.BoardService;
import kr.co.TRSolution.trsIbp.board.vo.BoardVO;
import kr.co.TRSolution.trsIbp.comm.file.mapper.CommonFileMapper;
import kr.co.TRSolution.trsIbp.comm.file.service.CommonFileService;
import kr.co.TRSolution.trsIbp.comm.file.vo.CommonFileVO;
import kr.co.TRSolution.trsIbp.comm.file.web.CommonFileController;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
    private static final String REF_SE_CD = "BOARD";
    private static final String FILE_SE_CD = "ATTACH";
    private static final int MAX_FILE_COUNT = 10;

    @Resource(name="boardMapper") private BoardMapper boardMapper;
    @Resource(name="commonFileMapper") private CommonFileMapper commonFileMapper;
    @Resource(name="commonFileService") private CommonFileService commonFileService;

    @Override
    public List<BoardVO> selectBoardList(BoardVO boardVO) throws Exception {
        return boardMapper.selectBoardList(boardVO);
    }

    @Override
    public BoardVO selectBoard(BoardVO boardVO) throws Exception {
        return boardMapper.selectBoard(boardVO);
    }

    @Override
    public List<Map<String, Object>> selectBoardFileList(String coId, Long boardSn) throws Exception {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        if (coId == null || boardSn == null) return result;
        CommonFileVO param = new CommonFileVO();
        param.setCoId(coId);
        param.setRefSeCd(REF_SE_CD);
        param.setRefId(String.valueOf(boardSn));
        param.setFileSeCd(FILE_SE_CD);
        for (CommonFileVO file : commonFileMapper.selectFileList(param)) {
            result.add(CommonFileController.toClientFile(file));
        }
        return result;
    }

    @Override
    @Transactional(rollbackFor=Exception.class)
    public void saveBoard(BoardVO boardVO, MultipartFile[] boardFiles, String deleteFileSns, UserVO loginUser) throws Exception {
        validate(boardVO);
        boardVO.setCoId(loginUser.getCoId());
        boardVO.setMdfrId(loginUser.getUserId());

        if (boardVO.getBoardSn() == null) {
            boardVO.setRgtrId(loginUser.getUserId());
            boardMapper.insertBoard(boardVO);
        } else {
            BoardVO existing = selectExisting(boardVO.getCoId(), boardVO.getBoardSn());
            ensureEditable(existing, loginUser);
            if (boardMapper.updateBoard(boardVO) < 1) {
                throw new IllegalArgumentException("수정할 게시글을 찾을 수 없습니다.");
            }
        }

        if (deleteFileSns != null && !deleteFileSns.trim().isEmpty()) {
            String[] values = deleteFileSns.split(",");
            for (String value : values) {
                if (value == null || value.trim().isEmpty()) continue;
                BoardVO fileParam = new BoardVO();
                fileParam.setCoId(boardVO.getCoId());
                fileParam.setBoardSn(boardVO.getBoardSn());
                try {
                    fileParam.setAtchFileSn(Long.valueOf(value.trim()));
                    boardMapper.deactivateBoardFile(fileParam);
                } catch (NumberFormatException ignore) {
                    // 잘못된 파일번호는 무시
                }
            }
        }

        List<Map<String, Object>> existingFiles = selectBoardFileList(boardVO.getCoId(), boardVO.getBoardSn());
        int newFileCount = 0;
        if (boardFiles != null) {
            for (MultipartFile file : boardFiles) if (file != null && !file.isEmpty()) newFileCount++;
        }
        if (existingFiles.size() + newFileCount > MAX_FILE_COUNT) {
            throw new IllegalArgumentException("첨부파일은 기존 파일을 포함해 최대 10개까지 등록할 수 있습니다.");
        }

        int sortSeq = existingFiles.size() + 1;
        if (boardFiles != null) {
            for (MultipartFile file : boardFiles) {
                if (file == null || file.isEmpty()) continue;
                CommonFileVO stored = commonFileService.storeFileOnly(file, "board", FILE_SE_CD);
                stored.setCoId(boardVO.getCoId());
                stored.setRefSeCd(REF_SE_CD);
                stored.setRefId(String.valueOf(boardVO.getBoardSn()));
                stored.setRgtrId(loginUser.getUserId());
                stored.setSortSeq(sortSeq++);
                try {
                    commonFileMapper.insertFile(stored);
                } catch (Exception e) {
                    Files.deleteIfExists(commonFileService.resolveStoredFile(stored));
                    throw e;
                }
            }
        }
    }

    @Override
    @Transactional(rollbackFor=Exception.class)
    public int deleteBoard(BoardVO boardVO, UserVO loginUser) throws Exception {
        boardVO.setCoId(loginUser.getCoId());
        BoardVO existing = selectExisting(boardVO.getCoId(), boardVO.getBoardSn());
        ensureEditable(existing, loginUser);
        boardVO.setMdfrId(loginUser.getUserId());
        return boardMapper.deleteBoard(boardVO);
    }

    private BoardVO selectExisting(String coId, Long boardSn) throws Exception {
        BoardVO search = new BoardVO();
        search.setCoId(coId);
        search.setBoardSn(boardSn);
        BoardVO existing = boardMapper.selectBoard(search);
        if (existing == null) throw new IllegalArgumentException("게시글을 찾을 수 없습니다.");
        return existing;
    }

    private void ensureEditable(BoardVO board, UserVO loginUser) {
        boolean manager = "ADMIN".equals(loginUser.getAuthrtId()) || "MANAGER".equals(loginUser.getAuthrtId());
        if (!manager && !loginUser.getUserId().equals(board.getRgtrId())) {
            throw new IllegalArgumentException("본인이 작성한 게시글만 수정하거나 삭제할 수 있습니다.");
        }
    }

    private void validate(BoardVO boardVO) {
        if (boardVO.getBoardTitle() == null || boardVO.getBoardTitle().trim().isEmpty()) {
            throw new IllegalArgumentException("제목을 입력해 주세요.");
        }
        if (boardVO.getBoardCn() == null || boardVO.getBoardCn().trim().isEmpty()) {
            throw new IllegalArgumentException("내용을 입력해 주세요.");
        }
    }
}
