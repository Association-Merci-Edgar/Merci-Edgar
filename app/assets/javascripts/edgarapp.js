$('document').ready(function() {
  
	
  initializer();
  $('[data-toggle="tooltip"]').tooltip(); 	      // activate tooltips
  //$(".editbtn").tooltip({html:true});   
  
  
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



// Clickable Dropdown _________________________________
$(function() {
      $('.clicker').click(function(event) { event.preventDefault();});
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
});

//_______

initializer = function() {
  $(".leftpanel").height( $(document).height() ); // Fix the leftmenu height on scroll
}