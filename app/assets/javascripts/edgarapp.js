$('document').ready(function() {
  
  initializer();
  
  $('[data-toggle="tooltip"]').tooltip(); 	      // activate tooltips
  //$(".editbtn").tooltip({html:true});   
  
  $("a.btn-close").click(function(event) { 	      // hide Notices
    event.preventDefault();
    $(this).parent('.notice').remove();
  });
  
  /*
  Gmaps.map.callback = function() {
  google.maps.event.addListenerOnce(Gmaps.map.serviceObject, 'idle', function(){
  //Map fully loaded here
  $('#map').height($(".map_container").height());
  $('#map').width($(".map_container").width());
  google.maps.event.trigger($('#map'), 'resize');
  
  }
  )};
  */
  
// show/hide the leftpanel _________________________________
  window.smallScreens = function() {
    $('.leftpanel').removeClass( "collapsed");
		$('.mainpanel').removeClass( "goleft");
    $('.leftpanel').removeClass( "small");
		$('.mainpanel').removeClass( "goleftsmall");
		
    if ($(window).width() <= 767) {
			$('.leftpanel').addClass( "collapsed");
			$('.mainpanel').addClass( "goleft");
		} else if ($(window).width() <= 1024) {
  			$('.leftpanel').addClass( "small");
  			$('.mainpanel').addClass( "goleftsmall");
		} else if ($(window).width() > 1024) {
		}	
	}
  
	$('.leftpanel.collapsed').animate();
	$('.leftpanel:not(.collapsed)').animate();

	$("#nav_toggle").click(function () {
    /*$(".leftpanel").toggle("slow");*/
		$('.leftpanel').toggleClass( "collapsed");
		$('.mainpanel').toggleClass( "goleft");
	});
	
	//alert ("yo");
	smallScreens();
})



$(window).load(function() {
	smallScreens();
	
	
  
  
});

$(window).resize(function() {
	smallScreens();
	initializer();

});


//  _________________________________ Clickable Dropdown
clickerShow = function(e) {
  $('.click-nav .js ul').slideToggle(200);
	$('.clicker').toggleClass('active');
	e.stopPropagation();
}

clickerHide = function() {
}

$(function() {
      $('.clicker').click(function(event) { event.preventDefault();});
			$('.click-nav > .ul').toggleClass('no-js js');
			$('.click-nav .js ul').hide();
			
			$('.click-nav .js').click(function(e) {
				clickerShow(e);
			});
			
			$(document).click(function() {
			  //clickerHide();
			  if ($('.click-nav .js ul').is(':visible')) {
      		$('.click-nav .js ul', this).slideUp(0);
      		$('.clicker').removeClass('active');
      	}	
			});
});



//  _________________________________ Hide Notices 
$(function() {
  $div = $('.notice:not(.error)')
  if ($div.get(0)) {    // check if the div exists
    setTimeout(function(){$div.fadeOut();}, 7000);
  }
});



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



initializer = function() {
  //$(".leftpanel").height( $(document).height() ); // Fix the leftmenu height on scroll
  $(".modal").on('shown', function() {
          $(this).find("[autofocus]:first").focus();
  });
  
  $("#gmaps_index").width( $("#markers_list").width() )
  $("#markers_list").height( $(document).height() - 210 - $("#gmaps_index").height() )

  //______________ phone 
  $.each($('.venue_phones_national_number .input-append'), function() {
      specificKind($(this));
  });
  $.each($('.venue_emails_address .input-append'), function() {
      specificKind($(this));
  });
  
}


$(document).on('nested:fieldAdded', function(event){
  // this field was just inserted into your form
  var field = event.field;
  
  var spep = field.find(".venue_phones_national_number .input-append");
  var spem = field.find(".venue_emails_address .input-append");
  //alert (spem.width());
  if (spep.width() != null){spe=spep};
  if (spem.width() != null){spe=spem};
  
  specificKind(spe);
});


