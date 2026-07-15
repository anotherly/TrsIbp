/**
 * 프로젝트 공통 jQuery DateTimePicker 초기화 모듈.
 * 날짜 필드는 yyyy-MM-dd, 날짜·시간 필드는 yyyy-MM-dd HH:mm 값을 유지한다.
 */
(function(window, $) {
    'use strict';

    var DATE_SELECTOR = '.ds-date-picker';
    var DATETIME_SELECTOR = '.ds-datetime-picker';

    /**
     * 선택한 입력 요소의 기존 DateTimePicker 인스턴스를 제거한다.
     * @param {jQuery|string|Element} target 입력 요소 또는 선택자
     * @returns {void}
     */
    function destroy(target) {
        $(target).each(function() {
            var $input = $(this);
            if ($input.data('xdsoft_datetimepicker')) {
                $input.datetimepicker('destroy');
            }
        });
    }

    /**
     * 날짜 또는 날짜·시간 입력 요소에 공통 DateTimePicker를 설정한다.
     * @param {jQuery|string|Element} target 입력 요소 또는 선택자
     * @param {Object=} options dateTime, step 및 DateTimePicker 추가 설정
     * @returns {void}
     */
    function configure(target, options) {
        if (!$.fn || typeof $.fn.datetimepicker !== 'function') {
            return;
        }
        options = options || {};
        var dateTime = options.dateTime === true;
        var pickerOptions = $.extend({}, {
            format: dateTime ? 'Y-m-d H:i' : 'Y-m-d',
            formatDate: 'Y-m-d',
            formatTime: 'H:i',
            datepicker: true,
            timepicker: dateTime,
            closeOnDateSelect: !dateTime,
            closeOnTimeSelect: dateTime,
            closeOnWithoutClick: true,
            dayOfWeekStart: 0,
            step: options.step || 1,
            scrollInput: false,
            scrollMonth: false,
            scrollTime: false,
            validateOnBlur: false
        }, options.pickerOptions || {});

        destroy(target);
        $(target).each(function() {
            $(this)
                .attr('type', 'text')
                .attr('readonly', 'readonly')
                .attr('autocomplete', 'off')
                .datetimepicker(pickerOptions);
        });
    }

    /**
     * 화면에 선언된 모든 공통 날짜 및 날짜·시간 입력 요소를 초기화한다.
     * 남아 있는 브라우저 기본 date/datetime-local 입력도 방어적으로 변환한다.
     * @param {Document|Element=} root 초기화 범위. 생략 시 document
     * @returns {void}
     */
    function initialize(root) {
        var $root = $(root || document);
        $root.find('input[type="date"]').addClass('ds-date-picker');
        $root.find('input[type="datetime-local"]').addClass('ds-datetime-picker');
        configure($root.find(DATE_SELECTOR), { dateTime: false });
        configure($root.find(DATETIME_SELECTOR), { dateTime: true });
    }

    /**
     * 선택한 입력 요소에 열려 있는 DateTimePicker를 닫는다.
     * @param {jQuery|string|Element} target 입력 요소 또는 선택자
     * @returns {void}
     */
    function hide(target) {
        if ($.fn && typeof $.fn.datetimepicker === 'function') {
            $(target).datetimepicker('hide');
        }
    }

    if ($.datetimepicker && typeof $.datetimepicker.setLocale === 'function') {
        $.datetimepicker.setLocale('ko');
    }

    window.DsDateTimePicker = {
        initialize: initialize,
        configure: configure,
        destroy: destroy,
        hide: hide
    };

    $(function() {
        initialize(document);
    });
})(window, jQuery);
