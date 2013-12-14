
var $hid = $('#filters-hiddenform');
//$hid.find("input").val("");

$('#final_submit').click(function() {
  $hid.submit();
});

$( "#final_submit_map" ).click(function() {
  $hid.find( "input:last" ).trigger( "click" );
});

function openFilters(){
  $('.filters-trigger').toggleClass("active");
  $('.filters-outercontainer').toggleClass("open");
}
  
$('.filters-trigger').click(function () {
    openFilters();
});


$iniBTNS = $("#filters_btns");
$iniBT = $('.filters-stage [data-role="close"]');
$iniBTNS.hide();



actorsInit = function(){
  var $r=$hid.find("input:not([type='hidden'])");
  //console.log($r.length);
  var $gotfilters = false;
  var $filtersArray =[];
  //if (r.length != 0) {
  
    //for (i=1; i<=$r.length; i++) {
    $r.each(function(){
      var $f = $(this);
      //f= $r[i];
      
      if (($f.val() !="") && ($f.val() != "show map")) {
        $gotfilters = true;
        var $thetargetname = $f.attr('id');
        //console.log($thetargetname)
        var $theText = $f.data("text");
				if (!$theText) { $theText = $f.val() }
				
        var $theTagClass = $f.attr('class');
        $filtersArray.push($theTagClass);
        //console.log("1: "+$filtersArray);
        
        $('.filters-stage').append( "<a class='tag "+ $theTagClass +" tag-actor active' id = actor_"+ $thetargetname +" href='#'><span class='close'>x</span><span class='thevalue'>"+ $theText +"</span></a>" );
      }
    }
    );
  
    if ($gotfilters) {
      openFilters();
      $iniBTNS.show();
      
      //_______________activated the tags in the list-large
      /*
      for (i=0; i<=$filtersArray.length-1; i++) {
        var $t = $filtersArray[i];
        console.log("t : "+$t);
        var $ta = $("#contact-list").find("."+$t).addClass("active")
        if ()
        console.log("tt : "+$("#contact-list").find("."+$t).text());
      }
      */
      
      $('.filters-stage').find('.tag-actor').click(function() {
        var $thetargetname = $(this).attr( "id").substr(6);
        $(this).remove();
        $hid.find("#"+ $thetargetname).val("");
        hideTheInit();
      });
    }
}
actorsInit();


// RE-INITIALIZE
$iniBT.click(function() {
  $('.filters-stage .tag-actor').remove();
  $hid.find("input").val("");
  //$hid.find("#venue_kind").get(0).selectedIndex = 0;
  $iniBTNS.hide();
});

hideTheInit = function(){
  if ( $('.filters-stage').find('.tag-actor').length == 0  ) {    // check if the div is absent
    $iniBTNS.hide();
  }
}

//function hidePops(event) {}
//function filtergo_taglist(event){};


var $globalClass = "";
//_______________________________________________________________________________________________________ popovers
var tmp = $.fn.popover.Constructor.prototype.show;
$.fn.popover.Constructor.prototype.show = function () {
  tmp.call(this); if (this.options.callback) { this.options.callback();
    }
};

$('.filters-pool .tag').popover({callback: function() {
  //$(".popover-content").find("input").focus();
  $(".popover-content input[autofocus]:first").focus();
  //$('.popover').previousSibling.addClass('active'); // access to the trigger element
  
  $globalClass = $('.popover').prev().attr('class');
  //console.log($globalClass)
  $('.popover').prev().addClass('active');
  
	tagField = $(".popover-content input[autofocus]:first");
	if (tagField.data("autocomplete-source") || tagField.data('available-tags'))
		tagField.multivalues_autocomplete({available_tags: tagField.data('available-tags'),json_url: tagField.data('autocomplete-source')})
	
  /*
  tagitField = $(".popover-content input[autofocus]:first");
	availableTags = tagitField.data('available-tags')
  console.log("avail:" + availableTags)
	
	tagitField.tagit({
		singleField: true,
		allowSpaces: true,
		availableTags: availableTags	
	});
  */



  //___________________________________________________ actions on click on the OK button here :
  $('.popover').find(".btn[type='submit']").on("click", function(){
    
    
    
    $(this).closest('.popover').prev().removeClass('active').popover('hide');
    $(this).closest('.popover').find("form").submit();
    
    // workaround for the double submit problem :
    //$(this).closest('.popover').find("form").submit(function() { $(this).unbind('submit').submit();});
     return false;
  });
  
  
  $('.popover').find(".tag-list").find('.tag').on("click", function(event){
    event.preventDefault();
    var theone = $(this);
    filtergo_taglist(theone);
    $(this).closest('.popover').prev().removeClass('active').popover('hide');
  });
  
  },
  placement:"bottom", animation: false
});

