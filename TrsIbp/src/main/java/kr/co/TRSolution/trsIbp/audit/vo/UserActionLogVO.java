package kr.co.TRSolution.trsIbp.audit.vo;
public class UserActionLogVO {
 private String coId,userId,actionSeCd,menuNm,targetId,requestUri,clientIpAddr,actionCn;
 public String getCoId(){return coId;} public void setCoId(String v){coId=v;} public String getUserId(){return userId;} public void setUserId(String v){userId=v;} public String getActionSeCd(){return actionSeCd;} public void setActionSeCd(String v){actionSeCd=v;} public String getMenuNm(){return menuNm;} public void setMenuNm(String v){menuNm=v;} public String getTargetId(){return targetId;} public void setTargetId(String v){targetId=v;} public String getRequestUri(){return requestUri;} public void setRequestUri(String v){requestUri=v;} public String getClientIpAddr(){return clientIpAddr;} public void setClientIpAddr(String v){clientIpAddr=v;} public String getActionCn(){return actionCn;} public void setActionCn(String v){actionCn=v;}
}
