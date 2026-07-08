<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String mode = request.getParameter("mode");
    if (mode == null) mode = "insert";
%>
<input type="hidden" id="frmBizId" name="bizId" value="<%=request.getParameter("bizId") == null ? "" : request.getParameter("bizId")%>">
<div class="ds-form-grid ds-form-grid-4 biz-basic-form">
    <div class="ds-field ds-col-span-1">
        <label for="frmBizCd" class="required">사업코드</label>
        <input type="text" id="frmBizCd" class="ds-input" maxlength="30" placeholder="저장 시 자동 생성" readonly>
    </div>

    <div class="ds-field ds-col-span-4">
        <label for="frmBizNm" class="required">사업명</label>
        <input type="text" id="frmBizNm" class="ds-input" maxlength="200">
    </div>

    <div class="ds-field ds-col-span-2">
        <label for="frmInstSeCd" class="required">민간/공공</label>
        <select id="frmInstSeCd" class="ds-select"><option value="">선택</option></select>
    </div>
    <div class="ds-field ds-col-span-2">
        <label for="frmBizKndCd" class="required">사업종류</label>
        <select id="frmBizKndCd" class="ds-select"><option value="">선택</option></select>
    </div>

    <div class="ds-field ds-col-span-2">
        <label for="frmBizSttsCd" class="required">사업상태</label>
        <select id="frmBizSttsCd" class="ds-select"><option value="">선택</option></select>
    </div>
    <div class="ds-field ds-col-span-2">
        <label for="frmBizSeCd" class="required">사업성격</label>
        <select id="frmBizSeCd" class="ds-select"><option value="">선택</option></select>
    </div>

    <div class="ds-field ds-col-span-4">
        <label for="frmOrdplNm">발주처</label>
        <input type="text" id="frmOrdplNm" class="ds-input" maxlength="100">
    </div>

    <div class="ds-field">
        <label for="frmCtrtYmd">계약일</label>
        <input type="date" id="frmCtrtYmd" class="ds-input ready-disabled-field">
    </div>
    <div class="ds-field">
        <label for="frmOtstYmd">착수일</label>
        <input type="date" id="frmOtstYmd" class="ds-input ready-disabled-field">
    </div>
    <div class="ds-field">
        <label for="frmBizEndYmd">사업종료일</label>
        <input type="date" id="frmBizEndYmd" class="ds-input ready-disabled-field">
    </div>

    <div class="ds-field">
        <label for="frmCtrtAmt">계약금액</label>
        <input type="number" id="frmCtrtAmt" class="ds-input ready-disabled-field" min="0" step="1">
    </div>
    <div class="ds-field">
        <label for="frmGiveMthdCd">지급방법</label>
        <select id="frmGiveMthdCd" class="ds-select ready-disabled-field"><option value="">선택</option></select>
    </div>
    <div class="ds-field">
        <label for="frmGiveMthdCn">지급방법상세</label>
        <input type="text" id="frmGiveMthdCn" class="ds-input ready-disabled-field" maxlength="1000" placeholder="예: 70%, 1000만원">
    </div>
    <div class="ds-field">
        <label for="frmGiveDdtYmd">지급기일</label>
        <input type="date" id="frmGiveDdtYmd" class="ds-input ready-disabled-field">
    </div>

    <div class="ds-field ds-col-span-2">
        <label for="frmDfrpGrnteBgngYmd">하자보증시작일</label>
        <input type="date" id="frmDfrpGrnteBgngYmd" class="ds-input ready-disabled-field">
    </div>
    <div class="ds-field ds-col-span-2">
        <label for="frmDfrpGrnteEndYmd">하자보증종료일</label>
        <input type="date" id="frmDfrpGrnteEndYmd" class="ds-input ready-disabled-field">
    </div>
</div>
