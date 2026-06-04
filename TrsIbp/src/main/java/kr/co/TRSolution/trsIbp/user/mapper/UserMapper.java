package kr.co.TRSolution.trsIbp.user.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

/**
 * 사용자 매퍼 인터페이스
 * 테이블: USER_INFO, AUTH_INFO, COMPANY_INFO, DEPT_INFO
 *
 * @author DevSync
 * @since 2026-05-28
 */
@Mapper("userMapper")
public interface UserMapper {

    /** 사용자 목록/단건 조회 */
    public List<UserVO> selectUser(UserVO userVO) throws Exception;

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
