var boardList = [];
var boardDeleteFileSns = [];
var boardCurrentDetail = null;

function boardText(value) {
    return window.decodeStoredText ? window.decodeStoredText(value == null ? '' : value) : (value == null ? '' : String(value));
}
function boardHtml(value) { return $('<div>').text(boardText(value)).html(); }

function loadBoards() {
    $.getJSON(ctxPath + '/board/boardList.ajax', { searchKeyword: $('#boardSearch').val() || '' })
        .done(function(res) {
            boardList = res.list || [];
            renderBoardRows(boardList);
        })
        .fail(function() {
            $('#boardRows').html('<tr><td colspan="5" class="ds-empty">게시글 조회 중 오류가 발생했습니다.</td></tr>');
        });
}

function renderBoardRows(list) {
    if (!list.length) {
        $('#boardRows').html('<tr><td colspan="5" class="ds-empty">등록된 게시글이 없습니다.</td></tr>');
        return;
    }
    $('#boardRows').html(list.map(function(row) {
        var fileCnt = Number(row.fileCnt || 0);
        return '<tr class="ds-clickable-row" onclick="viewBoard(' + Number(row.boardSn) + ');">'
            + '<td>' + Number(row.boardSn) + '</td>'
            + '<td class="text-left"><strong class="ds-board-title">' + boardHtml(row.boardTitle) + '</strong></td>'
            + '<td>' + boardHtml(row.rgtrNm || row.rgtrId || '-') + '</td>'
            + '<td>' + (fileCnt > 0 ? '<span class="ds-badge">' + fileCnt + '개</span>' : '-') + '</td>'
            + '<td>' + boardHtml(row.regDt || '') + '</td>'
            + '</tr>';
    }).join(''));
}

function viewBoard(boardSn) {
    $.getJSON(ctxPath + '/board/boardDetail.ajax', { boardSn: boardSn })
        .done(function(res) {
            if (res.result !== 'OK' || !res.detail) {
                alert(res.msg || '게시글을 조회하지 못했습니다.');
                return;
            }
            boardCurrentDetail = res.detail;
            $('#boardModalTitle').text(boardText(res.detail.boardTitle));
            $('#boardModalDesc').text('게시글 상세');
            $('#boardForm').addClass('hidden');
            $('#boardView').removeClass('hidden');
            $('#boardViewMeta').html('<span><i class="fa-regular fa-user"></i> ' + boardHtml(res.detail.rgtrNm || res.detail.rgtrId || '-') + '</span>'
                + '<span><i class="fa-regular fa-clock"></i> ' + boardHtml(res.detail.regDt || '') + '</span>');
            $('#boardViewContent').text(boardText(res.detail.boardCn || ''));
            renderBoardViewFiles(res.files || []);
            var actions = '<button type="button" class="ds-btn ds-btn-outline" onclick="closeBoardModal();">닫기</button>';
            if (res.editable) {
                actions += '<button type="button" class="ds-btn ds-btn-outline" onclick="editBoard(' + Number(res.detail.boardSn) + ');">수정</button>'
                    + '<button type="button" class="ds-btn ds-btn-danger" onclick="deleteBoard(' + Number(res.detail.boardSn) + ');">삭제</button>';
            }
            $('#boardViewActions').html(actions);
            $('#boardModal').removeClass('hidden').attr('aria-hidden', 'false');
        })
        .fail(function() { alert('게시글 조회 중 오류가 발생했습니다.'); });
}

function renderBoardViewFiles(files) {
    if (!files.length) {
        $('#boardViewFiles').html('<span class="ds-file-empty">첨부파일이 없습니다.</span>');
        return;
    }
    $('#boardViewFiles').html(files.map(function(file) {
        return '<div class="ds-file-row"><a href="' + ctxPath + '/common/fileDownload.do?atchFileSn=' + encodeURIComponent(file.atchFileSn) + '"><i class="fa-solid fa-paperclip"></i> ' + boardHtml(file.orgnlFileNm || '첨부파일') + '</a><em>' + formatBoardFileSize(file.fileSz) + '</em></div>';
    }).join(''));
}

function openBoardForm() {
    boardCurrentDetail = null;
    boardDeleteFileSns = [];
    document.getElementById('boardForm').reset();
    $('#boardSn').val('');
    $('#deleteFileSns').val('');
    $('#boardExistingFiles').empty();
    $('#boardSelectedFiles').empty();
    $('#boardFileSummary').text('선택된 파일 없음');
    $('#boardModalTitle').text('게시글 등록');
    $('#boardModalDesc').text('회사 구성원과 공유할 글을 작성합니다.');
    $('#boardView').addClass('hidden');
    $('#boardForm').removeClass('hidden');
    $('#boardModal').removeClass('hidden').attr('aria-hidden', 'false');
}

