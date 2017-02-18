/* Turkish initialisation for the jQuery UI date picker plugin. */
 
/* Written by Izzet Emre Erkan (kara@karalamalar.net). */
 
(function($) {
 
        $.ui.datepicker.regional['tr'] = {
 
                renderer: $.ui.datepicker.defaultRenderer,
 
                monthNames: ['Ocak','�ubat','Mart','Nisan','May�s','Haziran',
 
                'Temmuz','A�ustos','Eyl�l','Ekim','Kas�m','Aral�k'],
 
                monthNamesShort: ['Oca','�ub','Mar','Nis','May','Haz',
 
                'Tem','A�u','Eyl','Eki','Kas','Ara'],
 
                dayNames: ['Pazar','Pazartesi','Sal�','�ar�amba','Per�embe','Cuma','Cumartesi'],
 
                dayNamesShort: ['Pz','Pt','Sa','�a','Pe','Cu','Ct'],
 
                dayNamesMin: ['Pz','Pt','Sa','�a','Pe','Cu','Ct'],
 
                dateFormat: 'dd.mm.yyyy',
 
                firstDay: 1,
 
                prevText: '&#x3c;geri', prevStatus: '',
 
                prevJumpText: '&#x3c;&#x3c;', prevJumpStatus: '',
 
                nextText: 'ileri&#x3e;', nextStatus: '',
 
                nextJumpText: '&#x3e;&#x3e;', nextJumpStatus: '',
 
                currentText: 'bug�n', currentStatus: '',
 
                todayText: 'bug�n', todayStatus: '',
 
                clearText: '-', clearStatus: '',
 
                closeText: 'kapat', closeStatus: '',
 
                yearStatus: '', monthStatus: '',
 
                weekText: 'Hf', weekStatus: '',
 
                dayStatus: 'DD d MM',
 
                defaultStatus: '',
 
                isRTL: false
 
        };
 
        $.extend($.ui.datepicker.defaults, $.ui.datepicker.regional['tr']);
 
})(jQuery);
 
