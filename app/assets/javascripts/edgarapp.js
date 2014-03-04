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

// reporting

	//______________________ New Entry - Cancel Button
	$('.new_reporting .cancel').on('click', function (event) {
	  event.stopPropagation(); event.preventDefault();
	  $('.new_reporting textarea').val("");

	});


	//______________________ Existing Entry - Edit Button

	$('#activity .list-large > li .editbtn').on('click', function (event) {
	  event.stopPropagation();
	  event.preventDefault();
	  var $content = $(this).closest('li').find('.content');
	  var $form = $(this).closest('li').find('form');
	  var $textarea = $form.find('textarea');
  
	  // remplit le textarea et 'trigger' l'autosize
	  $textarea.val( $.trim( $content.text() )).trigger('autosize.resize');
  
	  //cache / révéle les éléments
	  $form.toggleClass('hidden');
	  $content.toggleClass('hidden');
	  $(this).toggleClass('hidden');
	  $(this).closest('li').find('.cancel').toggleClass('hidden');
  
	  $textarea.focus();
  
	  //console.log($content);
	  //event.preventDefault(); return false;
  
	});



	//______________________ Existing Entry - Submit Button
/*
	$('#activity .list-large > li button[type="submit"] ').on('click', function (event) {
	  event.stopPropagation(); event.preventDefault();
	  var $content = $(this).closest('li').find('.content');
	  var $form = $(this).closest('li').find('form');

	  $form.toggleClass('hidden');
	  $content.toggleClass('hidden');
	  $(this).closest('li').find('.editbtn').toggleClass('hidden');
  

	});
*/
  
  
	//______________________ Btn-in-list TOGGLE
	$('li.btn-in-list.expandable a').on('click', function (event) {
	  event.stopPropagation(); event.preventDefault();
    var $form = $(this).closest('li').find('.form-in-list');
    $form.slideToggle(200);
    $form.find("[autofocus]:first").focus();
    $(this).closest('li').toggleClass('toggled');
    
	});
  


	//______________________ Existing Entry - Cancel Button
	$('#activity .list-large > li .cancel').on('click', function (event) {
	  event.stopPropagation(); event.preventDefault();
	  var $content = $(this).closest('li').find('.content');
	  var $form = $(this).closest('li').find('form');

	  $form.toggleClass('hidden');
	  $content.toggleClass('hidden');
	  $(this).closest('li').find('.editbtn').toggleClass('hidden');
	  $(this).closest('li').find('.cancel').toggleClass('hidden');

	});


	$('textarea').autosize();



  
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
	navToggle();
	
	});

	smallScreens();
})



$(window).load(function() {
	smallScreens();
});



$(window).resize(function() {
	smallScreens();
	initializer();
});



function navTogMini() {
  $('.leftpanel').toggleClass( "small");
	$('.mainpanel').toggleClass( "goleftsmall");
}


function navToggle() {
  /*$(".leftpanel").toggle("slow");*/
  $('.leftpanel').toggleClass( "collapsed");
	$('.mainpanel').toggleClass( "goleft");
}

  
  
//  _________________________________ Clickable Dropdown -- Old "Recent" BTN behaviour
/*
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
*/

/*
$.fn.fadeUp = function() {
  
  $(this).animate({ height: 0, padding: 0, opacity: 0, min-height:0 }, 500);
}
*/


//  _________________________________ Hide Notices
$(function() {
  //$div = $('.notice:not(.error)')
  $div = $('.notice.transient')
  if ($div.get(0)) {    // check if the div exists
    setTimeout(function(){ //$div.animate({height: "0px"}, 400);
        //$div.fadeOut();
        $div.slideUp(500);
        //$div.animate({ height: 0, padding: 0, opacity: 0, min-height:0 }, 500);
        //$div.fadeUp();
      }, 7000);
  }
});



//  __________________________________________________________________ "Tools" (search & recent) BTN behaviour

var currentnav='';
var currenttest='';
var goActive= 1;

checkTools = function(){
  //if ( $('.leftmenu').find('.nav').find('.active-tool') ){
  if ( ($('#recent-nav').hasClass("active-tool")) || ($('#search-nav').hasClass("active-tool")) ) {
    goActive = 0;
    } else {
    goActive = 1;
  }
    console.log("goActive=" + goActive );
}

checkCurrent= function(){
  console.log(currentnav);
  currenttest = $('.leftmenu').find('.nav').find('.active');
  console.log("ct=" + currenttest.length );
  
  if ( currenttest.length ){
    currentnav = currenttest;
    //goActive= 1;
  } //else {goActive= 0;}
  
  console.log("cnav="+currentnav);
  
  //checkTools();
}

//  _________________________________ "Recent" BTN behaviour
toggleRecent = function(){
  checkCurrent();
  if ( ($('#recent-menu').width()==290)  ){
    // HIDE
    if (goActive==1) { currentnav.addClass("active"); }
		$('#recent-nav').removeClass('active-tool');
    $('#recent-menu').removeClass('expanded');
    $('#recent-menu').hide();
    //$('#recent-menu').css('width', '0px');
  
   } else {
     // SHOW
     
     if (goActive==1) { currentnav.removeClass("active"); }
     $('#recent-nav').addClass('active-tool');
      $('#recent-menu').show();
     $('#recent-menu').addClass("expanded");
     //$('#recent-menu').css('width', '290px');
     
     if ($('#search-nav').hasClass("active-tool")) {
       toggleSearch();
     }
    }
};

$('#recent-nav a').click(function(event) { event.preventDefault();
  if ( !($('#recent-nav').hasClass("active-tool")) ) {
  toggleRecent();
  }
});

$(document).click(function() {
  if ($('#recent-menu').width()==290) {
    toggleRecent();
  }
});


//  _________________________________ SEARCH TOGGLE
toggleSearch = function(){
  checkCurrent();
  
  if ($('#search-nav').hasClass("active-tool")) {
    // HIDE
    if (goActive==1) { currentnav.addClass("active"); }
    $('#search-nav').removeClass("active-tool");
    $('#thesearch input').val("");
    $('#thesearch').hide();
    
  } else {
    // SHOW
    // $('.searchahead').typeahead();
    // get and apply the correct TOP position
    //var offset = $('#search-nav').offset();//console.log(offset.top);
    //$('#thesearch').find('input').css('top', offset.top + 'px');
    
    if (goActive==1) { currentnav.removeClass("active"); }
    
    $('#thesearch').show();
    $('#search-nav').addClass("active-tool");
    $('#thesearch').find("[autofocus]:first").focus();
  }
}

$('#search-nav a').click(function(event) { event.preventDefault();
  //goActive= 0;
  toggleSearch();
});
$('.search-backdrop').click(function(event) { event.preventDefault();
  //goActive= 1;
  toggleSearch();
  
});

//  __________________________________________________________________




//  _________________________________

initializer = function() {
  //$(".leftpanel").height( $(document).height() ); // Fix the leftmenu height on scroll
  $(".modal").on('shown', function() {
      $(this).find("[autofocus]:first").focus();
  });
  
  $("#gmaps_index").width( $("#markers_list").width() )
  $("#markers_list").height( $(document).height() - 210 - $("#gmaps_index").height() )
  
  // MouseTrap __ http://craig.is/killing/mice
  Mousetrap.bind('+', function() { $("#plusmenu").toggleClass('active'); $("#plusmenu").find("a:first").focus(); });
  Mousetrap.bind('s', function() {toggleSearch(); }, 'keyup');
  Mousetrap.bind('*', function() {toggleSearch(); }, 'keyup');
  Mousetrap.bind('@', function() {navTogMini(); });

}