function editBoard(boardSn) {
    $.getJSON(ctxPath + '/board/boardDetail.ajax', { boardSn: boardSn })
        .done(function(res) {
            if (res.result !== 'OK' || !res.detail || !res.editable) {
                alert(res.msg || '수정 권한이 없습니다.');
                return;
            }
            boardDeleteFileSns = [];
            boardCurrentDetail = res.detail;
            document.getElementById('boardForm').reset();
            $('#boardSn').val(res.detail.boardSn);
            $('#deleteFileSns').val('');
            $('#boardTitle').val(boardText(res.detail.boardTitle));
            $('#boardCn').val(boardText(res.detail.boardCn));
            $('#boardSelectedFiles').empty();
            $('#boardFileSummary').text('선택된 파일 없음');
            renderBoardEditFiles(res.files || []);
            $('#boardModalTitle').text('게시글 수정');
            $('#boardModalDesc').text('작성한 글과 첨부파일을 수정합니다.');
            $('#boardView').addClass('hidden');
            $('#boardForm').removeClass('hidden');
            $('#boardModal').removeClass('hidden').attr('aria-hidden', 'false');
        });
}

function renderBoardEditFiles(files) {
    if (!files.length) {
        $('#boardExistingFiles').html('<span class="ds-file-empty">기존 첨부파일이 없습니다.</span>');
        return;
    }
    $('#boardExistingFiles').html('<strong class="ds-file-list-title">기존 첨부파일</strong>' + files.map(function(file) {
        return '<div class="ds-file-row" id="boardFileRow' + Number(file.atchFileSn) + '"><a href="' + ctxPath + '/common/fileDownload.do?atchFileSn=' + encodeURIComponent(file.atchFileSn) + '">' + boardHtml(file.orgnlFileNm || '첨부파일') + '</a><span class="ds-file-row-actions"><em>' + formatBoardFileSize(file.fileSz) + '</em><button type="button" class="ds-mini-btn ds-mini-btn-danger" onclick="markBoardFileDelete(' + Number(file.atchFileSn) + ');">삭제</button></span></div>';
    }).join(''));
}

function markBoardFileDelete(fileSn) {
    if (boardDeleteFileSns.indexOf(fileSn) < 0) boardDeleteFileSns.push(fileSn);
    $('#deleteFileSns').val(boardDeleteFileSns.join(','));
    $('#boardFileRow' + fileSn).addClass('is-delete-pending').find('.ds-mini-btn').prop('disabled', true).text('삭제 예정');
}

function closeBoardModal() {
    $('#boardModal').addClass('hidden').attr('aria-hidden', 'true');
}

function deleteBoard(boardSn) {
    if (!confirm('게시글을 삭제하시겠습니까?')) return;
    $.post(ctxPath + '/board/boardDelete.ajax', { boardSn: boardSn }, function(res) {
        if (res.result === 'OK') {
            closeBoardModal();
            loadBoards();
        } else alert(res.msg || '삭제에 실패했습니다.');
    }, 'json');
}

$('#boardFiles').on('change', function() {
    var files = Array.prototype.slice.call(this.files || []);
    $('#boardFileSummary').text(files.length ? files.length + '개 파일 선택' : '선택된 파일 없음');
    $('#boardSelectedFiles').html(files.length ? '<strong class="ds-file-list-title">새 첨부파일</strong>' + files.map(function(file) {
        return '<div class="ds-file-row"><span>' + boardHtml(file.name) + '</span><em>' + formatBoardFileSize(file.size) + '</em></div>';
    }).join('') : '');
});

$('#boardForm').on('submit', function(e) {
    e.preventDefault();
    if (!$.trim($('#boardTitle').val())) { alert('제목을 입력해 주세요.'); $('#boardTitle').focus(); return; }
    if (!$.trim($('#boardCn').val())) { alert('내용을 입력해 주세요.'); $('#boardCn').focus(); return; }
    var input = $('#boardFiles')[0];
    var files = input ? Array.prototype.slice.call(input.files || []) : [];
    for (var i = 0; i < files.length; i++) {
        if (files[i].size > 10000000) { alert(files[i].name + ' 파일이 10MB를 초과합니다.'); return; }
    }
    var formData = new FormData(this);
    $.ajax({
        url: ctxPath + '/board/boardSave.ajax', type: 'POST', data: formData,
        processData: false, contentType: false, dataType: 'json',
        success: function(res) {
            if (res.result === 'OK') { closeBoardModal(); loadBoards(); }
            else alert(res.msg || '저장에 실패했습니다.');
        },
        error: function() { alert('게시글 저장 중 오류가 발생했습니다.'); }
    });
});

function formatBoardFileSize(size) {
    var value = Number(size || 0);
    if (value >= 1000000) return (value / 1000000).toFixed(1) + ' MB';
    if (value >= 1000) return Math.round(value / 1000) + ' KB';
    return value + ' B';
}

$(loadBoards);
