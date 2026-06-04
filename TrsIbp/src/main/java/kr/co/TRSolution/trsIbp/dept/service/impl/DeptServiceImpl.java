package kr.co.TRSolution.trsIbp.dept.service.impl;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import kr.co.TRSolution.trsIbp.dept.mapper.DeptMapper;
import kr.co.TRSolution.trsIbp.dept.service.DeptService;
import kr.co.TRSolution.trsIbp.dept.vo.DeptVO;
import kr.co.TRSolution.trsIbp.user.vo.UserVO;

@Service("deptService")
public class DeptServiceImpl implements DeptService {

    @Resource(name = "deptMapper")
    private DeptMapper deptMapper;

    /** 부서 목록 조회 (트리구조용) */
    @Override
    public List<Map<String, Object>> selectDeptList(DeptVO deptVO) {
        return deptMapper.selectDeptList(deptVO);
    }
    
    @Override
    public void insertDept(DeptVO deptVO) throws Exception {
        deptMapper.insertDept(deptVO);
    }

    @Override
    public List<Map<String, Object>> selectDeptTreeList(DeptVO deptVO) throws Exception {
        // 부서 목록을 LinkedHashMap으로 순서 보장하여 호출
        return deptMapper.selectDeptTreeList(deptVO);
    }

    @Override
    public DeptVO selectDeptDetail(DeptVO deptVO) throws Exception {
        return deptMapper.selectDeptDetail(deptVO);
    }

    @Override
    public void updateDept(DeptVO deptVO) throws Exception {
        deptMapper.updateDept(deptVO);
    }

    @Override
    public void deleteDept(DeptVO deptVO) throws Exception {
        deptMapper.deleteDept(deptVO);
    }
}