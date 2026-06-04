package kr.co.TRSolution.trsIbp.user.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.TRSolution.trsIbp.user.mapper.UserMapper;
import kr.co.TRSolution.trsIbp.user.service.UserService;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

/**
 * 사용자 서비스 구현 클래스
 *
 * @author DevSync
 * @since 2026-05-28
 */
@Service("userService")
public class UserServiceImpl implements UserService {

    @Resource(name = "userMapper")
    private UserMapper userMapper;

    /** 사용자 목록 조회 */
    @Override
    public List<UserVO> selectUserList(UserVO userVO) throws Exception {
        return userMapper.selectUser(userVO);
    }

    /** 특정 사용자 단건 조회 */
    @Override
    public UserVO selectUser(UserVO userVO) throws Exception {
        List<UserVO> list = userMapper.selectUser(userVO);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;
    }

    /** 로그인용 단건 조회 (비밀번호 포함) */
    @Override
    public UserVO selectUserForLogin(UserVO userVO) throws Exception {
        return userMapper.selectUserForLogin(userVO);
    }

    /** 사용자 등록 */
    @Override
    public void insertUser(UserVO userVO) throws Exception {
        userMapper.insertUser(userVO);
    }

    /** 사용자 정보 수정 */
    @Override
    public void updateUser(UserVO userVO) {
        userMapper.updateUser(userVO);
    }

    /** 사용자 삭제 */
    @Override
    public void deleteUser(UserVO userVO) {
        userMapper.deleteUser(userVO);
    }

    /** 회사 목록 조회 */
    @Override
    public List<Map<String, Object>> selectCompanyList(UserVO userVO) {
        return userMapper.selectCompanyList(userVO);
    }

    /** 권한 목록 조회 */
    @Override
    public List<Map<String, Object>> selectAuthList() {
        return userMapper.selectAuthList();
    }
}
