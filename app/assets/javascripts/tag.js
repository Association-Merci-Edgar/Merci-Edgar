/*
$.ajax({
    type: 'get',
    url: '/tags/index?type=CustomTag',
    data: "",
    dataType: 'json',
    success: function(data) {
        var sampleTags = data;
        $('.autocomplete_tags').tagit({
            availableTags: sampleTags,
            singleField: true,
            singleFieldNode: $('#mySingleField'),
            allowSpaces: true
        });
    }
})
*/

$(document).ready(function() {

	var availableStyleTags = $(".style_tags_input").data('autocomplete-source')
  $(".style_tags_input").tagit({
		singleField: true,
		allowSpaces: true,
		// availableTags: availableStyleTags
		autocomplete: {
	    source: availableStyleTags,
	    delay: 1000
	  }	
	});

	var availableNetworkTags = $(".network_tags_input").data('autocomplete-source')
  $(".network_tags_input").tagit({
		singleField: true,
		allowSpaces: true,
		autocomplete: {
	    source: availableNetworkTags,
	    delay: 1000
	  }	
	});

	var availableCustomTags = $(".custom_tags_input").data('autocomplete-source')
  $(".custom_tags_input").tagit({
		singleField: true,
		allowSpaces: true,
		autocomplete: {
	    source: availableCustomTags,
	    delay: 1000
	  }	
	});

});

$(document).on('nested:fieldAdded', function(event){
  var field = event.field;
	input = field.find('.style_tags_input')

	var availableStyleTags = input.data('autocomplete-source')
  input.tagit({
		singleField: true,
		allowSpaces: true,
		//availableTags: availableStyleTags
		
		
		autocomplete: {
	    source: availableStyleTags,
	    delay: 1000
			// _renderItem: function(ul, item) { return $("<li>").append("<a>" + item.label + "</a>").appendTo(ul) }
    }
	
	});
/*	
	input.autocomplete({
    source: availableStyleTags,
    delay: 1000
		
	}).data("ui-autocomplete")._renderItem = function(ul, item) {
    return $("<li>").append("<a>" + item.label + "</a>").appendTo(ul);
  };
*/  
});
