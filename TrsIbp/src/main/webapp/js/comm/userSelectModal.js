/* =========================================================
 * 공통 단일 사용자 선택 모달
 * - 여러 업무 화면에서 사용자/담당자 1명을 선택할 때 재사용한다.
 * - USER_ID는 각 업무 화면의 hidden input에 저장하고, 화면에는 USER_NM을 표시한다.
 * ========================================================= */
(function(window, $) {
    'use strict';

    var userSelectTarget = '';
    var userSelectDeptId = '';

    /**
     * null/undefined 값을 기본 문자열로 치환한다.
     * @param {*} value 검사할 값
     * @param {string} defaultValue 값이 없을 때 반환할 기본값
     * @returns {string} 치환된 문자열
     */
    function usmNvl(value, defaultValue) {
        return value === null || value === undefined || value === '' ? (defaultValue || '') : value;
    }

    /**
     * HTML 출력용 문자열을 이스케이프한다.
     * @param {*} value 이스케이프할 값
     * @returns {string} HTML 특수문자가 변환된 문자열
     */
    function usmEscapeHtml(value) {
        return String(usmNvl(value, ''))
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

    /**
     * onclick 인자에 넣을 수 있도록 문자열을 이스케이프한다.
     * @param {*} value 이스케이프할 값
     * @returns {string} JS 문자열용 이스케이프 결과
     */
    function usmEscapeJs(value) {
        return String(usmNvl(value, '')).replace(/\\/g, '\\\\').replace(/'/g, "\\'");
    }

    /**
     * 행 데이터를 URI 인코딩 JSON 문자열로 변환한다.
     * @param {Object} row 인코딩할 행 데이터
     * @returns {string} URI 인코딩된 JSON 문자열
     */
    function usmEncodeRowData(row) {
        return encodeURIComponent(JSON.stringify(row || {}));
    }

    /**
     * URI 인코딩된 행 데이터를 Object로 복원한다.
     * @param {string} encodedRow URI 인코딩된 JSON 문자열
     * @returns {Object} 복원된 행 데이터
     */
    function usmDecodeRowData(encodedRow) {
        try {
            return JSON.parse(decodeURIComponent(encodedRow || '%7B%7D'));
        } catch (e) {
            return {};
        }
    }

    /**
     * 단일 사용자 선택 모달을 연다.
     * @param {string} target 선택 결과를 반영할 대상 구분값(mnpw: 투입인력, schdl: 일정 담당자)
     * @returns 없음
     */
    window.openUserSelectModal = function(target) {
        userSelectTarget = target || '';
        userSelectDeptId = '';
        $('#userSelectKeyword').val('');
        $('#userSelectModal').removeClass('hidden').attr('aria-hidden', 'false');
        window.loadUserSelectList();
        setTimeout(function() { $('#userSelectKeyword').focus(); }, 50);
    };

    /**
     * 단일 사용자 선택 모달을 닫는다.
     * @param 없음
     * @returns 없음
     */
    window.closeUserSelectModal = function() {
        $('#userSelectModal').addClass('hidden').attr('aria-hidden', 'true');
    };

    /**
     * 사용자 선택 모달의 부서/사용자 목록을 조회한다.
     * @param 없음
     * @returns 없음
     */
    window.loadUserSelectList = function() {
        $.ajax({
            url: ctxPath + '/common/userSelectList.ajax',
            type: 'GET',
            dataType: 'json',
            data: {
                deptId: userSelectDeptId,
                searchKeyword: $('#userSelectKeyword').val()
            },
            success: function(res) {
                if (res.result !== 'OK') {
                    $('#userSelectDeptList').html('<div class="ds-empty">조직 조회 권한이 없습니다.</div>');
                    $('#userSelectUserList').html('<div class="ds-empty">사용자 조회 권한이 없습니다.</div>');
                    return;
                }
                renderUserSelectDeptList(res.deptList || []);
                renderUserSelectUserList(res.userList || []);
            },
            error: function() {
                $('#userSelectUserList').html('<div class="ds-empty">사용자 조회 중 오류가 발생했습니다.</div>');
            }
        });
    };

    /**
     * 사용자 선택 모달의 부서 목록을 렌더링한다.
     * @param {Array} deptList 부서 목록
     * @returns 없음
     */
    function renderUserSelectDeptList(deptList) {
        var html = '<button type="button" class="ds-user-dept-item ' + (userSelectDeptId === '' ? 'is-active' : '') + '" onclick="selectUserDept(\'\');">전체</button>';
        $.each(deptList, function(index, dept) {
            var depthCls = dept.upDeptId ? ' is-child' : '';
            var depthMark = dept.upDeptId ? 'ㄴ ' : '';
            html += '<button type="button" class="ds-user-dept-item' + depthCls + ' ' + (userSelectDeptId === usmNvl(dept.deptId, '') ? 'is-active' : '') + '" onclick="selectUserDept(\'' + usmEscapeJs(dept.deptId) + '\');">'
                + '<span>' + depthMark + usmEscapeHtml(usmNvl(dept.deptNm, dept.deptId)) + '</span>'
                + '</button>';
        });
        $('#userSelectDeptList').html(html);
    }

    /**
     * 사용자 선택 모달에서 부서를 선택하고 사용자 목록을 다시 조회한다.
     * @param {string} deptId 선택 부서ID
     * @returns 없음
     */
    window.selectUserDept = function(deptId) {
        userSelectDeptId = deptId || '';
        window.loadUserSelectList();
    };

    /**
     * 사용자 선택 모달의 사용자 목록을 렌더링한다.
     * @param {Array} userList 사용자 목록
     * @returns 없음
     */
    function renderUserSelectUserList(userList) {
        if (userList.length === 0) {
            $('#userSelectUserList').html('<div class="ds-empty">조회된 사용자가 없습니다.</div>');
            return;
        }
        var html = '';
        $.each(userList, function(index, user) {
            html += '<button type="button" class="ds-user-row" onclick="applySelectedUserFromEncoded(\'' + usmEncodeRowData(user) + '\');">'
                + '<span><strong>' + usmEscapeHtml(usmNvl(user.userNm, '-')) + '</strong>'
                + '<span>' + usmEscapeHtml(usmNvl(user.deptNm, '-')) + ' / ' + usmEscapeHtml(usmNvl(user.jbpsNm, '-')) + ' / ' + usmEscapeHtml(usmNvl(user.userId, '-')) + '</span></span>'
                + '<em>선택</em>'
                + '</button>';
        });
        $('#userSelectUserList').html(html);
    }

    /**
     * 인코딩된 사용자 행 데이터를 복원해 현재 대상 입력폼에 반영한다.
     * @param {string} encodedUser URI 인코딩된 사용자 JSON 문자열
     * @returns 없음
     */
    window.applySelectedUserFromEncoded = function(encodedUser) {
        window.applySelectedUser(usmDecodeRowData(encodedUser));
    };

    /**
     * 선택한 사용자를 투입인력 또는 일정 담당자 입력폼에 반영한다.
     * @param {Object} user 사용자ID, 사용자명, 직위명, 부서명을 포함한 사용자 데이터
     * @returns 없음
     */
    window.applySelectedUser = function(user) {
        if (userSelectTarget === 'mnpw') {
            $('#frmUserId').val(usmNvl(user.userId, ''));
            $('#frmUserDispNm').val(usmNvl(user.userNm, ''));
            $('#frmInputMnpwNm').val(usmNvl(user.userNm, ''));
            if (!$('#frmJbpsNm').val()) {
                $('#frmJbpsNm').val(usmNvl(user.jbpsNm, ''));
            }
        } else if (userSelectTarget === 'schdl') {
            $('#frmPicId').val(usmNvl(user.userId, ''));
            $('#frmPicDispNm').val(usmNvl(user.userNm, ''));
        }
        window.closeUserSelectModal();
    };

    $(document).on('keydown', '#userSelectKeyword', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            window.loadUserSelectList();
        }
    });
})(window, jQuery);
