
$('document').ready(function() {
	
	// show/hide the leftpanel
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
	
})




$(window).load(function() {
	smallScreens();
});

$(window).resize(function() {
	smallScreens();	
});

