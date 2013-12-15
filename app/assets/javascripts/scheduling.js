function toggleShowBuyer(element) {
	if (element.val() == "Cette structure") {
		show_buyer_div = element.parent().parent().parent().next()
		show_buyer_div.fadeOut()
		// show_buyer_div.find("input").val("")
	}
	else {
		element.parent().parent().parent().next().fadeIn()
	}
}

jQuery.fn.toggleShowBuyerOnChange = function() {
	this.change(function() {
		if ($(this).val() == "Cette structure") {
			show_buyer_div = $(this).parent().parent().parent().next()
			show_buyer_div.fadeOut()
			// show_buyer_div.find("input").val("")
		}
		else {
			$(this).parent().parent().parent().next().fadeIn()
		}
	})
	
	
}

// $('.external_show_buyer_radio').toggleShowBuyerOnReadyAndChange()

$(document).ready(function() {
	$('.external_show_buyer_radio').toggleShowBuyerOnChange()
	$('.external_show_buyer_radio:checked').each(function() {
		if ($(this).val() == "Cette structure") {
			$(this).parent().parent().parent().next().hide()
		}
		
		$(this).toggleShowBuyerOnChange()
	})
})

$(document).on('nested:fieldAdded', function(event){
  // this field was just inserted into your form
  var field = event.field;
	field.find('.external_show_buyer_radio').each(function() {
		show_buyer_radio_input = $(this)
		show_buyer_radio_input.parent().parent().parent().next().hide()
		// toggleShowBuyer(show_buyer_radio_input)
		show_buyer_radio_input.toggleShowBuyerOnChange()
	})
	

})