/* Boostrap V3 ....
$(".popover").on('shown.bs.popover', function () {
  alert ("g");
  $(this).find("[autofocus]:first").focus();
});
*/










function filtergo_taglist(theBT) {
  var $thevalue = theBT.data("content");
  var $theText = theBT.text();
  var $theTagClass = theBT.attr('class');
  
  //console.log(theBT.text());
  console.log($theTagClass);
  
  var $thetargetname = theBT.closest(".tag-list").attr('id').substr(2);
  
	theactor = $("#actor_"+ $thetargetname)
  if ( $("#actor_"+ $thetargetname).length != 0  ) {    // check if the div exists
    // $("#actor_"+ $thetargetname).remove();
    $thevalue = $hid.find("#"+ $thetargetname).val() + ", " + $thevalue;
		oldtext = theactor.find('.thevalue').text()
		theactor.find('.thevalue').text(oldtext + ', ' + $theText)
  }
  else {
	  $('.filters-stage').append( "<a class='"+ $theTagClass +" tag-actor active' id = actor_"+ $thetargetname +" href='#'><span class='close'>x</span><span class='thevalue'>"+ $theText +"</span></a>" );
	}
	
	$iniBTNS.show();
  $hid.find("#"+ $thetargetname).val($thevalue);
 
  
  $('.filters-stage').find('.tag-actor').click(function() {
    $thetargetname = $(this).attr( "id").substr(6);
    $(this).remove();
    $hid.find("#"+ $thetargetname).val("");
    hideTheInit();
  });
  
}

/*
function filtergo_sel(theform) {
	// Traiter les éléments du formulaire
	//$thef=theform;//alert ($thef);
	//thes = theform["f_venue_kind"]
	var $thevalue = theform["f_venue_kind"].value;
	//thevalue = $("#theselect").val();
	
  //theText = $("#theselect option:selected").html();
  var $theText = $thevalue
  //thes.find('option:selected').text();
  //theText = $('#theselect:selected').text();
  //alert(  thes)
  
  //theText = theform["f_venue_kind "]
	var $thetargetname = "venue_kind";//$("#theselect").attr('name').substr(2);
	//alert (thevalue)
	if ($thevalue != "") {
	  theactor = $('.filters-stage').find("#actor_"+ $thetargetname);
	  
	  if ( theactor.length != 0  ) {    // check if the div exists
	    $("#actor_"+ $thetargetname).remove();
    }
    $('.filters-stage').append( "<a class='tag tag-actor' id = actor_"+ $thetargetname +" href='#'><span class='close'>x</span><span class='thevalue'>"+ $theText +"</span></a>" );
    
    
    $iniBTNS.show();
    //.val(thevalue);
    $hid.find("#"+ $thetargetname +" option[value='"+thevalue+"']").attr('selected','selected');
  }
  
  
  $('.filters-stage').find('.tag-actor').click(function() { 
    $(this).remove();
    //$hid.find("#"+thetargetname).val("");
    $hid.find("#"+ $thetargetname).get(0).selectedIndex = 0;
    hideTheInit();
  });

}
*/
/*
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
*/

