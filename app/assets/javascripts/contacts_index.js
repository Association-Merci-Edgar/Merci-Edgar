
$( "#final_submit" ).click(function() {
  $('.filters-hiddenform form').submit();
});


$hid = $('.filters-hiddenform');
$hid.find("input").val("");

$iniBTNS = $("#filters_btns");
$iniBT = $('.filters-stage [data-role="close"]');
$iniBTNS.hide();

// RE-INITIALIZE
$iniBT.click(function() {
  $('.filters-stage .tag-actor').remove();
  $hid.find("input").val("");
  $hid.find("#venue_kind").get(0).selectedIndex = 0;
  $iniBTNS.hide();
});

hideTheInit = function(){
  if ( $('.filters-stage .tag-actor').length == 0  ) {    // check if the div is absent
    $iniBTNS.hide();
  }
}


//___________________________________________________ popovers
var tmp = $.fn.popover.Constructor.prototype.show;
$.fn.popover.Constructor.prototype.show = function () {
  tmp.call(this); if (this.options.callback) { this.options.callback();
    }
};

$('.filters-pool .tag').popover({callback: function() {
  //$(".popover-content").find("input").focus();
  $(".popover-content input[autofocus]:first").focus();
  //$('.popover').previousSibling.addClass('active'); // access to the trigger element
  $('.popover').prev().addClass('active');
  
  $('.popover').find(".btn[type='submit']").click(function () {
    $('.popover').prev().removeClass('active');
    //___________________________________________________ actions on click on the OK button here :
    //some AJAX here ??
    $('.popover').each(function(){
        //alert ( $(this.previousSibling).html() ); 
        //$theFiltervalue = $(this).find("input").val();
        $(this.previousSibling).popover('hide');
    });
    
    //___________________________________________________ actions on click on the tag-actor here : ( = remove a filter)
    //some AJAX here ??
    
  });
  
  },
  placement:"bottom", animation: false
});

//$('#f_type').popover({placement:"bottom"});
//$('#f_style').popover();
/* Boostrap V3 ....
$(".popover").on('shown.bs.popover', function () {
  alert ("g");
  $(this).find("[autofocus]:first").focus();
});
*/



function filtergo_sel(theform) {
	// Traiter les éléments du formulaire
	//$thef=theform;//alert ($thef);
	//thes = theform["f_venue_kind"]
	thevalue = theform["f_venue_kind"].value;
	//thevalue = $("#theselect").val();
	
  //theText = $("#theselect option:selected").html();
  theText = thevalue
  //thes.find('option:selected').text();
  //theText = $('#theselect:selected').text();
  //alert(  thes)
  
  //theText = theform["f_venue_kind "]
	thetargetname = "venue_kind";//$("#theselect").attr('name').substr(2);
	//alert (thevalue)
	if (thevalue != "") {
	  theactor = $('.filters-stage').find("#actor_"+ thetargetname);
	  
	  if ( theactor.length != 0  ) {    // check if the div exists
	    $("#actor_"+ thetargetname).remove();
    }
    $('.filters-stage').append( "<a class='tag tag-actor' id = actor_"+ thetargetname +" href='#'><span class='close'>x</span><span class='thevalue'>"+ theText +"</span></a>" );
    
    
    $iniBT.show();
    //.val(thevalue);
    $hid.find("#"+ thetargetname +" option[value='"+thevalue+"']").attr('selected','selected');
  }
  
  
  $('.filters-stage .tag-actor').click(function() { 
    $(this).remove();
    //$hid.find("#"+thetargetname).val("");
    $hid.find("#"+ thetargetname).get(0).selectedIndex = 0;
    hideTheInit();
  });

}


