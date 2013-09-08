# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.structure_name').autocomplete
    source: $('#person_people_structures_attributes_0_structure_name').data('autocomplete-source')
    delay: 1000
    select: ( event, ui ) ->
            $(this).val( ui.item.name );
            cityInput = $(this).parentsUntil("control-group").next().first().find("input")
            cityInput.val( ui.item.city );
            countrySelect = cityInput.parentsUntil("control-group").next().find("select")
            countrySelect.val( ui.item.country );
            return false;
    focus: ( event, ui ) ->
            $(this).val( ui.item.name );
            return false;      
            

  $.ui.autocomplete.prototype._renderItem = ( ul, item ) ->
    return $( "<li>" )
      .data( "item.autocomplete", item )
      .append( "<a><b>" + item.name + "</b> (" + item.city + ", " + item.country+ ")</a>" )
      .appendTo( ul );
      
  