function filtergo(theform) {
	// Traiter les éléments du formulaire
	//console.log(theform["thefield"].data('content'));
	
	var $thevalue = theform["thefield"].value;
	console.log($thevalue);
	var $thetargetname = theform["thefield"].id.substr(2);
	
	/*
	console.log($thetargetname);
	var $theTagClass = theform.data('content');
	console.log("theclass: "+$theTagClass);
		
	var $theform = theform;
	console.log($theform);
	console.log($theform["thefield"].data('class'));
	*/
/*
  var $theTagClass = $theform.closest(".tag").className;
  
  console.log("theclass: "+$theTagClass);
  var $theTagClass ="";
  */
  
  if ($thevalue != "") {
	  theactor = $('.filters-stage').find("#actor_"+ $thetargetname);
	  //alert ( theactor );
	  //alert ( theactor.length != 0 );
	  
	  if ( theactor.length != 0  ) {    // check if the div exists
	    //$("#actor_"+ thetargetname).remove();
	    //alert (theactor.find(".thevalue").text());
	    theactor.find(".thevalue").append(", " + $thevalue);
	    $thevalue = theactor.find(".thevalue").text();
    } else {
      $('.filters-stage').append( "<a class='tag "+$globalClass+" tag-actor active' id = actor_"+ $thetargetname +" href='#'><span class='close'>x</span><span class='thevalue'>"+ $thevalue +"</span></a>" );
    };
    
    $iniBTNS.show();
    $hid.find("#"+ $thetargetname).val($thevalue);
  }
  
  
  $('.filters-stage .tag-actor').click(function() { 
    $thetargetname = $(this).attr( "id").substr(6);
    //alert (thetargetname);
    $(this).remove();
    $hid.find("#"+ $thetargetname).val("");
    hideTheInit();
  });
	
	//alert ($hid.find("#"+thetarget).id);
	/*if(theform.name != "")
		return true;
	else
		return false;*/
		
		
}




function filtergogeo(theform) {
	// Traiter les éléments du formulaire
	//console.log(theform["thefield"].data('content'));
	
	var $thevalue = theform["thefield"].value;
	//console.log($thevalue);
	var $thetargetname = theform["thefield"].id.substr(2);
	
	/*
	console.log($thetargetname);
	var $theTagClass = theform.data('content');
	console.log("theclass: "+$theTagClass);
		
	var $theform = theform;
	console.log($theform);
	console.log($theform["thefield"].data('class'));
	*/
/*
  var $theTagClass = $theform.closest(".tag").className;
  
  console.log("theclass: "+$theTagClass);
  var $theTagClass ="";
  */
  
  if ($thevalue != "") {
	  theactor = $('.filters-stage').find("#actor_"+ $thetargetname);
	  //alert ( theactor );
	 // alert ( theactor.length != 0 );
	  
	  if ( theactor.length != 0  ) {    // check if the div exists
	    $("#actor_"+ $thetargetname).remove();
    }
      $('.filters-stage').append( "<a class='tag "+$globalClass+" tag-actor active' id = actor_"+ $thetargetname +" href='#'><span class='close'>x</span><span class='thevalue'>"+ $thevalue +"km</span></a>" );
    
    
    $iniBTNS.show();
    $hid.find("#"+ $thetargetname).val($thevalue);
  }
  
  
  $('.filters-stage .tag-actor').click(function() { 
    $thetargetname = $(this).attr( "id").substr(6);
    //alert (thetargetname);
    $(this).remove();
    $hid.find("#"+ $thetargetname).val("");
    hideTheInit();
  });
		
		
}





//ui-autocomplete

$('html').on('mouseup', function(e) {
    //if(!$(e.target).closest('.popover').length) {
    if( !$(e.target).closest('.popover').length || $(e.target).hasClass("ui-corner-all") )  {
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
  	  
  		/*$(".filters-outercontainer").toggle(function(){

           $(this).css("height", "auto");
            theH = $(this).height;
            $(this).animate({height:theH},200);
        },function(){


         $(this).animate({height:0},200);

        });*/

  		//$(".filters-outercontainer").animate({height:'toggle'});
  		 //$(this).slideDown(2000);
    	//$(this).slideUp(2000);
  

