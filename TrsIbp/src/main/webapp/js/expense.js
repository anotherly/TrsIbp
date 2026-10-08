/* 사업 비용 원장(biz_cst) 단일 조회/등록/수정/삭제 */
var expenseRows = [], expenseBiz = [];
function e(v) { return $('<div>').text(v == null ? '' : String(v)).html(); }
function amt(v) { return Number(v || 0).toLocaleString('ko-KR') + '원'; }
function expType(c) {
    return {LODGING:'숙박', SUPPLY:'물품', MEAL:'식비', TRANSPORT:'교통', FUEL:'유류',
        ETC:'기타', TRVL:'출장비', MEET:'회의비'}[c] || c || '-';
}
function payText(x) {
    var n = {PERSONAL_CARD:'개인카드',CORP_CARD:'법인카드',CASH:'현금',ETC:'기타'}[x.pmtMthdCd] || x.pmtMthdCd || '-';
    return x.cardLast4 && (x.pmtMthdCd === 'PERSONAL_CARD' || x.pmtMthdCd === 'CORP_CARD')
        ? n + ' · **** ' + x.cardLast4 : n;
}
function canExpense(code) { return typeof window.hasAuthorityCode !== 'function' || window.hasAuthorityCode(code); }
function toggleCardLast4() {
    var card = $('#expPay').val() === 'PERSONAL_CARD' || $('#expPay').val() === 'CORP_CARD';
    $('#expCardLast4Field').toggleClass('hidden', !card);
    $('#expCardLast4').prop('required', card);
    if (!card) $('#expCardLast4').val('');
}
function loadExpenses() {
    $.getJSON(ctxPath + '/expense/expenseList.ajax', {searchKeyword:$('#expenseSearch').val()})
    .done(function(r) {
        if (r.result !== 'OK') { $('#expenseBody').html('<tr><td colspan="9" class="ds-empty">'+e(r.msg || '조회 실패')+'</td></tr>'); return; }
        expenseRows = r.list || [];
        expenseBiz = r.bizList || [];
        $('#expBizId').html('<option value="">선택</option>' + expenseBiz.map(function(x) {
            return '<option value="'+e(x.bizId)+'">'+e(x.bizAbrvNm || x.bizNm)+'</option>';
        }).join(''));
        $('#expenseBody').html(expenseRows.length ? expenseRows.map(function(x) {
            var sn = Number(x.claimSn);
            var proof = canExpense('WORK_EXPENSE_FILE')
                ? '<button type="button" class="ds-btn ds-btn-outline" onclick="showFiles('+sn+')">보기</button>'
                : '<span class="text-gray-500">-</span>';
            var manage =
                (canExpense('WORK_EXPENSE_MDFCN') ? '<button type="button" class="ds-btn ds-btn-outline" onclick="openExpenseForm('+sn+')">수정</button> ' : '') +
                (canExpense('WORK_EXPENSE_DEL') ? '<button type="button" class="ds-btn ds-btn-outline" onclick="deleteExpense('+sn+')">삭제</button>' : '');
            return '<tr><td>'+e(x.useYmd || '-')+'</td><td>'+e(x.bizAbrvNm || x.bizNm)+'</td>'+
                
                '<td>'+e(expType(x.expnsSeCd))+'<br><small class="text-gray-500">'+e(payText(x))+'</small></td>'+
                '<td>'+e(x.expnsNm)+'</td><td>'+e(x.merchantNm || '-')+'</td>'+
                '<td class="text-right font-bold">'+amt(x.claimAmt)+'</td><td>'+e(x.userNm || x.userId || '-')+'</td>'+
                '<td>'+proof+'</td><td>'+manage+'</td></tr>';
        }).join('') : '<tr><td colspan="9" class="ds-empty">조회 가능한 비용 내역이 없습니다.</td></tr>');
    }).fail(function(xhr) {
        $('#expenseBody').html('<tr><td colspan="9" class="ds-empty">비용 조회에 실패했습니다. (' + e(xhr.status) + ')</td></tr>');
    });
}
function openExpenseForm(sn) {
    if (sn && !canExpense('WORK_EXPENSE_MDFCN')) return alert('비용 수정 권한이 없습니다.');
    if (!sn && !canExpense('WORK_EXPENSE_REG')) return alert('비용 등록 권한이 없습니다.');
    document.getElementById('expenseForm').reset();
    $('#claimSn').val(''); $('#expenseExistingFiles').empty(); updateExpenseFileLabel();
    if (sn) {
        var x = expenseRows.filter(function(v) { return String(v.claimSn) === String(sn); })[0];
        if (!x) return alert('비용 내역을 찾지 못했습니다.');
        $('#claimSn').val(x.claimSn); $('#expBizId').val(x.bizId); $('#expUseYmd').val(x.useYmd);
        $('#expSe').val(x.expnsSeCd); $('#expPay').val(x.pmtMthdCd || 'UNSPECIFIED');
        $('#expCardLast4').val(x.cardLast4 || ''); $('#expAmt').val(x.claimAmt);
        $('#expNm').val(x.expnsNm); $('#expMerchant').val(x.merchantNm);
        $('#expRmrk').val(window.decodeStoredText ? window.decodeStoredText(x.rmrkCn || '') : (x.rmrkCn || ''));
        if (canExpense('WORK_EXPENSE_FILE')) showFiles(sn, '#expenseExistingFiles');
    } else {
        var now = new Date();
        $('#expUseYmd').val(now.getFullYear() + '-' + String(now.getMonth()+1).padStart(2,'0') + '-' + String(now.getDate()).padStart(2,'0'));
    }
    toggleCardLast4(); $('#expenseModal').removeClass('hidden');
}
function closeExpenseForm() { $('#expenseModal').addClass('hidden'); }
function updateExpenseFileLabel() {
    var files = document.getElementById('expFiles').files;
    $('#expFileNames').text(files && files.length ? Array.prototype.map.call(files, function(f){return f.name;}).join(', ') : '선택된 파일 없음');
}
function showFiles(sn, target) {
    $.getJSON(ctxPath+'/expense/expenseFiles.ajax', {claimSn:sn}).done(function(r) {
        var h = (r.list || []).map(function(f) {
            return '<a class="text-cyan-300 mr-3" target="_blank" rel="noopener" href="'+ctxPath+'/common/fileView.do?atchFileSn='+encodeURIComponent(f.atchFileSn)+'">'+e(f.orgnlFileNm)+'</a>';
        }).join('') || '<span class="text-gray-500">첨부 없음</span>';
        if (target) $(target).html(h);
        else alert((r.list || []).map(function(f){return f.orgnlFileNm;}).join('\n') || '첨부파일이 없습니다.');
    }).fail(function(){ if(target) $(target).text('증빙 조회 실패'); else alert('증빙 조회 실패'); });
}
function deleteExpense(sn) {
    if (!canExpense('WORK_EXPENSE_DEL')) return alert('비용 삭제 권한이 없습니다.');
    if (!confirm('해당 비용을 삭제하면 회계관리 손익에서도 제외됩니다. 삭제하시겠습니까?')) return;
    $.post(ctxPath+'/expense/expenseDelete.ajax',{claimSn:sn},function(r) {
        if (r.result === 'OK') loadExpenses(); else alert(r.msg || '삭제 실패');
    },'json').fail(function(){alert('비용 삭제 요청에 실패했습니다.');});
}
$('#expPay').on('change',toggleCardLast4);
$('#expCardLast4').on('input',function() {this.value=this.value.replace(/\D/g,'').slice(0,4);});
$('#expFiles').on('change',updateExpenseFileLabel);
$('#expenseForm').on('submit',function(ev) {
    ev.preventDefault(); toggleCardLast4();
    if ($('#expCardLast4').prop('required') && !/^\d{4}$/.test($('#expCardLast4').val())) return alert('카드 뒷번호 4자리를 입력해 주세요.');
    var fd = new FormData(this);
    $.ajax({url:ctxPath+'/expense/expenseSave.ajax',type:'POST',data:fd,processData:false,contentType:false,dataType:'json'})
    .done(function(r) {if(r.result === 'OK'){closeExpenseForm();loadExpenses();}else alert(r.msg || '저장 실패');})
    .fail(function(xhr){alert('비용 저장 요청 실패 ('+xhr.status+')');});
});
$(function() { toggleCardLast4(); updateExpenseFileLabel(); loadExpenses(); });
