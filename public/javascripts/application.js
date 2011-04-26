$(document).ready(function() {
  // $("a.wizardFormSwitch").click(function() {
  //  $(this).nextAll("div").children("div").children("form").slideToggle();
  // });
  // 
  // $("a.recordFormSwitch").click(function() {
  //  $(this).parent().parent().parent().children("div.details, form").slideToggle();
  // });
  
	$('select#language').selectmenu({
    icons: [ {find: '.flag'} ],
    change: function(e, object) { window.location.href = object.value; },
		bgImage: function() { return 'url(' + $(this).attr("data-flagicon") + ')'; }
	});
	
	$('dd.time input').live('click', function() {
  	$(this).timepicker({
      showPeriod: false,
      showPeriodLabels: false,
      hourText: 'Hour',
      minuteText: 'Minute'
    }).timepicker('show');
  });
  
  $('li#calendarNavigation span').live('click', function() {
    $('li#calendarNavigation input.datepicker').datepicker({
  	  dateFormat: "yy-mm-dd",
  	  onSelect: function(dateText, inst) { window.location.href = window.location.pathname+"?date="+dateText; } 
  	}).datepicker('show');
	});
	
	$('a.lightbox').click(function() {
	  $.colorbox({href:$(this).attr('href')});
	  return false;
	});
  
	$("#day_date_from").datepicker({ dateFormat: "yy-mm-dd" });
	$("#day_date_to").datepicker({ dateFormat: "yy-mm-dd" });
});