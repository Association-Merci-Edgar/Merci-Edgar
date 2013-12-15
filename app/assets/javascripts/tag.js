function split( val ) {
  return val.split( /,\s*/ );
}
function extractLast( term ) {
  return split( term ).pop();
}

jQuery.fn.multivalues_autocomplete = function(options) {
	var settings = $.extend({}, options)
	if (settings.available_tags) {
		source_fn = function( request, response ) {
			response( $.ui.autocomplete.filter(options.available_tags, extractLast( request.term ) ) );
		}
	}
	if (settings.json_url) {
		source_fn = function( request, response ) {
			$.getJSON( settings.json_url, {
        term: extractLast( request.term )
      }, response );      
		}
	}	
		
	return this.bind( "keydown", function( event ) {
    if ( event.keyCode === $.ui.keyCode.TAB &&
        $( this ).data( "ui-autocomplete" ).menu.active ) {
      event.preventDefault();
    }
  })
  .autocomplete({
    source: source_fn,
    search: function() {
      // custom minLength
      var term = extractLast( this.value );
      if ( term.length < 2 ) {
        return false;
      }
    },
    focus: function() {
      // prevent value inserted on focus
      return false;
    },
    select: function( event, ui ) {
	
      var terms = split( this.value );
      // remove the current input
      terms.pop();
      // add the selected item
      terms.push( ui.item.value );
      // add placeholder to get the comma-and-space at the end
      // terms.push( "" );
      this.value = terms.join( ", " );
      return false;
    }
  }).data("ui-autocomplete")._renderItem = function(ul, item) {
		return $("<li>").append("<a>" + item.label + "</a>").appendTo(ul);  
	};
}

