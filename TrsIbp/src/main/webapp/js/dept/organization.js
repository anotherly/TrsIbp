/**
 * 회사 관리 > 조직 관리
 * dept_info와 user_info를 기반으로 조직 트리, 조직도, 상세, 등록/수정/삭제를 처리한다.
 */
(function (window, $) {
    'use strict';

    var COMPANY_ID = '__COMPANY__';
    var typeLabels = { COMPANY: '회사', HQ: '본부', DEPT: '부서', TEAM: '팀' };
    var organizations = [];
    var members = [];
    var summary = {};
    var selectedId = COMPANY_ID;
    var expanded = {};
    var modalParentId = COMPANY_ID;
    var toastTimer = null;

    window.initOrganizationPage = function () {
        bindEvents();
        loadOrganizationData();
    };

    function contextPath() {
        return window.dsContextPath || '';
    }

    function bindEvents() {
        $('#orgAddBtn, #orgTreeAddBtn').on('click', function () { openAddModal(COMPANY_ID, true); });
        $('#orgResetViewBtn').on('click', function () { selectOrganization(COMPANY_ID); });
        $('#orgExpandBtn').on('click', toggleAllTree);
        $('#orgTreeKeyword').on('input', renderTree);
        $('#orgDeptSeCd').on('change', function () { fillParentOptions(this.value, modalParentId); });
        $('#orgDeptId').on('input', function () {
            this.value = this.value.toUpperCase().replace(/[^A-Z0-9-]/g, '');
        });
        $('#orgModalCloseBtn, #orgModalCancelBtn').on('click', closeModal);
        $('#orgSaveBtn').on('click', saveOrganization);

        $(document).on('click', '[data-org-select]', function (event) {
            if ($(event.target).closest('[data-org-add]').length) return;
            selectOrganization($(this).attr('data-org-select'));
        });
        $(document).on('click', '[data-org-toggle]', function (event) {
            event.stopPropagation();
            var id = $(this).attr('data-org-toggle');
            expanded[id] = !expanded[id];
            renderTree();
        });
        $(document).on('click', '[data-org-add]', function (event) {
            event.stopPropagation();
            openAddModal($(this).attr('data-org-add'), false);
        });
        $(document).on('click', '[data-org-edit]', function () {
            openEditModal($(this).attr('data-org-edit'));
        });
        $(document).on('click', '[data-org-delete]', function () {
            deleteOrganization($(this).attr('data-org-delete'));
        });
        $(document).on('keydown', function (event) {
            if (event.key === 'Escape' && !$('#orgEditModal').hasClass('hidden')) closeModal();
        });
    }

    function loadOrganizationData(preferredId) {
        $.ajax({
            url: contextPath() + '/dept/organizationData.ajax',
            type: 'GET',
            dataType: 'json',
            success: function (response) {
                if (response.result !== 'OK') {
                    showToast(response.msg || '조직 정보를 불러오지 못했습니다.', true);
                    return;
                }
                summary = response.summary || {};
                organizations = response.organizationList || [];
                members = response.memberList || [];
                normalizeData();
                organizations.forEach(function (item) { expanded[item.deptId] = true; });
                selectedId = preferredId && findOrganization(preferredId) ? preferredId : selectedId;
                if (selectedId !== COMPANY_ID && !findOrganization(selectedId)) selectedId = COMPANY_ID;
                renderAll();
            },
            error: function () {
                showToast('조직 정보 조회 중 오류가 발생했습니다.', true);
            }
        });
    }

    function normalizeData() {
        organizations.forEach(function (item) {
            item.sortDeptSeq = numberValue(item.sortDeptSeq);
            item.memberCnt = numberValue(item.memberCnt);
            item.childCnt = numberValue(item.childCnt);
            item.deptSeCd = item.deptSeCd || (item.upDeptId ? 'TEAM' : 'HQ');
        });
        organizations.sort(compareOrganizations);
    }

    function renderAll() {
        $('#orgCompanyName').text(summaryValue('coNm') || '-');
        $('#orgCount').text(numberValue(summaryValue('orgCnt')));
        $('#orgMemberCount').text(numberValue(summaryValue('memberCnt')) + '명');
        $('#orgUnassignedCount').text(numberValue(summaryValue('unassignedCnt')) + '명');
        renderTree();
        renderChart();
        renderDetail();
    }

    function renderTree() {
        var keyword = $.trim($('#orgTreeKeyword').val()).toLowerCase();
        var company = companyNode();
        $('#orgTree').html('<ul class="ds-org-tree-list">' + treeItem(company, keyword) + '</ul>');
    }

    function treeItem(node, keyword) {
        if (!treeNodeVisible(node, keyword)) return '';
        var children = childrenOf(node.deptId);
        var open = keyword || expanded[node.deptId] !== false;
        var icon = node.deptSeCd === 'COMPANY' ? 'C' : node.deptSeCd === 'HQ' ? 'H' : node.deptSeCd === 'DEPT' ? 'D' : 'T';
        var canAdd = node.deptSeCd !== 'TEAM';
        return '<li class="ds-org-tree-item' + (open ? '' : ' is-collapsed') + '">'
            + '<div class="ds-org-tree-row' + (selectedId === node.deptId ? ' is-selected' : '') + '" data-org-select="' + attr(node.deptId) + '">'
            + '<button type="button" class="ds-org-tree-toggle" data-org-toggle="' + attr(node.deptId) + '">' + (children.length ? (open ? '▼' : '▶') : '·') + '</button>'
            + '<span class="ds-org-tree-type">' + icon + '</span><span class="ds-org-tree-name">' + html(node.deptNm) + '</span>'
            + '<span class="ds-org-tree-count">' + numberValue(node.memberCnt) + '</span>'
            + (canAdd ? '<button type="button" class="ds-org-tree-add" data-org-add="' + attr(node.deptId) + '" title="하위 조직 추가"><i class="fa-solid fa-plus"></i></button>' : '')
            + '</div>'
            + (children.length ? '<ul>' + children.map(function (child) { return treeItem(child, keyword); }).join('') + '</ul>' : '')
            + '</li>';
    }

    function treeNodeVisible(node, keyword) {
        if (!keyword || String(node.deptNm || '').toLowerCase().indexOf(keyword) >= 0) return true;
        return childrenOf(node.deptId).some(function (child) { return treeNodeVisible(child, keyword); });
    }

    function renderChart() {
        var company = companyNode();
        var topNodes = childrenOf(COMPANY_ID);
        var branches = topNodes.map(function (node) {
            return '<section class="ds-org-branch">' + chartCard(node, 'ds-org-branch-card') + chartChildren(node.deptId) + '</section>';
        }).join('');
        $('#orgChart').html('<div class="ds-org-root-wrap">' + chartCard(company, 'ds-org-root-card') + '</div>'
            + (topNodes.length ? '<div class="ds-org-branches" style="--org-edge:' + (50 / topNodes.length) + '%;grid-template-columns:repeat(' + topNodes.length + ',minmax(205px,1fr))">' + branches + '</div>'
                : '<div class="ds-empty ds-org-chart-empty">등록된 조직이 없습니다. 상단의 조직 추가 버튼으로 시작해 주세요.</div>'));
    }

    function chartChildren(parentId) {
        var children = childrenOf(parentId);
        if (!children.length) return '';
        return '<div class="ds-org-chart-children">' + children.map(function (child) {
            return '<div class="ds-org-chart-child">' + chartCard(child, 'ds-org-child-card') + chartChildren(child.deptId) + '</div>';
        }).join('') + '</div>';
    }

    function chartCard(node, extraClass) {
        var canAdd = node.deptSeCd !== 'TEAM';
        var leader = node.deptSeCd === 'COMPANY' ? '회사 조직도' : (node.mngrUserNm || '조직장 미지정');
        return '<article class="ds-org-node-card ' + extraClass + (selectedId === node.deptId ? ' is-selected' : '') + '" data-org-select="' + attr(node.deptId) + '">'
            + '<span class="ds-org-type-badge">' + html(typeLabels[node.deptSeCd] || '조직') + '</span>'
            + '<strong>' + html(node.deptNm) + '</strong><small>' + html(leader) + ' · ' + numberValue(node.memberCnt) + '명</small>'
            + (canAdd ? '<button type="button" class="ds-org-card-add" data-org-add="' + attr(node.deptId) + '" title="하위 조직 추가"><i class="fa-solid fa-plus"></i></button>' : '')
            + '</article>';
    }

    function renderDetail() {
        var node = selectedId === COMPANY_ID ? companyNode() : findOrganization(selectedId);
        if (!node) node = companyNode();
        var nodeMembers = node.deptSeCd === 'COMPANY' ? members : members.filter(function (member) { return member.deptId === node.deptId; });
        var parent = node.deptSeCd === 'COMPANY' ? null : (node.upDeptId ? findOrganization(node.upDeptId) : companyNode());
        var actions = node.deptSeCd === 'COMPANY' ? '' : '<div class="ds-org-detail-actions"><button type="button" class="ds-btn ds-btn-outline" data-org-edit="' + attr(node.deptId) + '">수정</button><button type="button" class="ds-btn ds-btn-danger" data-org-delete="' + attr(node.deptId) + '">삭제</button></div>';
        var memberHtml = nodeMembers.length ? nodeMembers.map(function (member) {
            var manager = node.mngrUserId && node.mngrUserId === member.userId;
            return '<div class="ds-org-member"><span class="ds-org-member-avatar">' + html(String(member.userNm || '?').substring(0, 1)) + '</span>'
                + '<div><strong>' + html(member.userNm || member.userId) + '</strong><small>' + html(member.jbpsNm || '직위 미지정') + '</small></div>'
                + (manager ? '<em>조직장</em>' : '') + '</div>';
        }).join('') : '<div class="ds-empty ds-org-member-empty">소속 사용자가 없습니다.</div>';

        $('#orgDetail').html('<div class="ds-org-detail-title"><span class="ds-org-type-badge">' + html(typeLabels[node.deptSeCd]) + '</span><h3>' + html(node.deptNm) + '</h3><p>' + html(node.deptExpln || (node.deptSeCd === 'COMPANY' ? '회사 전체 조직을 관리합니다.' : '등록된 조직 설명이 없습니다.')) + '</p>' + actions + '</div>'
            + '<dl class="ds-org-kv"><dt>조직 코드</dt><dd>' + html(node.deptSeCd === 'COMPANY' ? (summaryValue('coId') || '-') : node.deptId) + '</dd>'
            + '<dt>상위 조직</dt><dd>' + html(parent ? parent.deptNm : '-') + '</dd><dt>전체 경로</dt><dd>' + html(organizationPath(node)) + '</dd>'
            + '<dt>조직장</dt><dd>' + html(node.mngrUserNm || '미지정') + '</dd><dt>사용 여부</dt><dd class="is-use">사용</dd></dl>'
            + '<div class="ds-org-member-head"><span>소속 구성원</span><b>' + nodeMembers.length + '명</b></div><div class="ds-org-members">' + memberHtml + '</div>'
            + '<p class="ds-org-detail-hint">조직 관리에서 저장한 내용은 사용자 등록·수정 화면의 <b>부서 선택</b> 모달에 바로 반영됩니다.</p>');
    }

    function selectOrganization(id) {
        selectedId = id;
        renderTree();
        renderChart();
        renderDetail();
    }

    function openAddModal(parentId, globalAdd) {
        var parent = parentId === COMPANY_ID ? companyNode() : findOrganization(parentId);
        if (!parent) parent = companyNode();
        var allowed = allowedChildTypes(parent.deptSeCd);
        if (!allowed.length) {
            showToast('팀 아래에는 하위 조직을 추가할 수 없습니다.', true);
            return;
        }
        modalParentId = parent.deptId;
        $('#orgForm')[0].reset();
        $('#orgFormMode').val('insert');
        $('#orgModalTitle').text(globalAdd ? '조직 추가' : '하위 조직 추가');
        $('#orgModalDesc').text(globalAdd ? '조직 구분과 상위 조직을 선택해 등록합니다.' : parent.deptNm + ' 아래에 새 조직을 등록합니다.');
        setTypeOptions(globalAdd ? ['HQ', 'DEPT', 'TEAM'] : allowed);
        var type = globalAdd ? 'HQ' : allowed[0];
        $('#orgDeptSeCd').val(type).prop('disabled', false);
        $('#orgDeptId').prop('readonly', false);
        fillParentOptions(type, globalAdd ? COMPANY_ID : parent.deptId);
        $('#orgSortDeptSeq').val(childrenOf(parent.deptId).length + 1);
        fillManagerOptions('');
        openModal();
    }

    function openEditModal(id) {
        var node = findOrganization(id);
        if (!node) return;
        modalParentId = node.upDeptId || COMPANY_ID;
        $('#orgForm')[0].reset();
        $('#orgFormMode').val('update');
        $('#orgModalTitle').text('조직 수정');
        $('#orgModalDesc').text('조직명, 상위 조직, 조직장 등 기본정보를 수정합니다.');
        setTypeOptions([node.deptSeCd]);
        $('#orgDeptSeCd').val(node.deptSeCd).prop('disabled', true);
        fillParentOptions(node.deptSeCd, node.upDeptId || COMPANY_ID, node.deptId);
        $('#orgDeptId').val(node.deptId).prop('readonly', true);
        $('#orgDeptNm').val(node.deptNm);
        $('#orgSortDeptSeq').val(node.sortDeptSeq);
        $('#orgDeptExpln').val(node.deptExpln || '');
        fillManagerOptions(node.mngrUserId || '');
        openModal();
    }

    function setTypeOptions(allowed) {
        $('#orgDeptSeCd option').each(function () { this.disabled = allowed.indexOf(this.value) < 0; });
    }

    function fillParentOptions(type, preferredId, editingId) {
        var options = [];
        if (type === 'HQ' || type === 'DEPT') options.push(companyNode());
        organizations.forEach(function (item) {
            if (item.deptId === editingId) return;
            if (type === 'DEPT' && item.deptSeCd === 'HQ') options.push(item);
            if (type === 'TEAM' && item.deptSeCd === 'DEPT') options.push(item);
        });
        $('#orgUpDeptId').html(options.map(function (item) {
            var value = item.deptId === COMPANY_ID ? '' : item.deptId;
            return '<option value="' + attr(value) + '">' + html(organizationPath(item)) + '</option>';
        }).join(''));
        var preferredValue = preferredId === COMPANY_ID ? '' : preferredId;
        if ($('#orgUpDeptId option[value="' + cssEscape(preferredValue) + '"]').length) $('#orgUpDeptId').val(preferredValue);
        modalParentId = preferredId || COMPANY_ID;
    }

    function fillManagerOptions(selectedUserId) {
        var options = '<option value="">미지정</option>' + members.map(function (member) {
            var label = member.userNm + (member.jbpsNm ? ' · ' + member.jbpsNm : '') + (member.deptNm ? ' (' + member.deptNm + ')' : '');
            return '<option value="' + attr(member.userId) + '">' + html(label) + '</option>';
        }).join('');
        $('#orgMngrUserId').html(options).val(selectedUserId);
    }

    function saveOrganization() {
        var mode = $('#orgFormMode').val();
        var data = {
            deptId: $.trim($('#orgDeptId').val()).toUpperCase(),
            deptNm: $.trim($('#orgDeptNm').val()),
            deptSeCd: $('#orgDeptSeCd').val(),
            upDeptId: $('#orgUpDeptId').val(),
            mngrUserId: $('#orgMngrUserId').val(),
            sortDeptSeq: $('#orgSortDeptSeq').val() || 0,
            deptExpln: $.trim($('#orgDeptExpln').val())
        };
        if (!/^[A-Z0-9-]{2,20}$/.test(data.deptId)) {
            showToast('조직 코드는 영문 대문자, 숫자, 하이픈 2~20자로 입력해 주세요.', true); $('#orgDeptId').focus(); return;
        }
        if (!data.deptNm) {
            showToast('조직명을 입력해 주세요.', true); $('#orgDeptNm').focus(); return;
        }
        $('#orgSaveBtn').prop('disabled', true);
        $.ajax({
            url: contextPath() + (mode === 'insert' ? '/dept/insertDept.ajax' : '/dept/updateDept.ajax'),
            type: 'POST', dataType: 'json', data: data,
            success: function (response) {
                if (response.result !== 'OK') { showToast(response.msg || '조직 저장에 실패했습니다.', true); return; }
                closeModal();
                showToast(mode === 'insert' ? '조직을 등록했습니다.' : '조직 정보를 수정했습니다.');
                loadOrganizationData(data.deptId);
            },
            error: function () { showToast('조직 저장 중 오류가 발생했습니다.', true); },
            complete: function () { $('#orgSaveBtn').prop('disabled', false); }
        });
    }

    function deleteOrganization(id) {
        var node = findOrganization(id);
        if (!node) return;
        if (childrenOf(id).length) { showToast('하위 조직이 있어 삭제할 수 없습니다. 먼저 하위 조직을 이동하거나 삭제해 주세요.', true); return; }
        if (node.memberCnt > 0) { showToast('소속 사용자가 있어 삭제할 수 없습니다. 먼저 다른 조직으로 이동해 주세요.', true); return; }
        if (!window.confirm(node.deptNm + ' 조직을 삭제하시겠습니까?')) return;
        $.ajax({
            url: contextPath() + '/dept/deleteDept.ajax', type: 'POST', dataType: 'json', data: { deptId: id },
            success: function (response) {
                if (response.result !== 'OK') { showToast(response.msg || '조직 삭제에 실패했습니다.', true); return; }
                selectedId = node.upDeptId || COMPANY_ID;
                showToast('조직을 삭제했습니다.');
                loadOrganizationData(selectedId);
            },
            error: function () { showToast('조직 삭제 중 오류가 발생했습니다.', true); }
        });
    }

    function openModal() {
        $('#orgEditModal').removeClass('hidden').attr('aria-hidden', 'false');
        window.setTimeout(function () { $('#orgDeptNm').focus(); }, 30);
    }

    function closeModal() {
        $('#orgEditModal').addClass('hidden').attr('aria-hidden', 'true');
        $('#orgDeptSeCd').prop('disabled', false);
    }

    function toggleAllTree() {
        var allOpen = organizations.every(function (item) { return expanded[item.deptId] !== false; }) && expanded[COMPANY_ID] !== false;
        expanded[COMPANY_ID] = !allOpen;
        organizations.forEach(function (item) { expanded[item.deptId] = !allOpen; });
        $('#orgExpandBtn').text(allOpen ? '전체 펼치기' : '전체 접기');
        renderTree();
    }

    function companyNode() {
        return { deptId: COMPANY_ID, deptNm: summaryValue('coNm') || '회사', deptSeCd: 'COMPANY', memberCnt: numberValue(summaryValue('memberCnt')), childCnt: childrenOf(COMPANY_ID).length };
    }

    function findOrganization(id) {
        for (var i = 0; i < organizations.length; i++) if (organizations[i].deptId === id) return organizations[i];
        return null;
    }

    function childrenOf(parentId) {
        return organizations.filter(function (item) {
            return parentId === COMPANY_ID ? !item.upDeptId : item.upDeptId === parentId;
        }).sort(compareOrganizations);
    }

    function compareOrganizations(a, b) {
        var seq = numberValue(a.sortDeptSeq) - numberValue(b.sortDeptSeq);
        return seq || String(a.deptNm || '').localeCompare(String(b.deptNm || ''), 'ko');
    }

    function allowedChildTypes(parentType) {
        if (parentType === 'COMPANY') return ['HQ', 'DEPT'];
        if (parentType === 'HQ') return ['DEPT'];
        if (parentType === 'DEPT') return ['TEAM'];
        return [];
    }

    function organizationPath(node) {
        var names = [];
        var current = node;
        var guard = 0;
        while (current && guard++ < 10) {
            names.unshift(current.deptNm);
            if (current.deptSeCd === 'COMPANY') break;
            current = current.upDeptId ? findOrganization(current.upDeptId) : companyNode();
        }
        return names.join(' > ');
    }

    function summaryValue(key) {
        if (summary[key] != null) return summary[key];
        var upper = key.toUpperCase();
        if (summary[upper] != null) return summary[upper];
        return null;
    }

    function numberValue(value) { var n = Number(value); return isNaN(n) ? 0 : n; }
    function html(value) { return String(value == null ? '' : value).replace(/[&<>"']/g, function (c) { return ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[c]; }); }
    function attr(value) { return html(value); }
    function cssEscape(value) { return String(value || '').replace(/(["\\])/g, '\\$1'); }

    function showToast(message, error) {
        var toast = $('#orgToast');
        toast.toggleClass('is-error', !!error).find('span').text(message);
        toast.addClass('is-show');
        window.clearTimeout(toastTimer);
        toastTimer = window.setTimeout(function () { toast.removeClass('is-show'); }, 3600);
    }
})(window, window.jQuery);
