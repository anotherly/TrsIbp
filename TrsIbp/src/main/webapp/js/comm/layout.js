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
