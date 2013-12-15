$ ->
  $start = $("#start_tour")

  tour = new Tour(
    onStart: -> $start.addClass "disabled", true
    onEnd: -> $start.removeClass "disabled", true
    backdrop: true
#    debug: true
  )

  tour.addSteps [
      title: "Bienvenue !"
      content: "Ceci est un guide de présentation de l’application." +
        "<br>(Vous pouvez utiliser les flèches de votre clavier pour passer les étapes.)"
      orphan: true
    ,
      
      element: ".leftpanel"
      placement: "right"
      title: "Voyons d’abord le menu principal"
      content: "Introduce new users to your product by walking them through it step by step. Built" +
        "on the awesome <a href='http://twitter.github.com/bootstrap' target='_blank'>Bootstrap " +
        "from Twitter.</a>"
      fixed: true
    ,

      element: "#account-nav"
      placement: "right"
      title: "Compte"
      content: "Voici le chemin vers les préférences de votre compte"
      fixed: true
      
#campaigns-nav

    ,
      element: "#search-nav"
      placement: "right"
      title: "Recherche"
      content: "Atteignez en un clin d’œil un contact, une tâche ou une date."
      fixed: true
    ,
      element: "#recent-nav"
      placement: "right"
      title: "Dernièrement"
      content: "Ici une liste des pages consultées récemment."
      fixed: true
      onShown: (tour) -> clickerShow()
#      onNext: (tour) -> clickerHide()
    ,
      element: "#opportunities-nav"
      placement: "right"
      title: "Dates de spectacles"
      content: "Easy is better, right? Easy like Bootstrap."
      fixed: true
    ,
      element: ".footer"
      placement: "top"
      title: "Et là, des liens pour :"
      content: "- se déconnecter"+
        "<br>- recommencer ce tour"+
        "<br>- voir le guide en ligne de Merci Edgar"+
        "<br>- nous faire des suggestions et signaler des erreurs"
      fixed: true
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
      title: "Ce tour est terminé"
      content: "Un tour est disponible pour la pluspart des pages."
      orphan: true
      
    ]

  tour.start()

  $('<div class="alert alert-warning"><button class="close" data-dismiss="alert">&times;</button>You ended the demo tour. <a href="#" class="start">Restart the demo tour.</a></div>').prependTo(".content").alert() if tour.ended()

  $(document).on "click", ".start", (e) ->
    e.preventDefault()
    return if $(this).hasClass "disabled"
    tour.restart()
    $(".alert").alert "close"

  $("html").smoothScroll()