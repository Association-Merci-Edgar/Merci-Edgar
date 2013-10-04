//  _________________________________ specificKind Fields 
specificKind = function(obj) { 
  var $thefield= obj.find(".other");
  var $thesel= obj.find("select");
  //$thefield.css("background-color", "green");
    
  var $othersOption = $thesel.find('option:selected');
  if ($othersOption.val() != "other"){
      $thefield.hide(); //initially hide the textbox
  }
  
  $thesel.change(function() {
    if ($(this).find('option:selected').val() == "other"){
      $thefield.show();
    } else {
      $thefield.val("");
      $thefield.hide();
    }
  });
  
  /*$thefield.keyup(function(ev){
        var $othersOption = $thesel.find('option:selected');
        if ($othersOption.val() == "other"){
          ev.preventDefault();
          //change the selected drop down text
          $(othersOption).html($thefield.val());
        }
  });*/
  
}
$(".ui-autocomplete").addClass("dropdown-menu");


//______________ phone 
$.each($('.person_phones_national_number .input-append'), function() {      specificKind($(this)); });
$.each($('.person_emails_address .input-append'), function() {      specificKind($(this)); });
$.each($('.venue_phones_national_number .input-append'), function() {      specificKind($(this)); });
$.each($('.venue_emails_address .input-append'), function() {    specificKind($(this));  });

$(document).on('nested:fieldAdded', function(event){
  // this field was just inserted into your form
  var field = event.field;
  var spe = field.find(".control-group .input-append");
  //var spem = field.find(".venue_emails_address .input-append");
  //alert (spem.width());
  if (spe.width() != null){specificKind(spe);};

});
