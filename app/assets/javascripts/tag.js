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
    $(".autocomplete_tags").tagit({
			singleField: true,
			allowSpaces: true,
			availableTags: ['c++', 'java', 'jacour']
		});
});