package kr.co.TRSolution.trsIbp.attend.vo;

/**
 * 근태 데이터 VO (Value Object)
 *
 * ATTEND_HISTORY 테이블과 매핑
 *
 * @author DevSync
 * @since 2026-05-28
 */
public class AttendVO {

    /** 이력번호 (PK, AUTO_INCREMENT) */
    private Long seq;

    /** 사용자 ID */
    private String userId;

    /** 사용자명 (JOIN 조회용) */
    private String userName;

    /** 근무일자 (YYYY-MM-DD) */
    private String workDt;

    /** 출근시간 (YYYY-MM-DD HH:mm:ss) */
    private String checkInTime;

    /** 퇴근시간 (YYYY-MM-DD HH:mm:ss) */
    private String checkOutTime;

    /** 근무지 (OFFICE/HOME/OUTSIDE) */
    private String workLocation;

    /** 비고 */
    private String workMemo;

    /** 등록일시 */
    private String regDt;

    /** 수정일시 */
    private String updDt;

    /** 근무시간 (분 단위, 조회용 계산값) */
    private String workMinutes;

    /** 오늘 출근 여부 (Y/N, 조회용) */
    private String todayCheckIn;

    /** 오늘 퇴근 여부 (Y/N, 조회용) */
    private String todayCheckOut;

    // ============================================================
    // Getter / Setter
    // ============================================================

    public Long getSeq() { return seq; }
    public void setSeq(Long seq) { this.seq = seq; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getWorkDt() { return workDt; }
    public void setWorkDt(String workDt) { this.workDt = workDt; }

    public String getCheckInTime() { return checkInTime; }
    public void setCheckInTime(String checkInTime) { this.checkInTime = checkInTime; }

    public String getCheckOutTime() { return checkOutTime; }
    public void setCheckOutTime(String checkOutTime) { this.checkOutTime = checkOutTime; }

    public String getWorkLocation() { return workLocation; }
    public void setWorkLocation(String workLocation) { this.workLocation = workLocation; }

    public String getWorkMemo() { return workMemo; }
    public void setWorkMemo(String workMemo) { this.workMemo = workMemo; }

    public String getRegDt() { return regDt; }
    public void setRegDt(String regDt) { this.regDt = regDt; }

    public String getUpdDt() { return updDt; }
    public void setUpdDt(String updDt) { this.updDt = updDt; }

    public String getWorkMinutes() { return workMinutes; }
    public void setWorkMinutes(String workMinutes) { this.workMinutes = workMinutes; }

    public String getTodayCheckIn() { return todayCheckIn; }
    public void setTodayCheckIn(String todayCheckIn) { this.todayCheckIn = todayCheckIn; }

    public String getTodayCheckOut() { return todayCheckOut; }
    public void setTodayCheckOut(String todayCheckOut) { this.todayCheckOut = todayCheckOut; }

    @Override
    public String toString() {
        return "AttendVO [seq=" + seq + ", userId=" + userId + ", workDt=" + workDt
                + ", checkInTime=" + checkInTime + ", checkOutTime=" + checkOutTime
                + ", workLocation=" + workLocation + "]";
    }
}
