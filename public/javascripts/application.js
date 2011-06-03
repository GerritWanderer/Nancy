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

  $('input#work_started_at, input#work_ended_at').live('click', function() {
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
  
  $("#invoice_started_at").datepicker({
    dateFormat: "yy-mm-dd",
    minDate: new Date($('input#invoice_started_at').val()),
    maxDate: new Date($('input#invoice_started_at').val())
  });
  $("#invoice_ended_at").datepicker({
    dateFormat: "yy-mm-dd",
    minDate: new Date($('input#invoice_started_at').val()),
    maxDate: new Date($('input#invoice_ended_at').val())
  });
  
  $("form li.field label").inFieldLabels();
  
  
  $(".actions.tipped img").mouseover(function() {
    alt = $(this).attr('alt');
    msg = '';
    if (alt == 'Container-open') { msg = 'Öffnen'; }
    else if (alt == 'Container-close') { msg = 'Schliessen'; }
    else if (alt == 'Edit') { msg = 'Bearbeiten'; }
    else if (alt == 'Delete') { msg = 'Löschen'; }
    else if (alt == 'Invoice-flag') { msg = 'Abrechnung offen'; }
    else if (alt == 'Project-report') { msg = 'HTML-Report'; }
    else if (alt == 'Project-pdf') { msg = 'PDF-Report'; }
    else if (alt == 'Mail') { msg = 'E-Mail verfassen'; }
    else if (alt == 'Contact-create') { msg = 'Ansprechpartner erstellen'; }
    else if (alt == 'Expense-create') { msg = 'Auslage erstellen'; }
    else if (alt == 'Location-create') { msg = 'Standort erstellen'; }
    else if (alt == 'Statusmessage-create') { msg = 'Statusmeldung erstellen'; }
    else if (alt == 'Project-close') { msg = 'Projekt abschliessen'; }
    else if (alt == 'Project-inactive') { msg = 'Projekt nicht abschliessbar'; }
    else if (alt == 'Project-open') { msg = 'Projekt aktivieren'; }
    if (msg != '') { Tipped.show($(this).parents('.actions.tipped').attr('data-tipped', msg)); }
  });
  $("form li.field.tipped *").mouseover(function() {
    if ($(this).is('.right')) {
      if ($(this).parents('.field.tipped').is('.half')) { options = "skin: 'blackFormHalfRight'"; }
      else if ($(this).parents('.field.tipped').is('.third')) { options = "skin: 'blackFormThirdRight'"; }
    } else {
      options = "skin: 'blackForm'";
    }
    Tipped.show($(this).parents('.field.tipped').attr('data-tipped-options', options).attr('data-tipped', $(this).attr('title')));
  });
});