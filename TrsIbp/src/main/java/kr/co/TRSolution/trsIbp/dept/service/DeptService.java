package kr.co.TRSolution.trsIbp.dept.service;

import java.util.List;
import java.util.Map;
import kr.co.TRSolution.trsIbp.dept.vo.DeptVO;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

public interface DeptService {
    /** 부서 목록 조회 (트리구조용) */
    public List<Map<String, Object>> selectDeptList(DeptVO deptVO);

    void insertDept(DeptVO deptVO) throws Exception;
    List<Map<String, Object>> selectDeptTreeList(DeptVO deptVO) throws Exception;
    DeptVO selectDeptDetail(DeptVO deptVO) throws Exception;
    void updateDept(DeptVO deptVO) throws Exception;
    void deleteDept(DeptVO deptVO) throws Exception;
}