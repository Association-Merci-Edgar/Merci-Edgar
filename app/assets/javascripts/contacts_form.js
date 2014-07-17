$(function() {
  if ($(".network_tags_input").length) {
	$(".network_tags_input").multivalues_autocomplete({json_url: $(".network_tags_input").data('autocomplete-source')})
  }
  if ($(".custom_tags_input").length) {
	$(".custom_tags_input" ).multivalues_autocomplete({json_url: $(".custom_tags_input").data('autocomplete-source')})
  }
  if ($(".style_tags_input").length) {
	$(".style_tags_input" ).multivalues_autocomplete({json_url: $(".style_tags_input").data('autocomplete-source')})
  }
});




$(document).on('nested:fieldAdded', function(event){
  // this field was just inserted into your form
  var field = event.field;
  var spe = field.find(".control-group .input-append");
  //var spem = field.find(".venue_emails_address .input-append");
  //alert (spem.width());
  if (spe.width() != null){spe.specificKind();};
  //$.each($('.input-append'), function() { $(this).specificKind();  });
  
  // trigger the autocomplete
	input = field.find('.style_tags_input');
  if (input.length) {
		input.multivalues_autocomplete({json_url: input.data('autocomplete-source')});
  }
  
	address_input = field.find('.street')
	console.log("address_input got: " + address_input)
	console.log("field: " + $(event.field))
	if (address_input.length) {
		console.log("setAddressPicker...")
		setAddressPicker(address_input)		
	}
});


//_________________________________ Others Things

$(".ui-autocomplete").addClass("dropdown-menu");

$("#menu-vertical .btn-submit").click(function() {
  $( ".form-edit" ).submit();
});



//$('html').smoothScroll(1000);

//$('#subnav').affix({ offset: 60});
$('#subnav').affix();
//$('.subpage-nav').affix( offset: { y: 200 } );

$('body').scrollspy({ target: '#subnav' }, { offset: 100} );
// overlap workaround :
offsetValue = 80;
$('body').data().scrollspy.options.offset = offsetValue;
// force scrollspy to recalculate the offsets to your targets
$('body').data().scrollspy.process();





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


//______________ phone & emails
$.each($('.input-append'), function() { $(this).specificKind();  });
/*$.each($('.venue_phones_national_number .input-append'), function() { $(this).specificKind();  });
$.each($('.venue_emails_address .input-append'), function() {    $(this).specificKind();  });
$.each($('.person_phones_national_number .input-append'), function() {      $(this).specificKind(); });
$.each($('.person_emails_address .input-append'), function() {      $(this).specificKind(); });
*/

/*
$(function() {
  $('a[href*=#]:not([href=#])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') 
        || location.hostname == this.hostname) {

      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top
        }, 1000);
        return false;
      }
    }
  });
});
*/




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

function get_cousin_id(parent, cousin_class) {
	id = parent.find(cousin_class).attr("id")
	if (id) {
		return "#" + id
	}
	else {
		return false
	}
}

function setAddressPicker(element) {
	address_input = $(element)
	fields_parent = address_input.parents('.nested-fields.addresses')

	latitude_input_id = get_cousin_id(fields_parent, ".latitude")
	longitude_input_id = get_cousin_id(fields_parent, ".longitude")
	city_input_id = get_cousin_id(fields_parent, ".city")
	postal_code_id = get_cousin_id(fields_parent, ".postal_code")

  var addresspicker = address_input.addresspicker({
    componentsFilter: 'country:FR',
		elements: {
      lat:      latitude_input_id,
      lng:      longitude_input_id,
      street_number: '#street_number',
      route: '#route',
      locality: city_input_id,
      country:  '#country',
      postal_code: postal_code_id
    }
	});
	
}
// Use of addresspicker
$(function() {
	addresses_input = $('.street').each(function(index,element){
	setAddressPicker(element)
		
	})
	
	function showCallback(geocodeResult, parsedGeocodeResult){
    console.log(JSON.stringify(parsedGeocodeResult, null, 4));
  }
});

