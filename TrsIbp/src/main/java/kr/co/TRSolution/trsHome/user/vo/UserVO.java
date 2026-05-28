package kr.co.TRSolution.trsHome.user.vo;

/**
 * 사용자 VO (Value Object)
 * 테이블: USER_INFO, AUTH_INFO, COMPANY_INFO, DEPT_INFO JOIN
 *
 * @author DevSync
 * @since 2026-05-28
 */
public class UserVO {

    // ============================================================
    // USER_INFO 컬럼
    // ============================================================

    /** 사용자ID (PK) */
    private String userId;

    /** 비밀번호 (BCrypt 해시) */
    private String userPw;

    /** 사용자명 */
    private String userName;

    /** 소속회사ID (COMPANY_INFO.COMPANY_ID FK) */
    private String companyId;

    /** 소속부서ID (DEPT_INFO.DEPT_ID FK) */
    private String deptId;

    /** 직급/직책 (대표/본부장/팀장/팀원 등 자유입력) */
    private String position;

    /** 권한ID (AUTH_INFO.AUTH_ID FK) */
    private String authId;

    /** 연락처 */
    private String userTel;

    /** 내선번호 */
    private String inTel;

    /** 사용여부 (Y/N) */
    private String flagUse;

    /** 메모 */
    private String memo;

    /** 가입일시 */
    private String regDt;

    // ============================================================
    // JOIN 조회용 컬럼
    // ============================================================

    /** 회사명 (COMPANY_INFO.COMPANY_NAME) */
    private String companyName;

    /** 부서명 (DEPT_INFO.DEPT_NAME) */
    private String deptName;

    /** 상위부서명 (DEPT_INFO.PARENT_DEPT_ID JOIN) */
    private String parentDeptName;

    /** 권한명 (AUTH_INFO.AUTH_NAME) */
    private String authName;

    // ============================================================
    // 검색 조건용
    // ============================================================

    /** 검색 타입 (userId / userName 등) */
    private String searchType;

    /** 검색 값 */
    private String searchValue;

    /** 검색 시작일 */
    private String sDate;

    /** 검색 종료일 */
    private String eDate;

    // ============================================================
    // Getter / Setter
    // ============================================================

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getUserPw() { return userPw; }
    public void setUserPw(String userPw) { this.userPw = userPw; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getCompanyId() { return companyId; }
    public void setCompanyId(String companyId) { this.companyId = companyId; }

    public String getDeptId() { return deptId; }
    public void setDeptId(String deptId) { this.deptId = deptId; }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }

    public String getAuthId() { return authId; }
    public void setAuthId(String authId) { this.authId = authId; }

    public String getUserTel() { return userTel; }
    public void setUserTel(String userTel) { this.userTel = userTel; }

    public String getInTel() { return inTel; }
    public void setInTel(String inTel) { this.inTel = inTel; }

    public String getFlagUse() { return flagUse; }
    public void setFlagUse(String flagUse) { this.flagUse = flagUse; }

    public String getMemo() { return memo; }
    public void setMemo(String memo) { this.memo = memo; }

    public String getRegDt() { return regDt; }
    public void setRegDt(String regDt) { this.regDt = regDt; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }

    public String getParentDeptName() { return parentDeptName; }
    public void setParentDeptName(String parentDeptName) { this.parentDeptName = parentDeptName; }

    public String getAuthName() { return authName; }
    public void setAuthName(String authName) { this.authName = authName; }

    public String getSearchType() { return searchType; }
    public void setSearchType(String searchType) { this.searchType = searchType; }

    public String getSearchValue() { return searchValue; }
    public void setSearchValue(String searchValue) { this.searchValue = searchValue; }

    public String getsDate() { return sDate; }
    public void setsDate(String sDate) { this.sDate = sDate; }

    public String geteDate() { return eDate; }
    public void seteDate(String eDate) { this.eDate = eDate; }

    @Override
    public String toString() {
        return "UserVO [userId=" + userId + ", userName=" + userName
                + ", companyId=" + companyId + ", deptId=" + deptId
                + ", position=" + position + ", authId=" + authId
                + ", flagUse=" + flagUse + "]";
    }
}
