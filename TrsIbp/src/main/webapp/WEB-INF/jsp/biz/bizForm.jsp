<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form id="bizForm">
    <input type="hidden" id="frmBizId" name="bizId" value="${param.bizId}">
    <div class="ds-form-grid">
        <div class="ds-field">
            <label for="frmBizCd">사업코드</label>
            <input type="text" id="frmBizCd" name="bizCd" class="ds-input" maxlength="30" placeholder="예: BIZ-2026-001" ${param.mode eq 'detail' ? 'readonly' : ''}>
        </div>
        <div class="ds-field">
            <label for="frmBizSttsCd">사업상태</label>
            <select id="frmBizSttsCd" name="bizSttsCd" class="ds-select" ${param.mode eq 'detail' ? 'disabled' : ''}>
                <option value="">선택</option>
            </select>
        </div>

        <div class="ds-field ds-col-span-2">
            <label for="frmBizNm">사업명</label>
            <input type="text" id="frmBizNm" name="bizNm" class="ds-input" maxlength="100" placeholder="사업명을 입력하십시오." ${param.mode eq 'detail' ? 'readonly' : ''}>
        </div>

        <div class="ds-field">
            <label for="frmInstSeCd">기관구분</label>
            <select id="frmInstSeCd" name="instSeCd" class="ds-select" ${param.mode eq 'detail' ? 'disabled' : ''}>
                <option value="">선택</option>
            </select>
        </div>
        <div class="ds-field">
            <label for="frmOrdplNm">발주처</label>
            <input type="text" id="frmOrdplNm" name="ordplNm" class="ds-input" maxlength="100" placeholder="발주처명을 입력하십시오." ${param.mode eq 'detail' ? 'readonly' : ''}>
        </div>

        <div class="ds-field">
            <label for="frmBizKndCd">사업종류</label>
            <select id="frmBizKndCd" name="bizKndCd" class="ds-select" ${param.mode eq 'detail' ? 'disabled' : ''}>
                <option value="">선택</option>
            </select>
        </div>
        <div class="ds-field">
            <label for="frmBizSeCd">사업성격</label>
            <select id="frmBizSeCd" name="bizSeCd" class="ds-select" ${param.mode eq 'detail' ? 'disabled' : ''}>
                <option value="">선택</option>
            </select>
        </div>

        <div class="ds-field">
            <label for="frmCtrtYmd">계약일</label>
            <input type="date" id="frmCtrtYmd" name="ctrtYmd" class="ds-input" ${param.mode eq 'detail' ? 'readonly' : ''}>
        </div>
        <div class="ds-field">
            <label for="frmOtstYmd">착수일</label>
            <input type="date" id="frmOtstYmd" name="otstYmd" class="ds-input" ${param.mode eq 'detail' ? 'readonly' : ''}>
        </div>
        <div class="ds-field">
            <label for="frmBizEndYmd">사업종료일</label>
            <input type="date" id="frmBizEndYmd" name="bizEndYmd" class="ds-input" ${param.mode eq 'detail' ? 'readonly' : ''}>
        </div>
        <div class="ds-field">
            <label for="frmCtrtAmt">계약금액</label>
            <input type="number" id="frmCtrtAmt" name="ctrtAmt" class="ds-input" min="0" step="1" placeholder="원 단위" ${param.mode eq 'detail' ? 'readonly' : ''}>
        </div>

        <div class="ds-field">
            <label for="frmGiveMthdCn">지급방법</label>
            <input type="text" id="frmGiveMthdCn" name="giveMthdCn" class="ds-input" maxlength="500" placeholder="예: 검수 후 30일 이내" ${param.mode eq 'detail' ? 'readonly' : ''}>
        </div>
        <div class="ds-field">
            <label for="frmGiveDdtYmd">지급기일</label>
            <input type="date" id="frmGiveDdtYmd" name="giveDdtYmd" class="ds-input" ${param.mode eq 'detail' ? 'readonly' : ''}>
        </div>

        <div class="ds-field">
            <label for="frmDfrpGrnteBgngYmd">하자보수보증 시작일</label>
            <input type="date" id="frmDfrpGrnteBgngYmd" name="dfrpGrnteBgngYmd" class="ds-input" ${param.mode eq 'detail' ? 'readonly' : ''}>
        </div>
        <div class="ds-field">
            <label for="frmDfrpGrnteEndYmd">하자보수보증 종료일</label>
            <input type="date" id="frmDfrpGrnteEndYmd" name="dfrpGrnteEndYmd" class="ds-input" ${param.mode eq 'detail' ? 'readonly' : ''}>
        </div>

        <div class="ds-field ds-col-span-2">
            <label for="frmRmrkCn">기타사항(비고)</label>
            <textarea id="frmRmrkCn" name="rmrkCn" class="ds-textarea" maxlength="4000" placeholder="특이사항이나 계약상 참고사항을 입력하십시오." ${param.mode eq 'detail' ? 'readonly' : ''}></textarea>
        </div>
    </div>
</form>
