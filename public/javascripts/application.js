$(document).ready(function() {
	$("a.wizardFormSwitch").click(function() {
		$(this).nextAll("div").children("div").children("form").slideToggle();
	});
	
	$("a.recordFormSwitch").click(function() {
		$(this).parent().parent().parent().children("div.details, form").slideToggle();
	});
	
	$("#day_date_from").datepicker({ dateFormat: "yy-mm-dd" });
	$("#day_date_to").datepicker({ dateFormat: "yy-mm-dd" });
});

dojo.require("dijit.form.TimeTextBox");
dojo.require("dijit.form.Button");
dojo.require("dijit.Menu");
dojo.addOnLoad(function() {
  var menu = new dijit.Menu({ style: "display: none;" });
  var menuItem1 = new dijit.MenuItem({
    label: "German",
    iconClass: "dijitFlagGerman",
    onClick: function() { window.location.href = "/de/works"; }
  }); menu.addChild(menuItem1);

  var menuItem2 = new dijit.MenuItem({
      label: "English",
      iconClass: "dijitFlagEnglish",
      onClick: function() { window.location.href = "/en/works"; }
  }); menu.addChild(menuItem2);
  var button = new dijit.form.DropDownButton({ label: "Language", dropDown: menu });
  
  dojo.byId("dropdownButtonContainer").appendChild(button.domNode);
});