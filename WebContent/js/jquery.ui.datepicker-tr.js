/* Turkish initialisation for the jQuery UI date picker plugin. */
 
/* Written by Izzet Emre Erkan (kara@karalamalar.net). */
 
(function($) {
 
        $.ui.datepicker.regional['tr'] = {
 
                renderer: $.ui.datepicker.defaultRenderer,
 
                monthNames: ['Ocak','Þubat','Mart','Nisan','Mayýs','Haziran',
 
                'Temmuz','Aðustos','Eylül','Ekim','Kasým','Aralýk'],
 
                monthNamesShort: ['Oca','Þub','Mar','Nis','May','Haz',
 
                'Tem','Aðu','Eyl','Eki','Kas','Ara'],
 
                dayNames: ['Pazar','Pazartesi','Salý','Çarþamba','Perþembe','Cuma','Cumartesi'],
 
                dayNamesShort: ['Pz','Pt','Sa','Ça','Pe','Cu','Ct'],
 
                dayNamesMin: ['Pz','Pt','Sa','Ça','Pe','Cu','Ct'],
 
                dateFormat: 'dd.mm.yyyy',
 
                firstDay: 1,
 
                prevText: '&#x3c;geri', prevStatus: '',
 
                prevJumpText: '&#x3c;&#x3c;', prevJumpStatus: '',
 
                nextText: 'ileri&#x3e;', nextStatus: '',
 
                nextJumpText: '&#x3e;&#x3e;', nextJumpStatus: '',
 
                currentText: 'bugün', currentStatus: '',
 
                todayText: 'bugün', todayStatus: '',
 
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
 
