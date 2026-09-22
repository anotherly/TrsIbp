package kr.co.TRSolution.trsIbp.expense.vo;

import java.math.BigDecimal;
import kr.co.TRSolution.trsIbp.comm.BaseVO;

public class ExpenseVO extends BaseVO {
    private Long claimSn; private String coId; private String bizId; private Long bizCstSn; private String userId;
    private String expnsSeCd; private String pmtMthdCd; private String cardLast4; private String useYmd; private String merchantNm; private String expnsNm;
    private BigDecimal claimAmt; private String rmrkCn; private String sttsCd; private String useYn; private String rgtrId; private String mdfrId;
    private String bizNm; private String bizAbrvNm; private String userNm; private String expnsSeNm; private String pmtMthdNm; private String companyScopeYn;
    public Long getClaimSn(){return claimSn;} public void setClaimSn(Long v){claimSn=v;} public String getCoId(){return coId;} public void setCoId(String v){coId=v;}
    public String getBizId(){return bizId;} public void setBizId(String v){bizId=v;} public Long getBizCstSn(){return bizCstSn;} public void setBizCstSn(Long v){bizCstSn=v;}
    public String getUserId(){return userId;} public void setUserId(String v){userId=v;} public String getExpnsSeCd(){return expnsSeCd;} public void setExpnsSeCd(String v){expnsSeCd=v;}
    public String getPmtMthdCd(){return pmtMthdCd;} public void setPmtMthdCd(String v){pmtMthdCd=v;} public String getCardLast4(){return cardLast4;} public void setCardLast4(String v){cardLast4=v;}
    public String getUseYmd(){return useYmd;} public void setUseYmd(String v){useYmd=v;} public String getMerchantNm(){return merchantNm;} public void setMerchantNm(String v){merchantNm=v;} public String getExpnsNm(){return expnsNm;} public void setExpnsNm(String v){expnsNm=v;}
    public BigDecimal getClaimAmt(){return claimAmt;} public void setClaimAmt(BigDecimal v){claimAmt=v;} public String getRmrkCn(){return rmrkCn;} public void setRmrkCn(String v){rmrkCn=v;}
    public String getSttsCd(){return sttsCd;} public void setSttsCd(String v){sttsCd=v;} public String getUseYn(){return useYn;} public void setUseYn(String v){useYn=v;}
    public String getRgtrId(){return rgtrId;} public void setRgtrId(String v){rgtrId=v;} public String getMdfrId(){return mdfrId;} public void setMdfrId(String v){mdfrId=v;}
    public String getBizNm(){return bizNm;} public void setBizNm(String v){bizNm=v;} public String getBizAbrvNm(){return bizAbrvNm;} public void setBizAbrvNm(String v){bizAbrvNm=v;}
    public String getUserNm(){return userNm;} public void setUserNm(String v){userNm=v;} public String getExpnsSeNm(){return expnsSeNm;} public void setExpnsSeNm(String v){expnsSeNm=v;}
    public String getPmtMthdNm(){return pmtMthdNm;} public void setPmtMthdNm(String v){pmtMthdNm=v;} public String getCompanyScopeYn(){return companyScopeYn;} public void setCompanyScopeYn(String v){companyScopeYn=v;}
}
