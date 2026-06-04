package kr.co.TRSolution.trsIbp.user.service;

import java.util.List;
import java.util.Map;

import kr.co.TRSolution.trsIbp.user.vo.UserVO;

/**
 * 사용자 서비스 인터페이스
 *
 * @author DevSync
 * @since 2026-05-28
 */
public interface UserService {

    /** 사용자 목록 조회 */
    public List<UserVO> selectUserList(UserVO userVO) throws Exception;

    /** 특정 사용자 단건 조회 */
    public UserVO selectUser(UserVO userVO) throws Exception;

    /** 로그인용 단건 조회 (비밀번호 포함) */
    public UserVO selectUserForLogin(UserVO userVO) throws Exception;

    /** 사용자 등록 */
    public void insertUser(UserVO userVO) throws Exception;

    /** 사용자 정보 수정 */
    public void updateUser(UserVO userVO);

    /** 사용자 삭제 */
    public void deleteUser(UserVO userVO);

    /** 회사 목록 조회 */
    public List<Map<String, Object>> selectCompanyList(UserVO userVO);

    /** 권한 목록 조회 */
    public List<Map<String, Object>> selectAuthList();
}
