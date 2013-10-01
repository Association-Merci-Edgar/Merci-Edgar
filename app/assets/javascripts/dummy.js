$(".dummy:first-child").addClass("dumshow");

$(".dummy").click(function() {
    var $selected = $(".dumshow").removeClass("dumshow");
    var divs = $selected.parent().children();
    divs.eq((divs.index($selected) + 1) % divs.length).addClass("dumshow");
});