<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String mode = request.getParameter("mode");
    if (mode == null) mode = "insert";
    boolean detail = "detail".equals(mode);
    boolean update = "update".equals(mode);
%>
<input type="hidden" id="frmBizId" name="bizId" value="<%=request.getParameter("bizId") == null ? "" : request.getParameter("bizId")%>">
<% if (detail) { %>
<div class="ds-form-grid biz-basic-form biz-detail-view">
    <div class="ds-field"><label class="required">사업코드</label><p id="dispBizCd" class="ds-display-text"></p></div>
    <div class="ds-field"><label class="required">사업명</label><p id="dispBizNm" class="ds-display-text"></p></div>
    <div class="ds-field"><label class="required">민간/공공</label><p id="dispInstSeNm" class="ds-display-text"></p></div>
    <div class="ds-field"><label class="required">사업종류</label><p id="dispBizKndNm" class="ds-display-text"></p></div>
    <div class="ds-field"><label class="required">사업상태</label><p id="dispBizSttsNm" class="ds-display-text"></p></div>
    <div class="ds-field"><label class="required">사업성격</label><p id="dispBizSeNm" class="ds-display-text"></p></div>
    <div class="ds-field"><label>발주처</label><p id="dispOrdplNm" class="ds-display-text"></p></div>
    <div class="ds-field"><label>계약일</label><p id="dispCtrtYmd" class="ds-display-text"></p></div>
    <div class="ds-field"><label>착수일</label><p id="dispOtstYmd" class="ds-display-text"></p></div>
    <div class="ds-field"><label>사업종료일</label><p id="dispBizEndYmd" class="ds-display-text"></p></div>
    <div class="ds-field"><label>계약금액</label><p id="dispCtrtAmt" class="ds-display-text"></p></div>
    <div class="ds-field"><label>지급방법</label><p id="dispGiveMthdCn" class="ds-display-text"></p></div>
    <div class="ds-field"><label>지급기일</label><p id="dispGiveDdtYmd" class="ds-display-text"></p></div>
    <div class="ds-field"><label>하자보증시작일</label><p id="dispDfrpGrnteBgngYmd" class="ds-display-text"></p></div>
    <div class="ds-field"><label>하자보증종료일</label><p id="dispDfrpGrnteEndYmd" class="ds-display-text"></p></div>
    <div class="ds-field ds-col-span-2"><label>기타사항</label><p id="dispRmrkCn" class="ds-display-text ds-display-textarea"></p></div>
</div>
<% } else { %>
<div class="ds-form-grid biz-basic-form">
    <div class="ds-field"><label for="frmBizCd" class="required">사업코드</label><input type="text" id="frmBizCd" class="ds-input" maxlength="30" placeholder="저장 시 자동 생성" readonly></div>
    <div class="ds-field"><label for="frmBizNm" class="required">사업명</label><input type="text" id="frmBizNm" class="ds-input" maxlength="200"></div>
    <div class="ds-field"><label for="frmInstSeCd" class="required">민간/공공</label><select id="frmInstSeCd" class="ds-select"><option value="">선택</option></select></div>
    <div class="ds-field"><label for="frmBizKndCd" class="required">사업종류</label><select id="frmBizKndCd" class="ds-select"><option value="">선택</option></select></div>
    <div class="ds-field"><label for="frmBizSttsCd" class="required">사업상태</label><select id="frmBizSttsCd" class="ds-select"><option value="">선택</option></select></div>
    <div class="ds-field"><label for="frmBizSeCd" class="required">사업성격</label><select id="frmBizSeCd" class="ds-select"><option value="">선택</option></select></div>
    <div class="ds-field"><label for="frmOrdplNm">발주처</label><input type="text" id="frmOrdplNm" class="ds-input" maxlength="100"></div>
    <div class="ds-field"><label for="frmCtrtYmd">계약일</label><input type="date" id="frmCtrtYmd" class="ds-input ready-disable-field"></div>
    <div class="ds-field"><label for="frmOtstYmd">착수일</label><input type="date" id="frmOtstYmd" class="ds-input ready-disable-field"></div>
    <div class="ds-field"><label for="frmBizEndYmd">사업종료일</label><input type="date" id="frmBizEndYmd" class="ds-input ready-disable-field"></div>
    <div class="ds-field"><label for="frmCtrtAmt">계약금액</label><input type="number" id="frmCtrtAmt" class="ds-input ready-disable-field" min="0" step="1"></div>
    <div class="ds-field"><label for="frmGiveMthdSe">지급방법</label><select id="frmGiveMthdSe" class="ds-select ready-disable-field"><option value="">선택</option><option value="선금">선금</option><option value="중도금">중도금</option><option value="잔금">잔금</option></select></div>
    <div class="ds-field"><label for="frmGiveMthdDtl">지급내용</label><input type="text" id="frmGiveMthdDtl" class="ds-input ready-disable-field" maxlength="250" placeholder="예: 70%, 1000만원"></div>
    <div class="ds-field"><label for="frmGiveDdtYmd">지급기일</label><input type="date" id="frmGiveDdtYmd" class="ds-input ready-disable-field"></div>
    <div class="ds-field"><label for="frmDfrpGrnteBgngYmd">하자보증시작일</label><input type="date" id="frmDfrpGrnteBgngYmd" class="ds-input ready-disable-field"></div>
    <div class="ds-field"><label for="frmDfrpGrnteEndYmd">하자보증종료일</label><input type="date" id="frmDfrpGrnteEndYmd" class="ds-input ready-disable-field"></div>
    <div class="ds-field ds-col-span-2"><label for="frmRmrkCn">기타사항</label><textarea id="frmRmrkCn" class="ds-textarea" maxlength="1000"></textarea></div>
</div>
<% } %>