function filtergo_cap(theform) {
  min = theform["capacity_lt"].value;
  max = theform["capacity_gt"].value;
  
  if ( (min != "") || (max != "")) {
    
    if ( $("#actor_cap").length != 0  ) {    // check if the div exists
      $("#actor_cap").remove();
      $hid.find("#capacity_lt").val("");
      $hid.find("#capacity_gt").val("");
    }
    
    thevalue="";
    sep="";
    if (min != "") { thevalue = "min. "+min;
      $hid.find("#capacity_lt").val(min);
      }
      
    if ((min != "") && (max != "")) { sep = " / ";}
    
    if (max != "") { thevalue += sep+"max. "+max;
      $hid.find("#capacity_gt").val(max);
      }
      
    $('.filters-stage').append( "<a class='tag tag-actor' id = 'actor_cap' href='#'><span class='close'>x</span><span class='thevalue'>"+ thevalue +" places</span></a>" );
    $iniBTNS.show();
  }
  
  $("#actor_cap").click(function() { 
    $(this).remove();
    $hid.find("#capacity_lt").val("");
    $hid.find("#capacity_gt").val("");
    hideTheInit();
  });
  
}


function filtergo(theform) {
	// Traiter les éléments du formulaire
	thevalue = theform["thefield"].value;
	thetargetname = theform["thefield"].id.substr(2);
	
	
	if (thevalue != "") {
	  theactor = $('.filters-stage').find("#actor_"+ thetargetname);
	  //alert ( theactor );
	  //alert ( theactor.length != 0 );
	  
	  if ( theactor.length != 0  ) {    // check if the div exists
	    //$("#actor_"+ thetargetname).remove();
	    //alert (theactor.find(".thevalue").text());
	    theactor.find(".thevalue").append(", " + thevalue);
	    thevalue = theactor.find(".thevalue").text();
    } else {
      $('.filters-stage').append( "<a class='tag tag-actor' id = actor_"+ thetargetname +" href='#'><span class='close'>x</span><span class='thevalue'>"+ thevalue +"</span></a>" );
    };
    
    $iniBTNS.show();
    $hid.find("#"+ thetargetname).val(thevalue);
  }
  
  
  $('.filters-stage .tag-actor').click(function() { 
    thetargetname = $(this).attr( "id").substr(6);
    //alert (thetargetname);
    $(this).remove();
    $hid.find("#"+thetargetname).val("");
    hideTheInit();
  });
	
	//alert ($('.filters-hiddenform').find("#"+thetarget).id);
	/*if(theform.name != "")
		return true;
	else
		return false;*/
}


$('html').on('mouseup', function(e) {
    if(!$(e.target).closest('.popover').length) {
        $('.popover').each(function(){
            $(this.previousSibling).popover('hide');
        });
        $('.filters-pool .tag').removeClass('active');
    }
});



//___________________________________________________ heigh auto animation

//$('.filters-pool .tag').click(function() {  $(".dd").hide();}
/*
$(".filters-trigger").click(function () {
  
  $(".filters-outercontainer").toggle(function(){
	  var el = $(".filters-outercontainer"),
          curHeight = el.height(),
          autoHeight = el.css('height', 'auto').height(); //temporarily change to auto and get the height.

          el.height(curHeight).animate({ height: autoHeight }, 600, function() {
               //Now, change the height to auto when animation finishes. 
               //Added to make the container flexible (Optional).
               el.css('height', 'auto'); 
          });
       
  }     ,function(){
     $(this).animate({height:0},200);
     
    });
  });
  */
  
  //$(".filters-outercontainer").css("height", 0);
  
$.each($('.filters-trigger'), function() {      
  $(this).click(function () {
    
  	  $(this).toggleClass("active");
  		$('.filters-outercontainer').toggleClass("open");
  		/*$(".filters-outercontainer").toggle(function(){

           $(this).css("height", "auto");
            theH = $(this).height;
            $(this).animate({height:theH},200);
        },function(){


         $(this).animate({height:0},200);

        });*/

  		//$(".filters-outercontainer").animate({height:'toggle'});

  	});
  	
});
  	 //$(this).slideDown(2000);
  	//$(this).slideUp(2000);


  	//alert ("yo");
