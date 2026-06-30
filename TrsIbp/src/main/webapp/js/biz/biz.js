/**
 * 사업관리 JavaScript
 * - 첨부 DB 스키마 기준 테이블: biz_info, biz_stp_task
 * - 기존 Controller 메소드명과 URL은 유지한다.
 */

var bizTable = null;
var bizCodeMap = {};
var bizCodeGroupIds = ['BIZ_STTS_CD', 'INST_SE_CD', 'BIZ_KND_CD', 'BIZ_SE_CD'];

/**
 * 빈 값이면 대체값을 반환한다.
 * @param {*} value 검사할 값
 * @param {*} defaultValue 빈 값일 때 반환할 값
 * @returns {*} value 또는 defaultValue
 */
function nvl(value, defaultValue) {
    return (value === null || value === undefined || value === '') ? defaultValue : value;
}

/**
 * HTML 문자열 삽입 전 특수문자를 이스케이프한다.
 * @param {string} value 출력 대상 문자열
 * @returns {string} HTML 이스케이프된 문자열
 */
function escapeHtml(value) {
    return String(nvl(value, '')).replace(/[&<>"']/g, function(ch) {
        return {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#39;'
        }[ch];
    });
}

/**
 * 자바스크립트 문자열 리터럴에 넣을 값을 이스케이프한다.
 * @param {string} value 이스케이프 대상 문자열
 * @returns {string} 작은따옴표 문자열에 안전한 값
 */
