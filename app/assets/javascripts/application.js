// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//

//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap/tmp-fix-bootstrap-scrollspy
//= require bootstrap-datepicker/core
//= require vendors/select2/select2
//= require modal
//= require service_request
//= require filters_menu
//= require tables
//= require_self


$(document).ready(function() {
//    new Laboratory.Contracts({el: $("#contracts")});
    $.fn.datepicker.dates['cs'] = {
        days: ["Neděle", "Pondělí", "Úterý", "Středa", "Čtvrtek", "Pátek", "Sobota", "Neděle"],
        daysShort: ["Ned", "Pon", "Úte", "Stř", "Čtv", "Pát", "Sob", "Ned"],
        daysMin: ["Ne", "Po", "Út", "St", "Čt", "Pá", "So", "Ne"],
        months: ["Leden", "Únor", "Březen", "Duben", "Květen", "Červen", "Červenec", "Srpen", "Září", "Říjen", "Listopad", "Prosinec"],
        monthsShort: ["Led", "Úno", "Bře", "Dub", "Kvě", "Če", "Čer", "Srp", "Zář", "Říj", "Lis", "Pro"]
    };
    $('.datepicker').datepicker({
        format: 'dd.mm.yyyy',
        weekStart: 1,
        startDate: '2012-03-01',
        autoclose: true,
        language: 'cs'
    }).on('changeDate', function(ev){
            //alert(ev.date.valueOf());
        });

})
