package kr.co.TRSolution.trsIbp.worklog.vo;

import java.math.BigDecimal;
import kr.co.TRSolution.trsIbp.comm.BaseVO;

public class WorklogVO extends BaseVO {
 private Long workItemSn; private String coId,userId,workYmd,taskBgngYmd,exptEndYmd,doneYmd,bizId,workSeCd,workCn,prgrsSttsCd,issueCn,nextPlanCn,useYn,rgtrId,mdfrId,bizNm,bizAbrvNm,userNm; private Long parentWorkItemSn; private Integer sortSeq,priorityNo; private BigDecimal prgrsRt;
 public Long getWorkItemSn(){return workItemSn;} public void setWorkItemSn(Long v){workItemSn=v;} public String getCoId(){return coId;} public void setCoId(String v){coId=v;} public String getUserId(){return userId;} public void setUserId(String v){userId=v;}
 public String getWorkYmd(){return workYmd;} public void setWorkYmd(String v){workYmd=v;} public String getTaskBgngYmd(){return taskBgngYmd;} public void setTaskBgngYmd(String v){taskBgngYmd=v;} public String getExptEndYmd(){return exptEndYmd;} public void setExptEndYmd(String v){exptEndYmd=v;} public String getDoneYmd(){return doneYmd;} public void setDoneYmd(String v){doneYmd=v;}
 public String getBizId(){return bizId;} public void setBizId(String v){bizId=v;} public Long getParentWorkItemSn(){return parentWorkItemSn;} public void setParentWorkItemSn(Long v){parentWorkItemSn=v;} public Integer getSortSeq(){return sortSeq;} public void setSortSeq(Integer v){sortSeq=v;} public Integer getPriorityNo(){return priorityNo;} public void setPriorityNo(Integer v){priorityNo=v;}
 public String getWorkSeCd(){return workSeCd;} public void setWorkSeCd(String v){workSeCd=v;} public String getWorkCn(){return workCn;} public void setWorkCn(String v){workCn=v;} public String getPrgrsSttsCd(){return prgrsSttsCd;} public void setPrgrsSttsCd(String v){prgrsSttsCd=v;} public BigDecimal getPrgrsRt(){return prgrsRt;} public void setPrgrsRt(BigDecimal v){prgrsRt=v;}
 public String getIssueCn(){return issueCn;} public void setIssueCn(String v){issueCn=v;} public String getNextPlanCn(){return nextPlanCn;} public void setNextPlanCn(String v){nextPlanCn=v;} public String getUseYn(){return useYn;} public void setUseYn(String v){useYn=v;} public String getRgtrId(){return rgtrId;} public void setRgtrId(String v){rgtrId=v;} public String getMdfrId(){return mdfrId;} public void setMdfrId(String v){mdfrId=v;} public String getBizNm(){return bizNm;} public void setBizNm(String v){bizNm=v;} public String getBizAbrvNm(){return bizAbrvNm;} public void setBizAbrvNm(String v){bizAbrvNm=v;} public String getUserNm(){return userNm;} public void setUserNm(String v){userNm=v;}
}
