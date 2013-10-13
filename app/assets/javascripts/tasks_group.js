function goTask(input) {
	var link = $(input).parent().attr("data-link")
	$theItem = $(input).parent().parent();
	$theItem.slideUp(200);
  $.ajax({
    type: "PUT",
    url: link,
    success: function(data) {
			// 
    }
  });
  return false;
	
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