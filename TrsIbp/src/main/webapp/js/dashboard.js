/** DevSync dashboard interactions: KPI drill-down, work calendar focus and compact dashboard utilities. */
(function(window, $) {
    'use strict';

    var dashboardDetailRequest = null;

    function esc(value) {
        return String(value == null ? '' : value)
            .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;').replace(/'/g, '&#39;');
    }

    function decode(value) {
        if (window.decodeStoredText) return window.decodeStoredText(value == null ? '' : value);
        return value == null ? '' : String(value);
    }

    function markActiveKpi($card) {
        $('.ds-kpi-clickable').removeClass('is-selected');
        if ($card && $card.length) $card.addClass('is-selected');
    }

    function detailPanel() {
        return $('#dashboardSummaryDetail');
    }

    function renderDetailRows(list) {
        if (!list || !list.length) {
            return '<div class="ds-empty">해당 조건의 상세 항목이 없습니다.</div>';
        }
        return '<div class="ds-summary-detail-list">' + list.map(function(item) {
            var title = esc(decode(item.title || '-'));
            var subTitle = esc(decode(item.subTitle || ''));
            var meta = esc(decode(item.meta || ''));
            var badge = esc(decode(item.badge || ''));
            var actionType = String(item.actionType || '');
            var content = '<div class="ds-summary-detail-copy"><strong>' + title + '</strong>'
                + (subTitle ? '<small>' + subTitle + '</small>' : '')
                + (meta ? '<span>' + meta + '</span>' : '') + '</div>'
                + (badge ? '<em class="ds-dashboard-badge">' + badge + '</em>' : '')
                + '<i class="fa-solid fa-chevron-right ds-summary-detail-arrow"></i>';
            if (actionType === 'SCHEDULE') {
                return '<button type="button" class="ds-summary-detail-row" onclick="focusDashboardSchedule(\''
                    + esc(item.actionDate || '') + '\',\'my\',\'' + esc(item.actionValue || item.itemId || '') + '\');">' + content + '</button>';
            }
            var href = item.href ? (window.ctxPath || '') + item.href : '#';
            return '<a class="ds-summary-detail-row" href="' + esc(href) + '">' + content + '</a>';
        }).join('') + '</div>';
    }

    /* 프로젝트 대시보드의 투입인력은 행(사람 x 사업)이 아닌 사람 단위로 묶어서 노출한다.
       같은 사람의 동일 프로젝트가 복수 투입정보로 저장돼 있어도 한 번만 표시한다. */
    function renderGroupedManpower(list) {
        if (!list || !list.length) {
            return '<div class="ds-empty">현재 등록된 투입인력이 없습니다.</div>';
        }
        var groups = [];
        var byPerson = Object.create(null);
        list.forEach(function(item) {
            var personKey = String(item.personKey || item.itemId || item.title || '');
            var group = byPerson[personKey];
            if (!group) {
                group = { title: item.title || '외부인력', badge: item.badge || '', projects: [], byProject: Object.create(null) };
                byPerson[personKey] = group;
                groups.push(group);
            }
            if (item.badge === '본인') group.badge = '본인';
            var projectKey = String(item.projectId || item.href || item.subTitle || '');
            var project = group.byProject[projectKey];
            if (!project) {
                project = { title: item.subTitle || '-', href: item.href || '/biz/mnpwList.do', metaList: [] };
                group.byProject[projectKey] = project;
                group.projects.push(project);
            }
            var meta = String(item.meta || '');
            if (meta && project.metaList.indexOf(meta) === -1) project.metaList.push(meta);
        });
        return '<div class="ds-summary-person-grid">' + groups.map(function(group) {
            var projects = group.projects.map(function(project) {
                var href = (window.ctxPath || '') + project.href;
                return '<a class="ds-summary-person-project" href="' + esc(href) + '">'
                    + '<span class="ds-summary-person-project-copy"><strong>' + esc(decode(project.title)) + '</strong>'
                    + (project.metaList.length ? '<small>' + project.metaList.map(function(meta) { return esc(decode(meta)); }).join(' / ') + '</small>' : '')
                    + '</span><i class="fa-solid fa-chevron-right" aria-hidden="true"></i></a>';
            }).join('');
            return '<section class="ds-summary-person-card">'
                + '<div class="ds-summary-person-head"><div><strong>' + esc(decode(group.title)) + '</strong>'
                + '<small> · ' + group.projects.length + '개 프로젝트</small></div>'
                + (group.badge === '본인' ? '<span class="ds-dashboard-badge">본인</span>' : '') + '</div>'
                + '<div class="ds-summary-person-projects">' + projects + '</div></section>';
        }).join('') + '</div>';
    }

    window.openDashboardSummaryDetail = function(workspace, detailType, card, title) {
        var $panel = detailPanel();
        if (!$panel.length) return;
        markActiveKpi($(card));
        $panel.removeClass('hidden').html('<div class="ds-summary-detail-head"><div><span>요약 상세</span><strong>'
            + esc(title || '상세 항목') + '</strong></div><button type="button" class="ds-icon-btn" onclick="closeDashboardSummaryDetail();" title="닫기"><i class="fa-solid fa-xmark"></i></button></div>'
            + '<div class="ds-summary-detail-loading"><i class="fa-solid fa-spinner fa-spin"></i> 상세 항목을 불러오는 중입니다.</div>');

        if (dashboardDetailRequest && dashboardDetailRequest.readyState !== 4) dashboardDetailRequest.abort();
        dashboardDetailRequest = $.ajax({
            url: (window.ctxPath || '') + '/main/dashboardDetail.ajax',
            type: 'GET',
            dataType: 'json',
            data: { workspace: workspace, detailType: detailType },
            success: function(res) {
                if (!res || res.result !== 'OK') {
                    $panel.find('.ds-summary-detail-loading').replaceWith('<div class="ds-empty">' + esc((res && res.msg) || '상세 항목을 조회하지 못했습니다.') + '</div>');
                    return;
                }
                $panel.find('.ds-summary-detail-loading').replaceWith(
                    workspace === 'project' && detailType === 'inputMnpw'
                        ? renderGroupedManpower(res.list || [])
                        : renderDetailRows(res.list || []));
            },
            error: function(xhr, status) {
                if (status === 'abort') return;
                $panel.find('.ds-summary-detail-loading').replaceWith('<div class="ds-empty">상세 항목 조회 중 오류가 발생했습니다.</div>');
            }
        });
        var panel = $panel.get(0);
        if (panel) setTimeout(function(){ panel.scrollIntoView({behavior:'smooth', block:'nearest'}); }, 50);
    };

    window.closeDashboardSummaryDetail = function() {
        $('.ds-kpi-clickable').removeClass('is-selected');
        detailPanel().addClass('hidden').empty();
    };

    window.focusWorkTodaySchedule = function(card) {
        openDashboardSummaryDetail('work', 'todaySchedule', card || $('.ds-dashboard-kpis .ds-kpi-clickable').first(), '오늘 내 일정');
        var now = new Date();
        var ymd = now.getFullYear() + '-' + String(now.getMonth() + 1).padStart(2, '0') + '-' + String(now.getDate()).padStart(2, '0');
        if (typeof window.focusDashboardSchedule === 'function') {
            window.focusDashboardSchedule(ymd, 'my', '');
        }
    };

    $(function() {
        $(document).on('keydown', '.ds-kpi-clickable[role="button"]', function(e) {
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                this.click();
            }
        });
    });
})(window, jQuery);
