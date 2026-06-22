package kr.co.TRSolution.trsIbp.attend.vo;

import kr.co.TRSolution.trsIbp.comm.BaseVO;

/**
 * 근태 데이터 VO (Value Object)
 *
 * WORK_HSTRY 테이블과 매핑
 *
 * @author DevSync
 * @since 2026-05-28
 */
public class AttendVO extends BaseVO {

    /** 이력번호 (PK, AUTO_INCREMENT) */
    private Long workHstrySn;

    /** 사용자 ID */
    private String userId;

    /** 사용자명 (JOIN 조회용) */
    private String userNm;

    /** 근무일자 (YYYY-MM-DD) */
    private String workYmd;

    /** 출근시간 (YYYY-MM-DD HH:mm:ss) */
    private String gtwkDt;

    /** 퇴근시간 (YYYY-MM-DD HH:mm:ss) */
    private String lvwkDt;

    /** 근무지 (OFFICE/HOME/OUTSIDE) */
    private String powkNm;

    /** 비고 */
    private String workRmrkCn;

    /** 등록일시 */
    private String regDt;

    /** 수정일시 */
    private String mdfcnDt;

    /** 근무시간 (분 단위, 조회용 계산값) */
    private String workMinutes;

    /** 오늘 출근 여부 (Y/N, 조회용) */
    private String todayGtwk;

    /** 오늘 퇴근 여부 (Y/N, 조회용) */
    private String todayLvwk;

    // ============================================================
    // Getter / Setter
    // ============================================================

    public Long getWorkHstrySn() { return workHstrySn; }
    public void setWorkHstrySn(Long workHstrySn) { this.workHstrySn = workHstrySn; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getUserNm() { return userNm; }
    public void setUserNm(String userNm) { this.userNm = userNm; }

    public String getWorkYmd() { return workYmd; }
    public void setWorkYmd(String workYmd) { this.workYmd = workYmd; }

    public String getGtwkDt() { return gtwkDt; }
    public void setGtwkDt(String gtwkDt) { this.gtwkDt = gtwkDt; }

    public String getLvwkDt() { return lvwkDt; }
    public void setLvwkDt(String lvwkDt) { this.lvwkDt = lvwkDt; }

    public String getPowkNm() { return powkNm; }
    public void setPowkNm(String powkNm) { this.powkNm = powkNm; }

    public String getWorkRmrkCn() { return workRmrkCn; }
    public void setWorkRmrkCn(String workRmrkCn) { this.workRmrkCn = workRmrkCn; }

    public String getRegDt() { return regDt; }
    public void setRegDt(String regDt) { this.regDt = regDt; }

    public String getMdfcnDt() { return mdfcnDt; }
    public void setMdfcnDt(String mdfcnDt) { this.mdfcnDt = mdfcnDt; }

    public String getWorkMinutes() { return workMinutes; }
    public void setWorkMinutes(String workMinutes) { this.workMinutes = workMinutes; }

    public String getTodayGtwk() { return todayGtwk; }
    public void setTodayGtwk(String todayGtwk) { this.todayGtwk = todayGtwk; }

    public String getTodayLvwk() { return todayLvwk; }
    public void setTodayLvwk(String todayLvwk) { this.todayLvwk = todayLvwk; }

    @Override
    public String toString() {
        return "AttendVO [workHstrySn=" + workHstrySn + ", userId=" + userId + ", workYmd=" + workYmd
                + ", gtwkDt=" + gtwkDt + ", lvwkDt=" + lvwkDt
                + ", powkNm=" + powkNm + "]";
    }
}
