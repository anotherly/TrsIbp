package kr.co.TRSolution.trsIbp.dept.vo;

import kr.co.TRSolution.trsIbp.company.vo.CompanyVO;

/**
 * 부서 정보 VO (CompanyVO를 상속받아 회사 및 BaseVO 속성을 가짐)
 */
public class DeptVO extends CompanyVO {

    private static final long serialVersionUID = 1L;

    // ===================================================
    // [trsIbp.sql] DEPT_INFO 테이블 물리 컬럼 매핑
    // ===================================================
    private String deptId;          // 부서 ID (PK)
    private String deptName;        // 부서명
    private String parentDeptId;    // 상위 부서 ID (Self-Join용)
    private int deptSortOrder;          // 정렬 순서
    
    // [화면 확장 필드] 조인을 통해 받아올 상위 부서명
    private String parentDeptName;

    // ===================================================
    // Getter & Setter
    // ===================================================
    public String getDeptId() { return deptId; }
    public void setDeptId(String deptId) { this.deptId = deptId; }

    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }

    public String getParentDeptId() { return parentDeptId; }
    public void setParentDeptId(String parentDeptId) { this.parentDeptId = parentDeptId; }

    public int getDeptSortOrder() { return deptSortOrder; }
    public void setDeptSortOrder(int deSortOrder) { this.deptSortOrder = deptSortOrder; }

    public String getParentDeptName() { return parentDeptName; }
    public void setParentDeptName(String parentDeptName) { this.parentDeptName = parentDeptName; }

    @Override
    public String toString() {
        return "DeptVO [deptId=" + deptId + ", deptName=" + deptName + ", parentDeptId=" + parentDeptId + ", companyId=" + getCompanyId() + "]";
    }
}