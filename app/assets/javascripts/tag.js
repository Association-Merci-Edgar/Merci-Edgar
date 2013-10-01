//= require tag-it
//= require_self

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
