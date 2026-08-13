/**
 * 공통 레이아웃 JavaScript
 * - 업무화면 공통 메뉴/헤더에서 사용하는 기능을 제공한다.
 */

/**
 * 사이드바 하위 메뉴를 펼치거나 접는다.
 * @param {string} id 토글할 하위 메뉴 DOM id
 * @returns 없음
 */
function toggleSubmenu(id) {
    var submenu = document.getElementById(id);
    var arrow = document.getElementById('arrow-' + id);

    if (!submenu) {
        return;
    }

    submenu.classList.toggle('hidden');

    if (arrow) {
        arrow.classList.toggle('fa-chevron-down');
        arrow.classList.toggle('fa-chevron-up');
        arrow.classList.toggle('text-gray-500');
        arrow.classList.toggle('text-cyan-400');
    }
}

/**
 * 헤더 업무공간 전환 메뉴를 바깥 영역 클릭 또는 ESC 입력 시 닫는다.
 */
(function initWorkspaceSwitcher() {
    document.addEventListener('click', function(event) {
        var switcher = document.querySelector('.ds-workspace-switcher[open]');
        if (switcher && !switcher.contains(event.target)) {
            switcher.removeAttribute('open');
        }
    });

    document.addEventListener('keydown', function(event) {
        if (event.key !== 'Escape') {
            return;
        }
        var switcher = document.querySelector('.ds-workspace-switcher[open]');
        if (switcher) {
            switcher.removeAttribute('open');
            var summary = switcher.querySelector('summary');
            if (summary) {
                summary.focus();
            }
        }
    });
})();

/**
 * 현재 화면의 업무공간을 로그인 사용자의 기본값으로 저장한다.
 */
function setDefaultWorkspace(workspace) {
    var contextPath = typeof window.dsContextPath === 'string'
        ? window.dsContextPath
        : (typeof ctxPath !== 'undefined' ? ctxPath : '');
    jQuery.ajax({
        url: contextPath + '/main/defaultWorkspace.ajax',
        type: 'POST',
        dataType: 'json',
        data: { workspace: workspace }
    }).done(function(data) {
        if (data.result === 'OK') {
            window.location.reload();
            return;
        }
        window.alert(data.msg || '기본 업무공간을 저장하지 못했습니다.');
    }).fail(function(xhr) {
        var message = xhr.responseJSON && xhr.responseJSON.msg
            ? xhr.responseJSON.msg : '기본 업무공간 저장 중 통신 오류가 발생했습니다.';
        window.alert(message);
    });
}

/**
 * 기존 데이터에 한 번 이상 HTML entity로 저장된 일반 텍스트를 원문으로 복원한다.
 * 반환값은 반드시 textContent, value 또는 HTML escape를 거쳐 화면에 출력해야 한다.
 * @param {*} value 저장된 일반 텍스트
 * @returns {string} 최대 세 단계까지 entity를 해제한 텍스트
 */
window.decodeStoredText = function(value) {
    var decoded = value == null ? '' : String(value);
    var encodedEntityPattern = /&(?:amp;)*(?:amp|lt|gt|quot|apos|#39|#x27);/i;

    for (var i = 0; i < 3 && encodedEntityPattern.test(decoded); i++) {
        var decoder = document.createElement('textarea');
        decoder.innerHTML = decoded;
        var nextValue = decoder.value;
        if (nextValue === decoded) {
            break;
        }
        decoded = nextValue;
    }
    return decoded;
};

/** maxlength가 지정된 textarea에 공통 글자 수 표시를 붙인다. */
(function initTextareaCounters() {
    function findFieldLabel(textarea) {
        var container = textarea.closest
            ? textarea.closest('.ds-field, .ds-form-row')
            : textarea.parentElement;
        return container ? container.querySelector('label') : null;
    }

    function updateTextareaCounter(textarea) {
        if (!textarea || textarea.tagName !== 'TEXTAREA') {
            return;
        }
        var maxLength = parseInt(textarea.getAttribute('maxlength'), 10);
        if (!maxLength || maxLength < 1) {
            return;
        }

        var label = findFieldLabel(textarea);
        if (!label) {
            return;
        }
        var counter = label.querySelector('.ds-textarea-counter');
        if (!counter) {
            counter = document.createElement('span');
            counter.className = 'ds-textarea-counter';
            counter.setAttribute('aria-live', 'polite');
            label.classList.add('ds-textarea-label-row');
            label.appendChild(counter);
        }
        counter.textContent = textarea.value.length + '/' + maxLength + '자';
    }

    function refreshTextareaCounters() {
        var textareas = document.querySelectorAll('textarea[maxlength]');
        Array.prototype.forEach.call(textareas, updateTextareaCounter);
    }

    window.refreshTextareaCounters = refreshTextareaCounters;
    document.addEventListener('DOMContentLoaded', refreshTextareaCounters);
    document.addEventListener('input', function(event) {
        updateTextareaCounter(event.target);
    });
    document.addEventListener('change', function(event) {
        updateTextareaCounter(event.target);
    });
    document.addEventListener('click', function() {
        window.setTimeout(refreshTextareaCounters, 0);
    });

    if (window.jQuery) {
        window.jQuery(document).ajaxComplete(refreshTextareaCounters);
    }
})();
