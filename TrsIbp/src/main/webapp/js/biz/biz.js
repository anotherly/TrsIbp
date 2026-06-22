
/**
 * 사업관리 1차 JavaScript
 * - 사업 목록
 * - 사업 상세 탭
 * - 계약관계 / 투입인력 / 비용 / 일정
 */

function nvl(v, d) {
    return (v === null || v === undefined || v === '') ? d : v;
}

function comma(num) {
    num = nvl(num, 0);
    return String(num).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

function ymdFmt(ymd) {
    if (!ymd || ymd.length !== 8) return nvl(ymd, '');
    return ymd.substring(0, 4) + '-' + ymd.substring(4, 6) + '-' + ymd.substring(6, 8);
}

function getBizPrgrsStepNm(cd) {
    var map = {
        PRE_WORK: '사전작업',
        ORDER: '수주',
        CLOSE: '종료',
        FREE_MAINT: '무상유지보수',
        PAID_MAINT: '유상유지보수'
    };
    return map[cd] || cd || '';
}

function getBizSttsNm(cd) {
    var map = {
        READY: '준비',
        PRGRS: '진행',
        CMPTN: '완료',
        HOLD: '보류',
        CANCEL: '취소'
    };
    return map[cd] || cd || '';
}

/* ============================================================
   사업 목록
   ============================================================ */
function loadBizList() {
    $.ajax({
        url: ctxPath + '/biz/bizList.ajax',
        type: 'GET',
        dataType: 'json',
        data: {
            searchKeyword: $('#searchKeyword').val(),
            searchBizPrgrsStepCd: $('#searchBizPrgrsStepCd').val(),
            searchBizSttsCd: $('#searchBizSttsCd').val()
        },
        success: function(res) {
            if (res.result !== 'OK') {
                alert('사업 목록 조회에 실패했습니다.');
                return;
            }

            var html = '';
            var list = res.list || [];

            if (list.length === 0) {
                html = '<tr><td colspan="10">조회된 데이터가 없습니다.</td></tr>';
            } else {
                $.each(list, function(i, row) {
                    html += '<tr>';
                    html += '<td>' + (i + 1) + '</td>';
                    html += '<td><a href="' + ctxPath + '/biz/bizDetail.do?bizSn=' + row.bizSn + '">' + nvl(row.bizNm, '') + '</a></td>';
                    html += '<td>' + nvl(row.bizPrgrsStepNm, getBizPrgrsStepNm(row.bizPrgrsStepCd)) + '</td>';
                    html += '<td>' + nvl(row.bizSttsNm, getBizSttsNm(row.bizSttsCd)) + '</td>';
                    html += '<td>' + ymdFmt(row.bizBgngYmd) + ' ~ ' + ymdFmt(row.bizEndYmd) + '</td>';
                    html += '<td style="text-align:right;">' + comma(row.ctrtAmt) + '</td>';
                    html += '<td style="text-align:right;">' + comma(row.directCstSum) + '</td>';
                    html += '<td style="text-align:right;">' + comma(row.laborCstSum) + '</td>';
                    html += '<td style="text-align:right;">' + comma(row.profitAmt) + '</td>';
                    html += '<td style="text-align:right;">' + nvl(row.profitRate, 0) + '%</td>';
                    html += '</tr>';
                });
            }

            $('#bizListBody').html(html);
        },
        error: function() {
            alert('사업 목록 조회 중 오류가 발생했습니다.');
        }
    });
}

function openBizForm(row) {
    $('#bizFormTitle').text(row ? '사업 수정' : '사업 등록');
    $('#frmBizSn').val(row ? row.bizSn : '');
    $('#frmBizNm').val(row ? row.bizNm : '');
    $('#frmDtlBizNm').val(row ? row.dtlBizNm : '');
    $('#frmCtrtYmd').val(row ? row.ctrtYmd : '');
    $('#frmBizBgngYmd').val(row ? row.bizBgngYmd : '');
    $('#frmBizEndYmd').val(row ? row.bizEndYmd : '');
    $('#frmCtrtAmt').val(row ? row.ctrtAmt : 0);
    $('#frmVatInclYn').val(row ? row.vatInclYn : 'Y');
    $('#frmBizPrgrsStepCd').val(row ? row.bizPrgrsStepCd : 'PRE_WORK');
    $('#frmBizSttsCd').val(row ? row.bizSttsCd : 'READY');
    $('#frmRmrkCn').val(row ? row.rmrkCn : '');
    $('#bizFormLayer').show();
}

function closeBizForm() {
    $('#bizFormLayer').hide();
}

function saveBiz() {
    if (!$('#frmBizNm').val()) {
        alert('사업명을 입력하십시오.');
        return;
    }

    $.ajax({
        url: ctxPath + '/biz/bizSave.ajax',
        type: 'POST',
        dataType: 'json',
        data: {
            bizSn: $('#frmBizSn').val(),
            bizNm: $('#frmBizNm').val(),
            dtlBizNm: $('#frmDtlBizNm').val(),
            ctrtYmd: $('#frmCtrtYmd').val(),
            bizBgngYmd: $('#frmBizBgngYmd').val(),
            bizEndYmd: $('#frmBizEndYmd').val(),
            ctrtAmt: $('#frmCtrtAmt').val(),
            vatInclYn: $('#frmVatInclYn').val(),
            bizPrgrsStepCd: $('#frmBizPrgrsStepCd').val(),
            bizSttsCd: $('#frmBizSttsCd').val(),
            rmrkCn: $('#frmRmrkCn').val()
        },
        success: function(res) {
            if (res.result === 'OK') {
                alert('저장되었습니다.');
                closeBizForm();
                if (typeof loadBizList === 'function') {
                    loadBizList();
                }
            } else {
                alert('저장에 실패했습니다.');
            }
        },
        error: function() {
            alert('저장 중 오류가 발생했습니다.');
        }
    });
}

/* ============================================================
   사업 상세
   ============================================================ */
function loadBizDetailPage() {
    if (!currentBizSn) {
        alert('사업 식별값이 없습니다.');
        location.href = ctxPath + '/biz/bizList.do';
        return;
    }

    loadBizDetail();
    loadCustRelList();
    loadMnpwList();
    loadCstList();
    loadSchdlList();
    loadProfitSummary();
}

function loadBizDetail() {
    $.ajax({
        url: ctxPath + '/biz/bizDetail.ajax',
        type: 'GET',
        dataType: 'json',
        data: { bizSn: currentBizSn },
        success: function(res) {
            if (res.result !== 'OK') {
                alert('사업 상세 조회에 실패했습니다.');
                return;
            }

            var d = res.detail || {};
            $('#detailBizNm').text(d.bizNm || '사업 상세');

            var html = '';
            html += '<tr><th>사업명</th><td>' + nvl(d.bizNm, '') + '</td></tr>';
            html += '<tr><th>상세사업명</th><td>' + nvl(d.dtlBizNm, '') + '</td></tr>';
            html += '<tr><th>계약일자</th><td>' + ymdFmt(d.ctrtYmd) + '</td></tr>';
            html += '<tr><th>사업기간</th><td>' + ymdFmt(d.bizBgngYmd) + ' ~ ' + ymdFmt(d.bizEndYmd) + '</td></tr>';
            html += '<tr><th>계약금액</th><td>' + comma(d.ctrtAmt) + '원 / VAT 포함: ' + nvl(d.vatInclYn, 'Y') + '</td></tr>';
            html += '<tr><th>사업진행단계</th><td>' + nvl(d.bizPrgrsStepNm, getBizPrgrsStepNm(d.bizPrgrsStepCd)) + '</td></tr>';
            html += '<tr><th>사업상태</th><td>' + nvl(d.bizSttsNm, getBizSttsNm(d.bizSttsCd)) + '</td></tr>';
            html += '<tr><th>비고</th><td>' + nvl(d.rmrkCn, '') + '</td></tr>';

            $('#bizBasicBody').html(html);
        },
        error: function() {
            alert('사업 상세 조회 중 오류가 발생했습니다.');
        }
    });
}

function showBizTab(tabId) {
    $('.biz-tab').hide();
    $('#tab-' + tabId).show();
}

/* ============================================================
   계약관계
   ============================================================ */
function loadCustRelList() {
    $.ajax({
        url: ctxPath + '/biz/custRelList.ajax',
        type: 'GET',
        dataType: 'json',
        data: { bizSn: currentBizSn },
        success: function(res) {
            var list = res.list || [];
            var html = '';
            var chain = [];

            if (list.length === 0) {
                html = '<tr><td colspan="8">등록된 계약관계가 없습니다.</td></tr>';
                $('#contractChainBox').html('계약관계 없음');
            } else {
                $.each(list, function(i, row) {
                    chain.push(nvl(row.custCoNm, '') + '<br><small>' + nvl(row.relSeNm, '') + '</small>');

                    html += '<tr>';
                    html += '<td>' + nvl(row.relSortSeq, '') + '</td>';
                    html += '<td>' + nvl(row.custCoNm, '') + '</td>';
                    html += '<td>' + nvl(row.relSeNm, '') + '</td>';
                    html += '<td>' + nvl(row.relLvl, '') + '</td>';
                    html += '<td>' + nvl(row.directCtrtYn, 'N') + '</td>';
                    html += '<td>' + nvl(row.ourCoYn, 'N') + '</td>';
                    html += '<td>' + nvl(row.rmrkCn, '') + '</td>';
                    html += '<td><button onclick="deleteCustRel(' + row.bizCustRelSn + ')">삭제</button></td>';
                    html += '</tr>';
                });

                $('#contractChainBox').html(chain.join(' &nbsp; → &nbsp; '));
            }

            $('#custRelListBody').html(html);
        }
    });
}

function openCustRelForm() {
    var html = '';
    html += '<input type="hidden" id="relBizCustRelSn">';
    html += '<p>고객사 일련번호 <input type="number" id="relCustSn"> <button type="button" onclick="alert(\'고객사 검색 팝업은 2차 구현\')">검색</button></p>';
    html += '<p>관계구분 <select id="relSeCd">';
    html += '<option value="END_USER">최종 발주처</option>';
    html += '<option value="PRIME_CTRTR">1차 계약자</option>';
    html += '<option value="SUB_CTRTR">하도급사</option>';
    html += '<option value="OUR_CO">우리 회사</option>';
    html += '<option value="ETC">기타</option>';
    html += '</select></p>';
    html += '<p>관계단계 <input type="number" id="relLvl" value="0"></p>';
    html += '<p>정렬순서 <input type="number" id="relSortSeq" value="1"></p>';
    html += '<p>직접계약여부 <select id="directCtrtYn"><option value="N">N</option><option value="Y">Y</option></select></p>';
    html += '<p>우리회사여부 <select id="ourCoYn"><option value="N">N</option><option value="Y">Y</option></select></p>';
    html += '<p>비고 <textarea id="relRmrkCn"></textarea></p>';

    $('#commonFormTitle').text('계약관계 등록');
    $('#commonFormBody').html(html);
    $('#commonSaveBtn').off('click').on('click', saveCustRel);
    $('#commonFormLayer').show();
}

function saveCustRel() {
    $.ajax({
        url: ctxPath + '/biz/custRelSave.ajax',
        type: 'POST',
        dataType: 'json',
        data: {
            bizSn: currentBizSn,
            bizCustRelSn: $('#relBizCustRelSn').val(),
            custSn: $('#relCustSn').val(),
            relSeCd: $('#relSeCd').val(),
            relLvl: $('#relLvl').val(),
            relSortSeq: $('#relSortSeq').val(),
            directCtrtYn: $('#directCtrtYn').val(),
            ourCoYn: $('#ourCoYn').val(),
            rmrkCn: $('#relRmrkCn').val()
        },
        success: function(res) {
            if (res.result === 'OK') {
                closeCommonForm();
                loadCustRelList();
            } else {
                alert('저장에 실패했습니다.');
            }
        }
    });
}

function deleteCustRel(bizCustRelSn) {
    if (!confirm('삭제하시겠습니까?')) return;
    $.post(ctxPath + '/biz/custRelDelete.ajax', { bizCustRelSn: bizCustRelSn }, function(res) {
        if (res.result === 'OK') loadCustRelList();
        else alert('삭제에 실패했습니다.');
    }, 'json');
}

/* ============================================================
   투입인력
   ============================================================ */
function loadMnpwList() {
    $.getJSON(ctxPath + '/biz/mnpwList.ajax', { bizSn: currentBizSn }, function(res) {
        var list = res.list || [];
        var html = '';

        if (list.length === 0) {
            html = '<tr><td colspan="9">등록된 투입인력이 없습니다.</td></tr>';
        } else {
            $.each(list, function(i, row) {
                var labor = (Number(row.inputMcnt || 0) * Number(row.untprc || 0));
                html += '<tr>';
                html += '<td>' + nvl(row.inputMnpwNm, '') + '</td>';
                html += '<td>' + nvl(row.inputSeNm, '') + '</td>';
                html += '<td>' + nvl(row.bizPrgrsStepNm, '') + '</td>';
                html += '<td>' + nvl(row.roleNm, '') + '</td>';
                html += '<td>' + ymdFmt(row.inputBgngYmd) + ' ~ ' + ymdFmt(row.inputEndYmd) + '</td>';
                html += '<td style="text-align:right;">' + nvl(row.inputMcnt, 0) + '</td>';
                html += '<td style="text-align:right;">' + comma(row.untprc) + '</td>';
                html += '<td style="text-align:right;">' + comma(labor) + '</td>';
                html += '<td><button onclick="deleteMnpw(' + row.bizMnpwSn + ')">삭제</button></td>';
                html += '</tr>';
            });
        }

        $('#mnpwListBody').html(html);
    });
}

function openMnpwForm() {
    var html = '';
    html += '<input type="hidden" id="mnpwSn">';
    html += '<p>사용자ID <input type="text" id="mnpwUserId"> 내부 사용자가 아니면 비워둠</p>';
    html += '<p>투입인력명 <input type="text" id="inputMnpwNm"></p>';
    html += '<p>투입구분 <select id="inputSeCd"><option value="MAIN">정</option><option value="SUB">부</option><option value="CONTRACT">계약직</option><option value="OUTSRC">외주</option></select></p>';
    html += '<p>투입단계 <select id="mnpwBizPrgrsStepCd"><option value="PRE_WORK">사전작업</option><option value="ORDER">수주</option><option value="CLOSE">종료</option><option value="FREE_MAINT">무상유지보수</option><option value="PAID_MAINT">유상유지보수</option></select></p>';
    html += '<p>역할 <input type="text" id="roleNm" placeholder="PM/PL/개발/QA"></p>';
    html += '<p>직위 <input type="text" id="jbpsNm"></p>';
    html += '<p>투입기간 <input type="text" id="inputBgngYmd" placeholder="YYYYMMDD"> ~ <input type="text" id="inputEndYmd" placeholder="YYYYMMDD"></p>';
    html += '<p>MM <input type="number" step="0.01" id="inputMcnt" value="0"></p>';
    html += '<p>월단가 <input type="number" id="untprc" value="0"></p>';
    html += '<p>비고 <textarea id="mnpwRmrkCn"></textarea></p>';

    $('#commonFormTitle').text('투입인력 등록');
    $('#commonFormBody').html(html);
    $('#commonSaveBtn').off('click').on('click', saveMnpw);
    $('#commonFormLayer').show();
}

function saveMnpw() {
    $.post(ctxPath + '/biz/mnpwSave.ajax', {
        bizSn: currentBizSn,
        bizMnpwSn: $('#mnpwSn').val(),
        userId: $('#mnpwUserId').val(),
        inputMnpwNm: $('#inputMnpwNm').val(),
        inputSeCd: $('#inputSeCd').val(),
        bizPrgrsStepCd: $('#mnpwBizPrgrsStepCd').val(),
        roleNm: $('#roleNm').val(),
        jbpsNm: $('#jbpsNm').val(),
        inputBgngYmd: $('#inputBgngYmd').val(),
        inputEndYmd: $('#inputEndYmd').val(),
        inputMcnt: $('#inputMcnt').val(),
        untprc: $('#untprc').val(),
        rmrkCn: $('#mnpwRmrkCn').val()
    }, function(res) {
        if (res.result === 'OK') {
            closeCommonForm();
            loadMnpwList();
            loadProfitSummary();
        } else {
            alert('저장에 실패했습니다.');
        }
    }, 'json');
}

function deleteMnpw(bizMnpwSn) {
    if (!confirm('삭제하시겠습니까?')) return;
    $.post(ctxPath + '/biz/mnpwDelete.ajax', { bizMnpwSn: bizMnpwSn }, function(res) {
        if (res.result === 'OK') {
            loadMnpwList();
            loadProfitSummary();
        } else {
            alert('삭제에 실패했습니다.');
        }
    }, 'json');
}

/* ============================================================
   비용
   ============================================================ */
function loadCstList() {
    $.getJSON(ctxPath + '/biz/cstList.ajax', { bizSn: currentBizSn }, function(res) {
        var list = res.list || [];
        var html = '';

        if (list.length === 0) {
            html = '<tr><td colspan="6">등록된 비용이 없습니다.</td></tr>';
        } else {
            $.each(list, function(i, row) {
                html += '<tr>';
                html += '<td>' + ymdFmt(row.ocrnYmd) + '</td>';
                html += '<td>' + nvl(row.cstSeNm, '') + '</td>';
                html += '<td>' + nvl(row.cstNm, '') + '</td>';
                html += '<td style="text-align:right;">' + comma(row.ocrnCst) + '</td>';
                html += '<td>' + nvl(row.rmrkCn, '') + '</td>';
                html += '<td><button onclick="deleteCst(' + row.bizCstSn + ')">삭제</button></td>';
                html += '</tr>';
            });
        }

        $('#cstListBody').html(html);
    });
}

function openCstForm() {
    var html = '';
    html += '<input type="hidden" id="bizCstSn">';
    html += '<p>비용구분 <select id="cstSeCd"><option value="BTEXP">출장비</option><option value="LDG_CST">숙박비</option><option value="MEAL_CST">식대</option><option value="MEETING_CST">회의비</option><option value="ENTERTAIN">접대비</option><option value="MTCO">재료비</option><option value="ETC_CST">기타비용</option></select></p>';
    html += '<p>비용명 <input type="text" id="cstNm"></p>';
    html += '<p>발생비용 <input type="number" id="ocrnCst" value="0"></p>';
    html += '<p>발생일자 <input type="text" id="ocrnYmd" placeholder="YYYYMMDD"></p>';
    html += '<p>비고 <textarea id="cstRmrkCn"></textarea></p>';

    $('#commonFormTitle').text('비용 등록');
    $('#commonFormBody').html(html);
    $('#commonSaveBtn').off('click').on('click', saveCst);
    $('#commonFormLayer').show();
}

function saveCst() {
    $.post(ctxPath + '/biz/cstSave.ajax', {
        bizSn: currentBizSn,
        bizCstSn: $('#bizCstSn').val(),
        cstSeCd: $('#cstSeCd').val(),
        cstNm: $('#cstNm').val(),
        ocrnCst: $('#ocrnCst').val(),
        ocrnYmd: $('#ocrnYmd').val(),
        rmrkCn: $('#cstRmrkCn').val()
    }, function(res) {
        if (res.result === 'OK') {
            closeCommonForm();
            loadCstList();
            loadProfitSummary();
        } else {
            alert('저장에 실패했습니다.');
        }
    }, 'json');
}

function deleteCst(bizCstSn) {
    if (!confirm('삭제하시겠습니까?')) return;
    $.post(ctxPath + '/biz/cstDelete.ajax', { bizCstSn: bizCstSn }, function(res) {
        if (res.result === 'OK') {
            loadCstList();
            loadProfitSummary();
        } else {
            alert('삭제에 실패했습니다.');
        }
    }, 'json');
}

/* ============================================================
   일정
   ============================================================ */
function loadSchdlList() {
    $.getJSON(ctxPath + '/biz/schdlList.ajax', { bizSn: currentBizSn }, function(res) {
        var list = res.list || [];
        var html = '';

        if (list.length === 0) {
            html = '<tr><td colspan="6">등록된 일정이 없습니다.</td></tr>';
        } else {
            $.each(list, function(i, row) {
                html += '<tr>';
                html += '<td>' + nvl(row.schdlNm, '') + '</td>';
                html += '<td>' + nvl(row.schdlSeNm, '') + '</td>';
                html += '<td>' + ymdFmt(row.schdlBgngYmd) + ' ~ ' + ymdFmt(row.schdlEndYmd) + '</td>';
                html += '<td>' + nvl(row.picNm, row.picId) + '</td>';
                html += '<td>' + nvl(row.schdlCn, '') + '</td>';
                html += '<td><button onclick="deleteSchdl(' + row.bizSchdlSn + ')">삭제</button></td>';
                html += '</tr>';
            });
        }

        $('#schdlListBody').html(html);
    });
}

function openSchdlForm() {
    var html = '';
    html += '<input type="hidden" id="bizSchdlSn">';
    html += '<p>일정명 <input type="text" id="schdlNm"></p>';
    html += '<p>일정구분 <select id="schdlSeCd"><option value="PRE_WORK">사전작업</option><option value="SUPPORT">지원</option><option value="REG_MAINT">정기유지보수</option><option value="ISSUE">장애대응</option><option value="ETC">기타</option></select></p>';
    html += '<p>일정기간 <input type="text" id="schdlBgngYmd" placeholder="YYYYMMDD"> ~ <input type="text" id="schdlEndYmd" placeholder="YYYYMMDD"></p>';
    html += '<p>담당자ID <input type="text" id="picId"></p>';
    html += '<p>내용 <textarea id="schdlCn"></textarea></p>';
    html += '<p>비고 <textarea id="schdlRmrkCn"></textarea></p>';

    $('#commonFormTitle').text('일정 등록');
    $('#commonFormBody').html(html);
    $('#commonSaveBtn').off('click').on('click', saveSchdl);
    $('#commonFormLayer').show();
}

function saveSchdl() {
    $.post(ctxPath + '/biz/schdlSave.ajax', {
        bizSn: currentBizSn,
        bizSchdlSn: $('#bizSchdlSn').val(),
        schdlNm: $('#schdlNm').val(),
        schdlSeCd: $('#schdlSeCd').val(),
        schdlBgngYmd: $('#schdlBgngYmd').val(),
        schdlEndYmd: $('#schdlEndYmd').val(),
        picId: $('#picId').val(),
        schdlCn: $('#schdlCn').val(),
        rmrkCn: $('#schdlRmrkCn').val()
    }, function(res) {
        if (res.result === 'OK') {
            closeCommonForm();
            loadSchdlList();
        } else {
            alert('저장에 실패했습니다.');
        }
    }, 'json');
}

function deleteSchdl(bizSchdlSn) {
    if (!confirm('삭제하시겠습니까?')) return;
    $.post(ctxPath + '/biz/schdlDelete.ajax', { bizSchdlSn: bizSchdlSn }, function(res) {
        if (res.result === 'OK') loadSchdlList();
        else alert('삭제에 실패했습니다.');
    }, 'json');
}

/* ============================================================
   손익
   ============================================================ */
function loadProfitSummary() {
    $.getJSON(ctxPath + '/biz/profitSummary.ajax', { bizSn: currentBizSn }, function(res) {
        var s = res.summary || {};
        $('#summaryCtrtAmt').text(' / 계약금액: ' + comma(s.ctrtAmt));
        $('#summaryDirectCst').text(' / 직접비: ' + comma(s.directCstSum));
        $('#summaryLaborCst').text(' / 인건비: ' + comma(s.laborCstSum));
        $('#summaryProfit').text(' / 예상손익: ' + comma(s.profitAmt) + ' (' + nvl(s.profitRate, 0) + '%)');

        var html = '';
        html += '<tr><th>계약금액</th><td style="text-align:right;">' + comma(s.ctrtAmt) + '</td></tr>';
        html += '<tr><th>직접비 합계</th><td style="text-align:right;">' + comma(s.directCstSum) + '</td></tr>';
        html += '<tr><th>인건비 합계</th><td style="text-align:right;">' + comma(s.laborCstSum) + '</td></tr>';
        html += '<tr><th>총 비용</th><td style="text-align:right;">' + comma(s.totalCstSum) + '</td></tr>';
        html += '<tr><th>예상 영업이익</th><td style="text-align:right;">' + comma(s.profitAmt) + '</td></tr>';
        html += '<tr><th>이익률</th><td style="text-align:right;">' + nvl(s.profitRate, 0) + '%</td></tr>';

        $('#profitDetailBody').html(html);
    });
}

function closeCommonForm() {
    $('#commonFormLayer').hide();
    $('#commonFormTitle').text('');
    $('#commonFormBody').html('');
    $('#commonSaveBtn').off('click');
}
