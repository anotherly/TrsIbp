/* 회사 공지: 기능별 DB 권한에 따라 수정/삭제. 시스템 공지는 조회 전용. */
var notices=[];
function nt(v){return window.decodeStoredText?window.decodeStoredText(v==null?'':v):(v==null?'':String(v));}
function nh(v){return $('<div>').text(nt(v)).html();}
function noticeAllowed(code){return typeof window.hasAuthorityCode==='function' && window.hasAuthorityCode(code);}
function loadNotices(){
    $.getJSON(ctxPath+'/notice/noticeList.ajax',{searchKeyword:$('#noticeSearch').val()})
    .done(function(r){
        if(r.result!=='OK')return alert(r.msg||'공지 조회 실패');
        notices=r.list||[];
        $('#noticeRows').html(notices.map(function(x){
            var adminNotice=x.noticeScopeCd==='SYSTEM';
            return '<button type="button" class="w-full text-left p-4 text-slate-200 hover:bg-slate-900/40 rounded-lg" onclick="viewNotice('+Number(x.noticeSn)+')">'+
            '<div class="flex justify-between gap-4"><div><span class="text-xs px-2 py-1 rounded '+(adminNotice?'bg-red-500/10 text-red-300':'bg-cyan-500/10 text-cyan-300')+'">'+
            (adminNotice?'시스템':'회사')+'</span><strong class="ml-2">'+nh(x.noticeTitle)+'</strong></div><span class="text-xs text-gray-500">'+nh(x.regDt)+'</span></div></button>';
        }).join('')||'<div class="ds-empty">공지사항이 없습니다.</div>');
    }).fail(function(xhr){$('#noticeRows').html('<div class="ds-empty">공지 조회 오류 ('+xhr.status+')</div>');});
}
function viewNotice(sn){
    var x=notices.find(function(v){return String(v.noticeSn)===String(sn);}); if(!x)return;
    $('#noticeModalTitle').text(nt(x.noticeTitle)); $('#noticeForm').addClass('hidden');
    var actions='';
    if(x.noticeScopeCd==='COMPANY'){
        if(noticeAllowed('WORK_NOTICE_MDFCN'))actions+='<button type="button" class="ds-btn ds-btn-outline" onclick="editNotice('+Number(sn)+')">수정</button>';
        if(noticeAllowed('WORK_NOTICE_DEL'))actions+='<button type="button" class="ds-btn ds-btn-outline" onclick="deleteNotice('+Number(sn)+')">삭제</button>';
    }
    $('#noticeView').removeClass('hidden').html(
        '<div class="text-xs text-slate-400 mb-4">'+(x.noticeScopeCd==='SYSTEM'?'시스템 공지':'회사 공지')+' · '+nh(x.rgtrNm||x.rgtrId)+' · '+nh(x.regDt)+'</div>'+
        '<div class="whitespace-pre-wrap leading-7 text-slate-200">'+nh(x.noticeCn)+'</div>'+
        (actions?'<div class="ds-form-actions mt-6" style="display:flex;justify-content:flex-end;gap:8px">'+actions+'</div>':'')
    ); $('#noticeModal').removeClass('hidden');
}
function openNoticeForm(){
    if(!noticeAllowed('WORK_NOTICE_REG'))return alert('공지 등록 권한이 없습니다.');
    document.getElementById('noticeForm').reset();$('#noticeSn').val('');$('#noticeBgngDt').val('');$('#noticeEndDt').val('');
    $('#noticeModalTitle').text('회사 공지 등록');$('#noticeView').addClass('hidden');$('#noticeForm').removeClass('hidden');$('#noticeModal').removeClass('hidden');
}
function editNotice(sn){
    var x=notices.find(function(v){return String(v.noticeSn)===String(sn);});
    if(!x||x.noticeScopeCd!=='COMPANY'||!noticeAllowed('WORK_NOTICE_MDFCN'))return alert('수정 가능한 회사 공지가 아닙니다.');
    document.getElementById('noticeForm').reset();
    $('#noticeSn').val(x.noticeSn);$('#noticeTitle').val(nt(x.noticeTitle));$('#noticeCn').val(nt(x.noticeCn));
    $('#popupYn').prop('checked',x.popupYn==='Y');
    // 기존 팝업 노출 기간을 건드리지 않도록 숨겨진 값으로 그대로 보존
    $('#noticeBgngDt').val(x.bgngDt||'');$('#noticeEndDt').val(x.endDt||'');
    $('#noticeModalTitle').text('회사 공지 수정');$('#noticeView').addClass('hidden');$('#noticeForm').removeClass('hidden');
}
function deleteNotice(sn){
    var x=notices.find(function(v){return String(v.noticeSn)===String(sn);});
    if(!x||x.noticeScopeCd!=='COMPANY'||!noticeAllowed('WORK_NOTICE_DEL'))return alert('삭제 권한이 없습니다.');
    if(!confirm('회사 공지를 삭제하시겠습니까?'))return;
    $.post(ctxPath+'/notice/noticeDelete.ajax',{noticeSn:sn},function(r){
        if(r.result==='OK'){closeNotice();loadNotices();}else alert(r.msg||'삭제 실패');
    },'json').fail(function(){alert('공지 삭제 요청 실패');});
}
function closeNotice(){$('#noticeModal').addClass('hidden');}
$('#noticeForm').on('submit',function(ev){
    ev.preventDefault();
    var isEdit=!!$('#noticeSn').val();
    if(!noticeAllowed(isEdit?'WORK_NOTICE_MDFCN':'WORK_NOTICE_REG'))return alert('공지 저장 권한이 없습니다.');
    $.post(ctxPath+'/notice/noticeSave.ajax',{
        noticeSn:$('#noticeSn').val(),noticeTitle:$('#noticeTitle').val(),noticeCn:$('#noticeCn').val(),
        popupYn:$('#popupYn').prop('checked')?'Y':'N',bgngDt:$('#noticeBgngDt').val(),endDt:$('#noticeEndDt').val()
    },function(r){if(r.result==='OK'){closeNotice();loadNotices();}else alert(r.msg||'저장 실패');},'json')
    .fail(function(){alert('공지 저장 요청 실패');});
});
$(loadNotices);
