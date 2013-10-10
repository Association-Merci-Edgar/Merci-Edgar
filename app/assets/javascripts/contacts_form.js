//  _________________________________ specificKind Fields 
$.fn.specificKind = function() { 
  var $thefield= $(this).find(".other");
  var $thesel= $(this).find("select");
  //console.log($thefield.val())
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
  
  /*
  $thefield.keyup(function(ev){
        var $othersOption = $thesel.find('option:selected');
        console.log( $othersOption.val() );
        
        if ($othersOption.val() == "other"){
          ev.preventDefault();
          //change the selected drop down text
          $(othersOption).html($thefield.val());
        }
  });
  */

}
$('.maincontentinner').scrollspy({ target: '.subpage-nav' });
$('.subpage-nav').affix();
//$('.subpage-nav').scrollspy();
//$('.subpage-nav').affix( offset: { y: 200 } );

//______________ phone & emails
$.each($('.venue_phones_national_number .input-append'), function() { $(this).specificKind();  });
$.each($('.venue_emails_address .input-append'), function() {    $(this).specificKind();  });
$.each($('.person_phones_national_number .input-append'), function() {      $(this).specificKind(); });
$.each($('.person_emails_address .input-append'), function() {      $(this).specificKind(); });


//  _________________________________ specificKind Fields


//  _________________________________ Country & States
$.fn.checkState = function() {
  var $country= $(this).find(".country");
  var $state= $(this).find(".state");
  //console.log($country.val());
  //alert($country.val());
  if ($country.val() != "FR"){
    $state.removeClass("hidden");
  }
}
//  __________________________________________________________________ !!!! NOT TRIGGERED
$(".country").change(function() {
  if ($(this).val() != "FR"){
    $(this).parent().find(".state").removeClass("hidden");
  }
});

$.each($('.addresses'), function() {  $(this).checkState(); });


$(document).on('nested:fieldAdded', function(event){
  // this field was just inserted into your form
  var field = event.field;
  var spe = field.find(".control-group .input-append");
  //var spem = field.find(".venue_emails_address .input-append");
  //alert (spem.width());
  if (spe.width() != null){spe.specificKind();};

});








//_________________________________ Others Things

$(".ui-autocomplete").addClass("dropdown-menu");

$("#menu-vertical .btn-submit").click(function() {
  $( ".form-edit" ).submit();
});





//_________________________________ swipeable

//http://stackoverflow.com/questions/11408962/swipe-to-select-checkboxes-in-a-web-browser
//ALT : http://jsbin.com/ujugi/1/edi

$.fn.swipeable = function() {
  var mousedownOn = {
      id: '',
      checkState: false
  };

  $(document)
    .mouseup(function() {
        mousedownOn.id = '';
    });

  $(this)
      .mousedown(function() {
          //var $this = $(this);
          $target = $(this).find('input[type="checkbox"]');
          mousedownOn.id = $target.attr('id');
          mousedownOn.checkState = $target.prop('checked');
          $target.prop('checked',!$target.prop('checked'));
      })
    
      .mouseenter(function() {
          //var $this = $(this);
          $targett = $(this).find('input[type="checkbox"]');
          if (mousedownOn.id != '' && mousedownOn.id != $targett.attr('id')){
              $targett.prop('checked',!mousedownOn.checkState);
          }
      })
      .find('input[type="checkbox"]').click(function(e) {
        e.preventDefault(); return false;  })
      
      .find('label').click(function(e) {
        e.preventDefault(); return false;
      });
};

$('.swipeable span').swipeable();


