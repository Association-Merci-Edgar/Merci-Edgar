# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.jq_autocomplete').each (index,element) =>
    typeaheadField = $(element)
    typeaheadField.autocomplete(
      source: typeaheadField.data('autocomplete-source')

      delay: 1000

      open: (event, ui) ->
        menu = $(this).data("uiAutocomplete").menu
        item = $('li', menu.element).first()
        # menu.focus(null,item) if item

      focus: (event, ui) ->
        console.log("focus handler")
        typeaheadField.val ui.item.value
        false

      select: (event, ui) ->
        typeaheadField.val ui.item.value
        if ui.item.link
          window.location.href = ui.item.link
        else
          if ui.item.new is "true"
            console.log("new")
            typeaheadField.css("color", "blue")
          else
            console.log("exist")
            typeaheadField.css("color", "")
          show_host_kind = ui.item.show_host_kind
          if show_host_kind
            show_host_kind_input = typeaheadField.parent().parent().prev()
            show_host_kind_input.val show_host_kind
        false
    ).data("ui-autocomplete")._renderItem = (ul, item) ->
      if item.new is "true"
        item_html = "<a><i class='ico edi-plus3'></i>" + item.label + "</a>"
        $("<li class='action'>").append(item_html).appendTo ul
      else
        item_html = "<a><div class='pic pic-mini'><img alt='user' src='" + item.avatar + "'></div>" + item.label + "</a>"
        if item.kind
          item_html = item_html + "<span class='infos'>" + item.kind + "</span>"
        $("<li>").append(item_html).appendTo ul


      
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


      typeaheadField.autocomplete(
        source: typeaheadField.data('autocomplete-source')

        delay: 1000

        open: (event, ui) ->
          menu = $(this).data("uiAutocomplete").menu
          item = $('li', menu.element).first()
          # menu.focus(null,item) if item

        focus: (event, ui) ->
          console.log("focus handler")
          typeaheadField.val ui.item.value
          false

        select: (event, ui) ->
          typeaheadField.val ui.item.value
          if ui.item.new is "true"
            console.log("new")
            typeaheadField.css("color", "blue")
          else
            console.log("exist")
            typeaheadField.css("color", "")
          show_host_kind = ui.item.show_host_kind
          if show_host_kind
            show_host_kind_input = typeaheadField.parent().parent().prev()
            show_host_kind_input.val show_host_kind
          false
      ).data("ui-autocomplete")._renderItem = (ul, item) ->
        if item.new is "true"
          item_html = "<a><i class='entypo edi-plus3'></i>" + item.label + "</a>"
          $("<li class='action'>").append(item_html).appendTo ul
        else
          item_html = "<a><div class='pic pic-mini'><img alt='user' src='" + item.avatar + "'></div>" + item.label + "</a>"
          if item.kind
            item_html = item_html + "<span class='infos'>" + item.kind + "</span>"
          $("<li>").append(item_html).appendTo ul

          
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