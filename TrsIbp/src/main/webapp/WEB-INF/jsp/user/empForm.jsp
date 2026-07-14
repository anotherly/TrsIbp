<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String mode = request.getParameter("mode");
    boolean insert = "insert".equals(mode);
%>
<section class="ds-card ds-card-inner">
    <div class="ds-section-head"><div><h2 class="ds-section-title">기본 정보</h2><p class="ds-section-desc">필수값은 빨간색 * 항목입니다.</p></div></div>
    <form id="empForm" onsubmit="saveEmp(); return false;">
        <input type="hidden" id="frmSaveMode" name="saveMode" value="<%=mode%>">
        <div class="ds-form-12">
            <div class="ds-field ds-col-6"><label class="required">사용자ID</label><input type="text" id="frmUserId" name="userId" class="ds-input" maxlength="50" <%=insert ? "" : "readonly"%> placeholder="영문/숫자 조합"></div>
            <div class="ds-field ds-col-6"><label class="required">사용자명</label><input type="text" id="frmUserNm" name="userNm" class="ds-input" maxlength="100"></div>
            <div class="ds-field ds-col-4"><label class="required">부서</label><input type="hidden" id="frmDeptId" name="deptId"><div class="ds-input-button"><input type="text" id="frmDeptNm" class="ds-input" readonly placeholder="부서 선택"><button type="button" class="ds-btn ds-btn-outline" onclick="openEmpDeptSelectModal();">선택</button></div></div>
            <div class="ds-field ds-col-4"><label>직위</label><input type="text" id="frmJbpsNm" name="jbpsNm" class="ds-input" maxlength="50" placeholder="과장, 차장 등"></div>
            <div class="ds-field ds-col-4"><label class="required">권한</label><select id="frmAuthrtId" name="authrtId" class="ds-select"><option value="">선택</option></select></div>
            <div class="ds-field ds-col-4"><label><%=insert ? "초기 비밀번호" : "비밀번호 변경"%><%=insert ? " <span class='ds-required-star'>*</span>" : ""%></label><input type="password" id="frmUserEnpswd" name="userEnpswd" class="ds-input" maxlength="100" autocomplete="new-password" placeholder="<%=insert ? "필수 입력" : "변경 시에만 입력"%>"></div>
            <div class="ds-field ds-col-4"><label>전화번호</label><input type="text" id="frmUserTelno" name="userTelno" class="ds-input" maxlength="20" placeholder="01012345678"></div>
            
            <div class="ds-field ds-col-4"><label>사용여부</label><select id="frmUseYn" name="useYn" class="ds-select"><option value="Y">사용</option><option value="N">미사용</option></select></div>
            <div class="ds-field ds-col-12"><label>메모</label><textarea id="frmMemoCn" name="memoCn" class="ds-textarea" maxlength="500"></textarea></div>
        </div>
    </form>
</section>
