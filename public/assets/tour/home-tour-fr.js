!function(){$(function(){var e,t;return e=$("#start_tour"),t=new Tour({onStart:function(){return e.addClass("disabled",!0)},onEnd:function(){return e.removeClass("disabled",!0)},backdrop:!0}),t.addSteps([{title:"Bienvenue !",content:"Ceci est un guide de présentation de l’application.<br>(Vous pouvez utiliser les flèches gauche et droite de votre clavier pour passer les étapes.)",orphan:!0},{element:".leftpanel",placement:"right",title:"Voyons d’abord le menu principal",content:"A votre gauche, le menu principal, à partir duquel vous pourrez gérer vos contacts, organiser vos tâches...",fixed:!0},{element:"#accounts-tab",placement:"right",title:"Compte",content:"Voici le chemin vers les préférences de votre compte",fixed:!0},{element:"#search-nav",placement:"right",title:"Recherche",content:"Atteignez en un clin d’œil à une personne ou une structure.",fixed:!0},{element:"#plusmenu-trigger",placement:"left",title:"Le bouton +",content:"Le bouton plus vous permet à tout moment de créer une nouvelle personne, structure ou tâche",fixed:!0},{element:"#recent-nav",placement:"right",title:"Dernièrement",content:"Ici une liste des fiches consultées récemment.",fixed:!0,onShown:function(){return clickerShow()}},{element:"#opportunities-nav",placement:"right",title:"Contrats",content:"Bientôt ici la liste de vos contrats pour vos futures dates de spectacle ...",fixed:!0},{element:".footer",placement:"top",title:"En bas à gauche ... Quelques liens pour",content:"- se déconnecter<br>- recommencer ce tour<br>- voir le guide en ligne de Merci Edgar<br>- nous faire des suggestions et signaler des erreurs",fixed:!0},{element:"#dash-stats",placement:"top",title:"Les Stats",content:"Easy is better, right? Easy like Bootstrap."},{title:"Ce tour est terminé",content:"Un tour sera disponible pour la plupart des pages.",orphan:!0}]),t.start(),t.ended()&&$('<div class="alert alert-warning"><button class="close" data-dismiss="alert">&times;</button>You ended the demo tour. <a href="#" class="start">Restart the demo tour.</a></div>').prependTo(".content").alert(),$(document).on("click",".start",function(e){return e.preventDefault(),$(this).hasClass("disabled")?void 0:(t.restart(),$(".alert").alert("close"))}),$("html").smoothScroll()})}.call(this);