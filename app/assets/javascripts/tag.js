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
	var availableStyleTags = $(".style_tags_input").data('available-tags')
  $(".style_tags_input").tagit({
		singleField: true,
		allowSpaces: true,
		availableTags: availableStyleTags	
	});

	var availableNetworkTags = $(".network_tags_input").data('available-tags')
  $(".network_tags_input").tagit({
		singleField: true,
		allowSpaces: true,
		availableTags: availableNetworkTags	
	});

	var availableCustomTags = $(".custom_tags_input").data('available-tags')
  $(".custom_tags_input").tagit({
		singleField: true,
		allowSpaces: true,
		availableTags: availableCustomTags	
	});

});