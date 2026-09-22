package kr.co.TRSolution.trsIbp.board.vo;

import java.io.Serializable;

public class BoardVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long boardSn;
    private String coId;
    private String boardTitle;
    private String boardCn;
    private String useYn;
    private String rgtrId;
    private String rgtrNm;
    private String mdfrId;
    private String regDt;
    private String mdFcnDt;
    private String searchKeyword;
    private Integer fileCnt;
    private Long atchFileSn;

    public Long getBoardSn() { return boardSn; }
    public void setBoardSn(Long boardSn) { this.boardSn = boardSn; }
    public String getCoId() { return coId; }
    public void setCoId(String coId) { this.coId = coId; }
    public String getBoardTitle() { return boardTitle; }
    public void setBoardTitle(String boardTitle) { this.boardTitle = boardTitle; }
    public String getBoardCn() { return boardCn; }
    public void setBoardCn(String boardCn) { this.boardCn = boardCn; }
    public String getUseYn() { return useYn; }
    public void setUseYn(String useYn) { this.useYn = useYn; }
    public String getRgtrId() { return rgtrId; }
    public void setRgtrId(String rgtrId) { this.rgtrId = rgtrId; }
    public String getRgtrNm() { return rgtrNm; }
    public void setRgtrNm(String rgtrNm) { this.rgtrNm = rgtrNm; }
    public String getMdfrId() { return mdfrId; }
    public void setMdfrId(String mdfrId) { this.mdfrId = mdfrId; }
    public String getRegDt() { return regDt; }
    public void setRegDt(String regDt) { this.regDt = regDt; }
    public String getMdFcnDt() { return mdFcnDt; }
    public void setMdFcnDt(String mdFcnDt) { this.mdFcnDt = mdFcnDt; }
    public String getSearchKeyword() { return searchKeyword; }
    public void setSearchKeyword(String searchKeyword) { this.searchKeyword = searchKeyword; }
    public Integer getFileCnt() { return fileCnt; }
    public void setFileCnt(Integer fileCnt) { this.fileCnt = fileCnt; }
    public Long getAtchFileSn() { return atchFileSn; }
    public void setAtchFileSn(Long atchFileSn) { this.atchFileSn = atchFileSn; }
}
