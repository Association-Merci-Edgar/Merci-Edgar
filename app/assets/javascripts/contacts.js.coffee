# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.structure_name').autocomplete
    source: $('#person_people_structures_attributes_0_structure_name').data('autocomplete-source')
    delay: 1000

  $('.typeah').typeahead
    source: (query, process) ->
      $.ajax(
        url= "/fr/structures?term=" + query
        success: (data) =>
          process(data)
      )
    minLength: 3
    
  
  $(document).on "nested:fieldAdded", (event) ->

    # this field was just inserted into your form
    field = event.field

    # it's a jQuery object already! Now you can find date input
    typeaheadField = field.find(".typeah")

    # and activate datepicker on it
    typeaheadField.typeahead
      source: (query, process) ->
        $.ajax(
          url= "/fr/structures?term=" + query
          success: (data) =>
            process(data)
        )
      minLength: 3
