
$('document').ready(function() {
	
	// show/hide the leftpanel _________________________________
	window.smallScreens = function() {
		if ($(window).width() < 767) {
			$('.leftpanel').addClass( "collapsed");
			$('.mainpanel').addClass( "goleft");
		} else {
			$('.leftpanel').removeClass( "collapsed");
			$('.mainpanel').removeClass( "goleft");
		}
	}
	
  /*$('#nav_toggle').click(function(){
		$('.leftpanel').animate({scrollTop:0}, 'slow');	
		return false;
	});
  */
	$('.leftpanel.collapsed').animate();
	$('.leftpanel:not(.collapsed)').animate();

	$("#nav_toggle").click(function () {
/*$(".leftpanel").toggle("slow");*/
		$('.leftpanel').toggleClass( "collapsed");
		$('.mainpanel').toggleClass( "goleft");
	});
	//alert ("yo");
	smallScreens();
	
	// Clickable Dropdown _________________________________
	//$(function() {
  			
  			$('.click-nav > .ul').toggleClass('no-js js');
  			$('.click-nav .js ul').hide();
  			$('.click-nav .js').click(function(e) {
  				$('.click-nav .js ul').slideToggle(200);
  				$('.clicker').toggleClass('active');
  				e.stopPropagation();
  			});
  			$(document).click(function() {
  				if ($('.click-nav .js ul').is(':visible')) {
  					$('.click-nav .js ul', this).slideUp(0);
  					$('.clicker').removeClass('active');
  				}
  			});
  		//});
	
})


$(window).load(function() {
	smallScreens();
});

$(window).resize(function() {
	smallScreens();	
});

