$(document).on('nested:fieldAdded', function(event){
  $.ui.autocomplete.prototype._renderItem = function( ul, item ) {
	  return $( '<li></li>' )
	  .data( 'item.autocomplete', item )
	  .append( "<a><b>" + item.name + "</b> (" + item.city + ", " + item.country + ")</a>" )
	  .appendTo( ul );
	};
	
})