function escapeJs(value) {
    return String(nvl(value, '')).replace(/\\/g, '\\\\').replace(/'/g, "\\'");
}

/**
 * 숫자 금액을 천 단위 구분 문자열로 변환한다.
 * @param {*} value 금액 값
 * @returns {string} 화면 표시용 금액 문자열
 */
function formatAmt(value) {
    if (value === null || value === undefined || value === '') {
        return '-';
    }
    var num = Number(value);
    if (isNaN(num)) {
        return escapeHtml(value);
    }
    return num.toLocaleString('ko-KR');
}

/**
 * 공통코드 목록을 조회하고 화면 select option을 구성한다.
 * @param {Function} callback 코드 로드 후 실행할 콜백
 * @returns 없음
 */
function loadBizCodeOptions(callback) {
    $.ajax({
        url: ctxPath + '/comm/codeList.ajax',
        type: 'GET',
        dataType: 'json',
        data: { cdGroupIds: bizCodeGroupIds.join(',') },
        success: function(res) {
            if (res.result === 'OK') {
                bizCodeMap = res.codeMap || {};
                populateCodeSelect('searchBizSttsCd', 'BIZ_STTS_CD', '전체');
                populateCodeSelect('searchInstSeCd', 'INST_SE_CD', '전체');
                populateCodeSelect('searchBizKndCd', 'BIZ_KND_CD', '전체');
                populateCodeSelect('searchBizSeCd', 'BIZ_SE_CD', '전체');
                populateCodeSelect('frmBizSttsCd', 'BIZ_STTS_CD', '선택');
                populateCodeSelect('frmInstSeCd', 'INST_SE_CD', '선택');
                populateCodeSelect('frmBizKndCd', 'BIZ_KND_CD', '선택');
                populateCodeSelect('frmBizSeCd', 'BIZ_SE_CD', '선택');
            }
            if (typeof callback === 'function') {
                callback();
            }
        },
        error: function() {
            if (typeof callback === 'function') {
                callback();
            }
        }
    });
}

/**
 * 지정한 select에 공통코드 option을 채운다.
 * @param {string} selectId select element ID
 * @param {string} cdGroupId 코드 그룹 ID
 * @param {string} firstText 첫 번째 빈 option 텍스트
 * @returns 없음
 */
function populateCodeSelect(selectId, cdGroupId, firstText) {
    var $select = $('#' + selectId);
    if ($select.length === 0) {
        return;
    }

    var currentValue = $select.val();
    var html = '<option value="">' + escapeHtml(firstText || '선택') + '</option>';
    $.each(bizCodeMap[cdGroupId] || [], function(_, code) {
        html += '<option value="' + escapeHtml(code.cd) + '">' + escapeHtml(code.cdNm) + '</option>';
    });
    $select.html(html);
    if (currentValue) {
        $select.val(currentValue);
    }
}

/**
 * 공통코드의 기본값을 반환한다.
 * @param {string} cdGroupId 코드 그룹 ID
 * @returns {string} 기본 코드
 */
function getDefaultCode(cdGroupId) {
    var list = bizCodeMap[cdGroupId] || [];
    for (var i = 0; i < list.length; i++) {
        if (list[i].dfltYn === 'Y') {
            return list[i].cd;
        }
    }
    return list.length > 0 ? list[0].cd : '';
}

/**
 * 공통코드명을 반환한다.
 * @param {string} cdGroupId 코드 그룹 ID
 * @param {string} code 코드
 * @returns {string} 코드명
 */
function getCodeNm(cdGroupId, code) {
    var list = bizCodeMap[cdGroupId] || [];
    for (var i = 0; i < list.length; i++) {
        if (list[i].cd === code) {
            return list[i].cdNm;
        }
    }
    return code || '-';
}

/**
 * 사업상태 배지 CSS 클래스를 반환한다.
 * @param {string} code BIZ_STTS_CD 값
 * @returns {string} ds-badge 계열 CSS 클래스명
 */
function getBizSttsBadgeClass(code) {
    var map = {
        READY: 'ds-badge-orange',
        PRGRS: 'ds-badge-green',
        CMPTN: 'ds-badge-blue',
        HOLD: 'ds-badge-cyan',
        CANCEL: 'ds-badge-red'
    };
    return map[code] || 'ds-badge-cyan';
}

/**
 * 사업 목록 화면을 초기화한다.
 * @param 없음
 * @returns 없음
 */
function initBizListPage() {
    loadBizCodeOptions(function() {
        initBizDataTable();
        loadBizList();
    });
}

/**
 * DataTables를 1회 초기화한다.
 * @param 없음
 * @returns 없음
 */
function initBizDataTable() {
    if (!$.fn.DataTable || $.fn.DataTable.isDataTable('#bizTable')) {
        return;
    }

    bizTable = $('#bizTable').DataTable({
        paging: true,
        searching: false,
        ordering: true,
        info: true,
        pageLength: 10,
        lengthChange: false,
        columnDefs: [
            { targets: -1, orderable: false }
        ],
        language: {
            emptyTable: '조회된 사업 데이터가 없습니다.',
            info: '_TOTAL_건 중 _START_ - _END_',
            infoEmpty: '0건',
            zeroRecords: '조회된 사업 데이터가 없습니다.',
            paginate: {
                first: '처음',
                previous: '이전',
                next: '다음',
                last: '마지막'
            }
        }
    });
}

/**
 * 검색 조건 기준으로 사업 목록을 조회하고 테이블에 렌더링한다.
 * @param 없음
 * @returns 없음
 */
function loadBizList() {
    $.ajax({
        url: ctxPath + '/biz/bizList.ajax',
        type: 'GET',
        dataType: 'json',
        data: {
            searchKeyword: $('#searchKeyword').val(),
            searchBizSttsCd: $('#searchBizSttsCd').val(),
            searchInstSeCd: $('#searchInstSeCd').val(),
            searchBizKndCd: $('#searchBizKndCd').val(),
            searchBizSeCd: $('#searchBizSeCd').val(),
            startYmd: $('#startYmd').val(),
            endYmd: $('#endYmd').val()
        },
        success: function(res) {
            if (res.result !== 'OK') {
                alert('사업 목록 조회에 실패했습니다.');
                return;
            }
            renderBizList(res.list || []);
            renderBizSummary(res.list || [], res.totalCnt || 0);
        },
        error: function() {
            alert('사업 목록 조회 중 오류가 발생했습니다.');
        }
    });
}

/**
 * 사업 목록 데이터를 테이블 행으로 변환한다.
 * @param {Array} list 사업 목록 배열
 * @returns 없음
 */
function renderBizList(list) {
    var rows = [];

    $.each(list, function(index, row) {
        var bizId = escapeHtml(row.bizId);
        var sttsCd = nvl(row.bizSttsCd, '');
        var period = escapeHtml(nvl(row.otstYmd || row.bizBgngYmd, '-')) + ' ~ ' + escapeHtml(nvl(row.bizEndYmd, '-'));

        rows.push([
            index + 1,
            '<span class="ds-code">' + escapeHtml(nvl(row.bizCd, '-')) + '</span>',
            '<a class="ds-link" href="' + ctxPath + '/biz/bizDetail.do?bizId=' + encodeURIComponent(row.bizId) + '">' + escapeHtml(row.bizNm) + '</a>',
            escapeHtml(nvl(row.instSeNm, getCodeNm('INST_SE_CD', row.instSeCd))),
            escapeHtml(nvl(row.ordplNm, '-')),
            escapeHtml(nvl(row.bizKndNm, getCodeNm('BIZ_KND_CD', row.bizKndCd))),
            escapeHtml(nvl(row.bizSeNm, getCodeNm('BIZ_SE_CD', row.bizSeCd))),
            '<span class="ds-badge ' + getBizSttsBadgeClass(sttsCd) + '">' + escapeHtml(nvl(row.bizSttsNm, getCodeNm('BIZ_STTS_CD', sttsCd))) + '</span>',
            formatAmt(row.ctrtAmt),
            escapeHtml(nvl(row.ctrtYmd, '-')),
            period,
            '<div class="ds-row-actions">'
                + '<button type="button" class="ds-mini-btn" onclick="goBizUpdate(\'' + escapeJs(row.bizId) + '\');">수정</button>'
                + '<button type="button" class="ds-mini-btn ds-mini-btn-danger" onclick="deleteBizById(\'' + escapeJs(row.bizId) + '\');">삭제</button>'
            + '</div>'
        ]);
    });

    if (bizTable) {
        bizTable.clear();
        bizTable.rows.add(rows);
        bizTable.draw();
        return;
    }

    var html = '';
    if (rows.length === 0) {
        html = '<tr><td colspan="12" class="ds-empty">조회된 사업 데이터가 없습니다.</td></tr>';
    } else {
        $.each(rows, function(_, cols) {
            html += '<tr>';
            $.each(cols, function(__, col) {
                html += '<td>' + col + '</td>';
            });
            html += '</tr>';
        });
    }
    $('#bizListBody').html(html);
}

/**
 * 사업 상태별 요약 카운트를 갱신한다.
 * @param {Array} list 사업 목록 배열
 * @param {number} totalCnt 전체 건수
 * @returns 없음
 */
function renderBizSummary(list, totalCnt) {
    var readyCnt = 0;
    var prgrsCnt = 0;
    var cmptnCnt = 0;

    $.each(list, function(_, row) {
        if (row.bizSttsCd === 'READY') readyCnt++;
        if (row.bizSttsCd === 'PRGRS') prgrsCnt++;
        if (row.bizSttsCd === 'CMPTN') cmptnCnt++;
    });

    $('#summaryTotalCnt').text(totalCnt);
    $('#summaryReadyCnt').text(readyCnt);
    $('#summaryPrgrsCnt').text(prgrsCnt);
    $('#summaryCmptnCnt').text(cmptnCnt);
}

/**
 * 사업 검색 조건을 초기화한 뒤 다시 조회한다.
 * @param 없음
 * @returns 없음
 */
function resetBizSearch() {
    $('#searchKeyword').val('');
    $('#searchBizSttsCd').val('');
    $('#searchInstSeCd').val('');
    $('#searchBizKndCd').val('');
    $('#searchBizSeCd').val('');
    $('#startYmd').val('');
    $('#endYmd').val('');
    loadBizList();
}

/**
 * 사업 등록 화면으로 이동한다.
 * @param 없음
 * @returns 없음
 */
function goBizRegist() {
    location.href = ctxPath + '/biz/bizInsert.do';
}

/**
 * 사업 상세/수정 화면으로 이동한다.
 * @param {string} bizId 사업ID
 * @returns 없음
 */
function goBizDetail(bizId) {
    location.href = ctxPath + '/biz/bizDetail.do?bizId=' + encodeURIComponent(bizId);
}

/**
 * 사업 수정 화면으로 이동한다.
 * @param {string} bizId 사업ID
 * @returns 없음
 */
function goBizUpdate(bizId) {
    location.href = ctxPath + '/biz/bizUpdate.do?bizId=' + encodeURIComponent(bizId);
}

/**
 * 목록에서 지정한 사업ID의 사업을 삭제한다.
 * @param {string} bizId 삭제할 사업ID
 * @returns 없음
 */
function deleteBizById(bizId) {
    if (!bizId) {
        alert('삭제할 사업ID가 없습니다.');
        return;
    }
    if (!confirm('선택한 사업을 삭제하시겠습니까?\n연결된 사업 단계 업무도 함께 삭제될 수 있습니다.')) {
        return;
    }

    $.ajax({
        url: ctxPath + '/biz/bizDelete.ajax',
        type: 'POST',
        dataType: 'json',
        data: { bizId: bizId },
        success: function(res) {
            if (res.result === 'OK') {
                alert('삭제되었습니다.');
                if ($('#bizTable').length > 0) {
                    loadBizList();
                } else {
                    location.href = ctxPath + '/biz/bizList.do';
                }
            } else {
                alert('삭제에 실패했습니다.');
            }
        },
        error: function() {
            alert('삭제 중 오류가 발생했습니다.');
        }
    });
}

/**
 * 사업 등록 화면을 초기화한다.
 * @param 없음
 * @returns 없음
 */
function initBizInsertPage() {
    loadBizCodeOptions(function() {
        $('#frmBizSttsCd').val(getDefaultCode('BIZ_STTS_CD'));
        $('#frmInstSeCd').val(getDefaultCode('INST_SE_CD'));
    });
}

/**
 * 사업 상세 화면을 초기화한다.
 * @param 없음
 * @returns 없음
 */
function initBizDetailPage() {
    if (!checkBizIdOrBack()) {
        return;
    }
    loadBizCodeOptions(function() {
        loadBizDetail();
        loadBizTaskList();
    });
}

/**
 * 사업 수정 화면을 초기화한다.
 * @param 없음
 * @returns 없음
 */
function initBizUpdatePage() {
    if (!checkBizIdOrBack()) {
        return;
    }
    loadBizCodeOptions(function() {
        loadBizDetail();
    });
}

/**
 * 상세/수정 화면의 사업ID 존재 여부를 확인한다.
 * @param 없음
 * @returns 없음
 */
function checkBizIdOrBack() {
    if (!currentBizId) {
        alert('사업ID가 없습니다.');
        location.href = ctxPath + '/biz/bizList.do';
        return false;
    }
    return true;
}

/**
 * 현재 사업ID의 상세 정보를 조회하여 입력폼에 채운다.
 * @param 없음
 * @returns 없음
 */
function loadBizDetail() {
    $.ajax({
        url: ctxPath + '/biz/bizDetail.ajax',
        type: 'GET',
        dataType: 'json',
        data: { bizId: currentBizId },
        success: function(res) {
            if (res.result !== 'OK') {
                alert('사업 상세 조회에 실패했습니다.');
                location.href = ctxPath + '/biz/bizList.do';
                return;
            }
            bindBizForm(res.detail || {});
        },
        error: function() {
            alert('사업 상세 조회 중 오류가 발생했습니다.');
        }
    });
}

/**
 * 사업 상세 데이터를 입력폼에 바인딩한다.
 * @param {Object} data 사업 상세 데이터
 * @returns 없음
 */
function bindBizForm(data) {
    $('#frmBizId').val(nvl(data.bizId, ''));
    $('#frmBizCd').val(nvl(data.bizCd, ''));
    $('#frmBizNm').val(nvl(data.bizNm, ''));
    $('#frmInstSeCd').val(nvl(data.instSeCd, ''));
    $('#frmOrdplNm').val(nvl(data.ordplNm, ''));
    $('#frmBizKndCd').val(nvl(data.bizKndCd, ''));
    $('#frmBizSeCd').val(nvl(data.bizSeCd, ''));
    $('#frmCtrtYmd').val(nvl(data.ctrtYmd, ''));
    $('#frmOtstYmd').val(nvl(data.otstYmd || data.bizBgngYmd, ''));
    $('#frmBizEndYmd').val(nvl(data.bizEndYmd, ''));
    $('#frmCtrtAmt').val(nvl(data.ctrtAmt, ''));
    $('#frmGiveMthdCn').val(nvl(data.giveMthdCn, ''));
    $('#frmGiveDdtYmd').val(nvl(data.giveDdtYmd, ''));
    $('#frmDfrpGrnteBgngYmd').val(nvl(data.dfrpGrnteBgngYmd, ''));
    $('#frmDfrpGrnteEndYmd').val(nvl(data.dfrpGrnteEndYmd, ''));
    $('#frmRmrkCn').val(nvl(data.rmrkCn, ''));
    $('#frmBizSttsCd').val(nvl(data.bizSttsCd, getDefaultCode('BIZ_STTS_CD')));
}

/**
 * 사업 정보를 저장한다. bizId가 없으면 등록, 있으면 수정한다.
 * @param 없음
 * @returns 없음
 */
function saveBiz() {
    if (!$('#frmBizCd').val()) {
        alert('사업코드를 입력하십시오.');
        $('#frmBizCd').focus();
        return;
    }
    if (!$('#frmBizNm').val()) {
        alert('사업명을 입력하십시오.');
        $('#frmBizNm').focus();
        return;
    }

    $.ajax({
        url: ctxPath + '/biz/bizSave.ajax',
        type: 'POST',
        dataType: 'json',
        data: {
            bizId: $('#frmBizId').val(),
            bizCd: $('#frmBizCd').val(),
            bizNm: $('#frmBizNm').val(),
            instSeCd: $('#frmInstSeCd').val(),
            ordplNm: $('#frmOrdplNm').val(),
            bizKndCd: $('#frmBizKndCd').val(),
            bizSeCd: $('#frmBizSeCd').val(),
            ctrtYmd: $('#frmCtrtYmd').val(),
            otstYmd: $('#frmOtstYmd').val(),
            bizEndYmd: $('#frmBizEndYmd').val(),
            ctrtAmt: $('#frmCtrtAmt').val(),
            giveMthdCn: $('#frmGiveMthdCn').val(),
            giveDdtYmd: $('#frmGiveDdtYmd').val(),
            dfrpGrnteBgngYmd: $('#frmDfrpGrnteBgngYmd').val(),
            dfrpGrnteEndYmd: $('#frmDfrpGrnteEndYmd').val(),
            rmrkCn: $('#frmRmrkCn').val(),
            bizSttsCd: $('#frmBizSttsCd').val()
        },
        success: function(res) {
            if (res.result === 'OK') {
                alert('저장되었습니다.');
                location.href = ctxPath + '/biz/bizDetail.do?bizId=' + encodeURIComponent(res.bizId || $('#frmBizId').val());
            } else {
                alert('저장에 실패했습니다.');
            }
        },
        error: function() {
            alert('저장 중 오류가 발생했습니다.');
        }
    });
}

/**
 * 현재 상세 화면의 사업을 삭제한다.
 * @param 없음
 * @returns 없음
 */
function deleteBiz() {
    deleteBizById($('#frmBizId').val());
}

/**
 * 현재 사업ID에 연결된 단계 업무 목록을 조회한다.
 * @param 없음
 * @returns 없음
 */
function loadBizTaskList() {
    $.ajax({
        url: ctxPath + '/biz/schdlList.ajax',
        type: 'GET',
        dataType: 'json',
        data: { bizId: currentBizId },
        success: function(res) {
            renderBizTaskList(res.list || []);
        },
        error: function() {
            $('#bizTaskBody').html('<tr><td colspan="5" class="ds-empty">단계 업무 조회 중 오류가 발생했습니다.</td></tr>');
        }
    });
}

/**
 * 단계 업무 목록을 테이블에 렌더링한다.
 * @param {Array} list 단계 업무 배열
 * @returns 없음
 */
function renderBizTaskList(list) {
    var html = '';

    if (list.length === 0) {
        html = '<tr><td colspan="5" class="ds-empty">등록된 단계 업무가 없습니다.</td></tr>';
    } else {
        $.each(list, function(index, row) {
            html += '<tr>';
            html += '<td>' + (index + 1) + '</td>';
            html += '<td>' + escapeHtml(row.schdlSeCd) + '</td>';
            html += '<td>' + escapeHtml(row.schdlNm) + '</td>';
            html += '<td>' + escapeHtml(row.picId) + '</td>';
            html += '<td>' + escapeHtml(row.rmrkCn) + '</td>';
            html += '</tr>';
        });
    }

    $('#bizTaskBody').html(html);
}
