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
    private String deptNm;        // 부서명
    private String upDeptId;    // 상위 부서 ID (Self-Join용)
    private int sortDeptSeq;          // 정렬 순서
    
    // [화면 확장 필드] 조인을 통해 받아올 상위 부서명
    private String upDeptNm;

    // ===================================================
    // Getter & Setter
    // ===================================================
    public String getDeptId() { return deptId; }
    public void setDeptId(String deptId) { this.deptId = deptId; }

    public String getDeptNm() { return deptNm; }
    public void setDeptNm(String deptNm) { this.deptNm = deptNm; }

    public String getUpDeptId() { return upDeptId; }
    public void setUpDeptId(String upDeptId) { this.upDeptId = upDeptId; }

    public int getSortDeptSeq() { return sortDeptSeq; }
    public void setSortDeptSeq(int sortDeptSeq) { this.sortDeptSeq = sortDeptSeq; }

    public String getUpDeptNm() { return upDeptNm; }
    public void setUpDeptNm(String upDeptNm) { this.upDeptNm = upDeptNm; }

    @Override
    public String toString() {
        return "DeptVO [deptId=" + deptId + ", deptNm=" + deptNm + ", upDeptId=" + upDeptId + ", coId=" + getCoId() + "]";
    }
}