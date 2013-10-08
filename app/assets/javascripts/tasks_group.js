
function goTask(theBT) {
  $theItem = $(theBT).parent().parent();
	//thevalue = $theItem.find(".title").text();
	//alert (thevalue);
	
	//$theItem.animate({height:0},200);
	$theItem.slideUp(200);//.fadeOut();
	//http://api.jquery.com/slideDown/
	
	
	// SOME AJAX HERE ??
	// SERVER TALKING ?
	
}






/*
$( "#final_submit" ).click(function() {
  $('.filters-hiddenform form').submit();
});
}
*/

/*
$.each($('.filters-trigger'), function() {      
  $(this).click(function () {
  	  $(this).toggleClass("active");
  		$('.filters-outercontainer').toggleClass("open");
  	});
});
*/