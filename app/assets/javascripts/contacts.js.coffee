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
  
$ ->
  $start = $("#start_tour")

  tour = new Tour(
    onStart: -> $start.addClass "disabled", true
    onEnd: -> $start.removeClass "disabled", true
    backdrop: true
#    debug: true
  )

  tour.addSteps [
#      element: ".plusmenu"
#      placement: "left"
#      title: "Welcome to MErci Edgar!"
#      content: "Introduce new users to your product by walking them through it step by step. Built" +
#        "on the awesome <a href='http://twitter.github.com/bootstrap' target='_blank'>Bootstrap " +
#        "from Twitter.</a>"
#    ,
      element: "#account-nav"
      placement: "right"
      title: "Compte"
      content: "Easy is better, right? Easy like Bootstrap."
      fixed: true
#opportunities-nav
#campaigns-nav
#search-nav
#recent-nav
    
    ,
      element: "#opportunities-nav"
      placement: "right"
      title: "Dates de spectacles"
      content: "Easy is better, right? Easy like Bootstrap."
      fixed: true
    ,
      element: "#start_tour"
      placement: "top"
      title: "Les Stats"
      content: "Easy is better, right? Easy like Bootstrap."
      fixed: true
    ,
      title: "And support for orphan steps"
      content: "If you activate the orphan property, the step(s) are shown centered " +
      "in the page, and you can forget to specify element and placement!"
      orphan: true
    ,
      element: "#dash-tasks"
      placement: "bottom"
      title: "Résumé des tâches"
      content: "Easy is better, right? Easy like Bootstrap." 
    ,
      element: "#dash-stats"
      placement: "top"
      title: "Les Stats"
      content: "Easy is better, right? Easy like Bootstrap." 
    ,
      path: "/fr/contacts/"
      element: ".page-title"
      placement: "bottom"
      title: "See, you are not restricted to only one page"
      content: "Well, nothing to see here. Click next to go back to the index page."
    ,
      path: "/"
      element: ".leftpanel"
      placement: "right"
      title: "Best of all, it's free!"
      content: "Yeah! Free as in beer... or speech. Use and abuse, but don't forget to contribute!"
      
    ]

#  tour.start()

  $('<div class="alert alert-warning"><button class="close" data-dismiss="alert">&times;</button>You ended the demo tour. <a href="#" class="start">Restart the demo tour.</a></div>').prependTo(".content").alert() if tour.ended()

  $(document).on "click", ".start", (e) ->
    e.preventDefault()
    return if $(this).hasClass "disabled"
    tour.restart()
    $(".alert").alert "close"

  $("html").smoothScroll()