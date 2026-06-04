package kr.co.TRSolution.trsIbp.comm;

import java.io.Serializable;

/**
 * 전사 공통 Base VO (Value Object)
 * - 모든 업무용 VO(UserVO, CompanyVO 등)는 이 클래스를 extends 상속받아 구현합니다.
 */
public class BaseVO implements Serializable {
    
    private static final long serialVersionUID = 1L;

    // ===================================================
    // 1. 시스템 공통 및 감사(Audit) 필드
    // ===================================================
    /** 등록일 (업무적 등록일, 기본: 당일 YYYY-MM-DD) */
    private String regDate;

    /** 생성일시 (DB Insert 시 자동 기록용) */
    private String createdAt;

    /** 수정일시 (DB Update 시 자동 기록용) */
    private String updatedAt;

    // ===================================================
    // 2. 전사 공통 UI 검색(Search) 필드 (과장님 설계 반영)
    // ===================================================
    /** 검색유형 (화면단 셀렉트박스 매핑 - 예: userId, companyName 등) */
    private String searchType;
    
    /** 검색어 (화면단 텍스트 창 입력 단어) */
    private String searchValue;
    
    /** 복합 검색용 통합 키워드 (별칭 매퍼 연동 편의용) */
    private String searchKeyword;
    
    /** 기간 검색: 시작일 (YYYY-MM-DD) */
    private String sDate;
    
    /** 기간 검색: 종료일 (YYYY-MM-DD) */
    private String eDate;

    // ===================================================
    // 3. [누락 복구] 실무 필수 페이징(Paging) & 정렬 제어 필드
    // ===================================================
    /** 현재 페이지 번호 (기본값: 1 페이지) */
    private int pageIdx = 1;
    
    /** 한 페이지당 보여줄 게시글/데이터 수 (기본값: 10개씩 보기) */
    private int pageRowCnt = 10;
    
    /** DB 마이바티스 LIMIT 구문 시작점 offset 연산값 (계산식: (pageIdx-1) * pageRowCnt) */
    private int startRow = 0;
    
    /** 동적 정렬 타깃 컬럼명 (예: REG_DT) */
    private String sortColumn;
    
    /** 동적 정렬 방향 (ASC / DESC) */
    private String sortOrder = "DESC";

    // ===================================================
    // Getter & Setter 및 자동 연산 캡슐화 명세
    // ===================================================
    public String getRegDate() { return regDate; }
    public void setRegDate(String regDate) { this.regDate = regDate; }
    
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
    
    public String getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(String updatedAt) { this.updatedAt = updatedAt; }
    
    public String getSearchType() { return searchType; }
    public void setSearchType(String searchType) { this.searchType = searchType; }
    
    public String getSearchValue() { return searchValue; }
    public void setSearchValue(String searchValue) { this.searchValue = searchValue; }
    
    public String getSearchKeyword() { return searchKeyword; }
    public void setSearchKeyword(String searchKeyword) { this.searchKeyword = searchKeyword; }
    
    public String getsDate() { return sDate; }
    public void setsDate(String sDate) { this.sDate = sDate; }
    
    public String geteDate() { return eDate; }
    public void seteDate(String eDate) { this.eDate = eDate; }

    // 페이징 내부 계산식 캡슐화 
    public int getPageIdx() { return pageIdx; }
    public void setPageIdx(int pageIdx) { 
        this.pageIdx = pageIdx;
        this.startRow = (pageIdx - 1) * this.pageRowCnt; // 페이지 변경 시 LIMIT 시작 offset 자동 동기화 계산
    }
    
    public int getPageRowCnt() { return pageRowCnt; }
    public void setPageRowCnt(int pageRowCnt) { 
        this.pageRowCnt = pageRowCnt;
        this.startRow = (this.pageIdx - 1) * pageRowCnt;
    }
    
    public int getStartRow() { 
        return (this.pageIdx - 1) * this.pageRowCnt; 
    }
    
    public String getSortColumn() { return sortColumn; }
    public void setSortColumn(String sortColumn) { this.sortColumn = sortColumn; }
    
    public String getSortOrder() { return sortOrder; }
    public void setSortOrder(String sortOrder) { this.sortOrder = sortOrder; }

    @Override
    public String toString() {
        return "BaseVO [searchType=" + searchType + ", searchValue=" + searchValue + ", searchKeyword=" + searchKeyword
                + ", sDate=" + sDate + ", eDate=" + eDate + ", pageIdx=" + pageIdx + "]";
    }
}