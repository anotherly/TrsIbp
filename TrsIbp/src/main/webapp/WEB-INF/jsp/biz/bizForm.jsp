<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String mode = request.getParameter("mode");
    if (mode == null) mode = "insert";
    boolean readonly = "detail".equals(mode);
%>
<input type="hidden" id="frmBizId" name="bizId" value="<%=request.getParameter("bizId") == null ? "" : request.getParameter("bizId")%>">
<div class="ds-form-grid ds-form-grid-4">
    <div class="ds-field"><label>사업코드</label><input type="text" id="frmBizCd" class="ds-input" maxlength="30" <%=readonly ? "disabled" : ""%>></div>
    <div class="ds-field ds-col-span-2"><label>사업명</label><input type="text" id="frmBizNm" class="ds-input" maxlength="200" <%=readonly ? "disabled" : ""%>></div>
    <div class="ds-field"><label>사업상태</label><select id="frmBizSttsCd" class="ds-select" <%=readonly ? "disabled" : ""%>><option value="">선택</option></select></div>
    <div class="ds-field"><label>민간/공공</label><select id="frmInstSeCd" class="ds-select" <%=readonly ? "disabled" : ""%>><option value="">선택</option></select></div>
    <div class="ds-field"><label>사업종류</label><select id="frmBizKndCd" class="ds-select" <%=readonly ? "disabled" : ""%>><option value="">선택</option></select></div>
    <div class="ds-field"><label>사업성격</label><select id="frmBizSeCd" class="ds-select" <%=readonly ? "disabled" : ""%>><option value="">선택</option></select></div>
    <div class="ds-field"><label>발주처</label><input type="text" id="frmOrdplNm" class="ds-input" maxlength="100" <%=readonly ? "disabled" : ""%>></div>
    <div class="ds-field"><label>계약일</label><input type="date" id="frmCtrtYmd" class="ds-input" <%=readonly ? "disabled" : ""%>></div>
    <div class="ds-field"><label>착수일</label><input type="date" id="frmOtstYmd" class="ds-input" <%=readonly ? "disabled" : ""%>></div>
    <div class="ds-field"><label>사업종료일</label><input type="date" id="frmBizEndYmd" class="ds-input" <%=readonly ? "disabled" : ""%>></div>
    <div class="ds-field"><label>계약금액</label><input type="number" id="frmCtrtAmt" class="ds-input" min="0" step="1" <%=readonly ? "disabled" : ""%>></div>
    <div class="ds-field"><label>지급방법</label><input type="text" id="frmGiveMthdCn" class="ds-input" maxlength="300" <%=readonly ? "disabled" : ""%>></div>
    <div class="ds-field"><label>지급기일</label><input type="date" id="frmGiveDdtYmd" class="ds-input" <%=readonly ? "disabled" : ""%>></div>
    <div class="ds-field"><label>하자보증시작일</label><input type="date" id="frmDfrpGrnteBgngYmd" class="ds-input" <%=readonly ? "disabled" : ""%>></div>
    <div class="ds-field"><label>하자보증종료일</label><input type="date" id="frmDfrpGrnteEndYmd" class="ds-input" <%=readonly ? "disabled" : ""%>></div>
    <div class="ds-field ds-col-span-4"><label>기타사항</label><textarea id="frmRmrkCn" class="ds-textarea" maxlength="1000" <%=readonly ? "disabled" : ""%>></textarea></div>
</div>
