package kr.co.TRSolution.trsIbp.company.vo;

import java.io.Serializable;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class CompanyVO implements Serializable {

    private static final long serialVersionUID = 1L;

    // ===================================================
    // [기존] COMPANY_INFO & COMPANY_IP_INFO 테이블 컬럼
    // ===================================================
    private String companyId;         // 회사 ID (PK)
    private String companyName;       // 회사명
    private String companyTel;        // 대표전화
    private String companyAddr;       // 주소
    private String flagUse;           // 사용여부(Y/N)
    private String regDt;             // 등록일시
    
    private String allowedIp;         // 허용 공인 IP 주소
    private String ipDesc;            // IP 설명
    private String searchKeyword;     // 검색 키워드

    // ===================================================
    // [추가] COMPANY_REQUEST (도입 신청) 테이블 매핑 컬럼
    // ===================================================
    private int reqSeq;               // 신청 일련번호 (PK, AUTO_INCREMENT)
    private String companyNameReq;    // 신청 회사명 (company_request 전용 필드 분리 원칙)
    private String bizNo;             // ★ 누락 복구: 사업자등록번호 (NOT NULL 제약조건 대응)
    private String contactName;       // 담당자 이름
    private String representativeName;// 대표자명/신청자명
    private String contactTel;        // 담당자 연락처
    private String contactEmail;      // 담당자 이메일
    private String reqStatus;         // 신청 상태 (WAIT:대기, APPR:승인, REJECT:반려)
    private String rejectReason;      // 반려 사유

    // ===================================================
    // [추가] 파일 업로드 및 가공 수신용 (사업자등록증 등 증빙서류)
    // ===================================================
    @JsonIgnore // ★ 이 어노테이션을 붙여야 Jackson이 Ajax 응답(JSON 변환) 시 이 필드를 무시합니다!
    private MultipartFile bizFile; // 프론트 <input type="file" name="bizFile"> 수신용
    private String orgFileName;       // 원본 파일명
    private String encFileName;       // 암호화 가공 파일명
    private String filePath;          // 디스크 보관 경로
    private int docSeq;               // 자식 테이블 연결용 자동생성 SEQ 저장 공간

    // ===================================================
    // Getter & Setter (모든 필드 완비 명세)
    // ===================================================
    public String getCompanyId() { return companyId; }
    public void setCompanyId(String companyId) { this.companyId = companyId; }
    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }
    public String getCompanyTel() { return companyTel; }
    public void setCompanyTel(String companyTel) { this.companyTel = companyTel; }
    public String getCompanyAddr() { return companyAddr; }
    public void setCompanyAddr(String companyAddr) { this.companyAddr = companyAddr; }
    public String getFlagUse() { return flagUse; }
    public void setFlagUse(String flagUse) { this.flagUse = flagUse; }
    public String getRegDt() { return regDt; }
    public void setRegDt(String regDt) { this.regDt = regDt; }
    public String getAllowedIp() { return allowedIp; }
    public void setAllowedIp(String allowedIp) { this.allowedIp = allowedIp; }
    public String getIpDesc() { return ipDesc; }
    public void setIpDesc(String ipDesc) { this.ipDesc = ipDesc; }
    public String getSearchKeyword() { return searchKeyword; }
    public void setSearchKeyword(String searchKeyword) { this.searchKeyword = searchKeyword; }

    public int getReqSeq() { return reqSeq; }
    public void setReqSeq(int reqSeq) { this.reqSeq = reqSeq; }
    public String getCompanyNameReq() { return companyNameReq; }
    public void setCompanyNameReq(String companyNameReq) { this.companyNameReq = companyNameReq; }
    public String getBizNo() { return bizNo; }
    public void setBizNo(String bizNo) { this.bizNo = bizNo; }
    public String getContactName() { return contactName; }
    public void setContactName(String contactName) { this.contactName = contactName; }
    public String getRepresentativeName() { return representativeName; }
    public void setRepresentativeName(String representativeName) { this.representativeName = representativeName; }
    public String getContactTel() { return contactTel; }
    public void setContactTel(String contactTel) { this.contactTel = contactTel; }
    public String getContactEmail() { return contactEmail; }
    public void setContactEmail(String contactEmail) { this.contactEmail = contactEmail; }
    public String getReqStatus() { return reqStatus; }
    public void setReqStatus(String reqStatus) { this.reqStatus = reqStatus; }
    public String getRejectReason() { return rejectReason; }
    public void setRejectReason(String rejectReason) { this.rejectReason = rejectReason; }
    public MultipartFile getBizFile() { return bizFile; }
    public void setBizFile(MultipartFile bizFile) { this.bizFile = bizFile; }
    public String getOrgFileName() { return orgFileName; }
    public void setOrgFileName(String orgFileName) { this.orgFileName = orgFileName; }
    public String getEncFileName() { return encFileName; }
    public void setEncFileName(String encFileName) { this.encFileName = encFileName; }
    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }
    public int getDocSeq() { return docSeq; }
    public void setDocSeq(int docSeq) { this.docSeq = docSeq; }
}