package kr.co.TRSolution.trsIbp.dept.mapper;

import java.util.List;
import java.util.Map;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.TRSolution.trsIbp.dept.vo.DeptVO;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

@Mapper("deptMapper")
public interface DeptMapper {

    /** 부서 목록 조회 (트리구조용) */
    public List<DeptVO> selectDeptList(UserVO userVO);
    void insertDept(DeptVO deptVO) throws Exception;
    List<Map<String, Object>> selectDeptTreeList(DeptVO deptVO) throws Exception;
    DeptVO selectDeptDetail(DeptVO deptVO) throws Exception;
    void updateDept(DeptVO deptVO) throws Exception;
    void deleteDept(DeptVO deptVO) throws Exception;
}