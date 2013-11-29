# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.jq_autocomplete').each (index,element) =>
    typeaheadField = $(element)
    typeaheadField.autocomplete
      source: typeaheadField.data('autocomplete-source')
      delay: 1000
      
  ###
  $('.typeah').typeahead
    source: (query, process) ->
      $.ajax(
        url= "/fr/structures?term=" + query
        success: (data) =>
          process(data)
      )
    minLength: 3
  ###    
  

  $(document).on "nested:fieldAdded", (event) ->

    # this field was just inserted into your form
    field = event.field

    field.find(".jq_autocomplete").each (index,element) =>
    
      # it's a jQuery object already! Now you can find date input
      typeaheadField = $(element)
      console.debug("field:" + typeaheadField.attr("name"))


      typeaheadField.autocomplete
        source: typeaheadField.data('autocomplete-source')
        delay: 1000

  ###
    # and activate datepicker on it
    typeaheadField.typeahead
      source: (query, process) ->
        $.ajax(
          url= "/fr/structures?term=" + query
          success: (data) =>
            process(data)
        )
      minLength: 3
  ###