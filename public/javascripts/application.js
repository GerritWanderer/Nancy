$(document).ready(function() {
	$("a.wizardFormSwitch").click(function() {
		$(this).nextAll("div").children("div").children("form").slideToggle();
	});
	
	$("a.recordFormSwitch").click(function() {
		$(this).parent().parent().parent().children("div.details, form").slideToggle();
	});
	
	$("#day_date_from").datepicker({ dateFormat: "yy-mm-dd" });
	$("#day_date_to").datepicker({ dateFormat: "yy-mm-dd" });
	
	$('dd.time input').timepicker({
    showPeriod: false,
    showPeriodLabels: false,
    hourText: 'Hour',
    minuteText: 'Minute'
  });
  
  $('select#language').selectmenu({
    icons: [ {find: '.flag'} ],
    change: function(e, object) { window.location.href = object.value; },
		bgImage: function() { return 'url(' + $(this).attr("data-flagicon") + ')'; }
	});
});