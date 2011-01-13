$(document).ready(function() {
	$("a.wizardFormSwitch").click(function() {
		$(this).nextAll("form").slideToggle();
	});
	
	$("a.recordFormSwitch").click(function() {
		$(this).parent().parent().parent().children("div.details, form").slideToggle();
	});
});