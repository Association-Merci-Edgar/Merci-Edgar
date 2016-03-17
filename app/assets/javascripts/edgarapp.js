$('document').ready(function() {

  initializer();

  $('[data-toggle="tooltip"]').tooltip();

  $("a.btn-close").click(function(event) {
    event.preventDefault();
    $(this).parent('.notice').remove();
  });

  $("*[data-spinner]").on('ajax:beforeSend', function(e){
    $($(this).data('spinner')).show();
    e.stopPropagation();
  });

  $("*[data-spinner]").on('ajax:complete', function(){
    $($(this).data('spinner')).hide();
  });

  $('.new_reporting .cancel').on('click', function (event) {
    event.stopPropagation(); event.preventDefault();
    $('.new_reporting textarea').val("");

  });

  $('#activity .list-large > li .editbtn').on('click', function (event) {
    event.stopPropagation();
    event.preventDefault();
    var $content = $(this).closest('li').find('.content');
    var $form = $(this).closest('li').find('form');
    var $textarea = $form.find('textarea');

    $textarea.val( $.trim( $content.text() )).trigger('autosize.resize');
    $form.toggleClass('hidden');
    $content.toggleClass('hidden');
    $(this).toggleClass('hidden');
    $(this).closest('li').find('.cancel').toggleClass('hidden');

    $textarea.focus();

  });

  $('li.btn-in-list.expandable a').on('click', function (event) {
    event.stopPropagation(); event.preventDefault();
    var $form = $(this).closest('li').find('.form-in-list');
    $form.slideToggle(200);
    $form.find("[autofocus]:first").focus();
    $(this).closest('li').toggleClass('toggled');
  });

  $('#activity .list-large > li .cancel').on('click', function (event) {
    event.stopPropagation(); event.preventDefault();
    var $content = $(this).closest('li').find('.content');
    var $form = $(this).closest('li').find('form');

    $form.toggleClass('hidden');
    $content.toggleClass('hidden');
    $(this).closest('li').find('.editbtn').toggleClass('hidden');
    $(this).closest('li').find('.cancel').toggleClass('hidden');

  });

  $('textarea').autosize();

  window.smallScreens = function() {
    $('.leftpanel').removeClass( "collapsed");
    $('.mainpanel').removeClass( "goleft");
    $('.leftpanel').removeClass( "small");
    $('.mainpanel').removeClass( "goleftsmall");
    if ($(window).width() <= 767) {
      $('.leftpanel').addClass( "collapsed");
      $('.mainpanel').addClass( "goleft");
    } else if ($(window).width() <= 1024) {
      $('.leftpanel').addClass( "small");
      $('.mainpanel').addClass( "goleftsmall");
    } else if ($(window).width() > 1024) {
    }
  }
  $('.leftpanel.collapsed').animate();
  $('.leftpanel:not(.collapsed)').animate();

  $("#nav_toggle").click(function () {
    navToggle();

  });

  smallScreens();
})

$(window).load(function() {
  smallScreens();
});


$(window).resize(function() {
  smallScreens();
  initializer();
});

function navTogMini() {
  $('.leftpanel').toggleClass( "small");
  $('.mainpanel').toggleClass( "goleftsmall");
}

function navToggle() {
  $('.leftpanel').toggleClass( "collapsed");
  $('.mainpanel').toggleClass( "goleft");
}

$(function() {
  $div = $('.notice.transient')
    if ($div.get(0)) {
      setTimeout(function(){
        $div.slideUp(500);
      }, 7000);
    }
});

var currentnav='';
var currenttest='';
var goActive= 1;

checkTools = function(){
  if ( ($('#recent-nav').hasClass("active-tool")) || ($('#search-nav').hasClass("active-tool")) ) {
    goActive = 0;
  } else {
    goActive = 1;
  }
  console.log("goActive=" + goActive );
}

checkCurrent= function(){
  console.log(currentnav);
  currenttest = $('.leftmenu').find('.nav').find('.active');
  console.log("ct=" + currenttest.length );
  if ( currenttest.length ){
    currentnav = currenttest;
  }
  console.log("cnav="+currentnav);
}

toggleRecent = function(){
  checkCurrent();
  if ( ($('#recent-menu').width()==290)  ){
    if (goActive==1) { currentnav.addClass("active"); }
    $('#recent-nav').removeClass('active-tool');
    $('#recent-menu').removeClass('expanded');
    $('#recent-menu').hide();
  } else {
    if (goActive==1) { currentnav.removeClass("active"); }
    $('#recent-nav').addClass('active-tool');
    $('#recent-menu').show();
    $('#recent-menu').addClass("expanded");
    if ($('#search-nav').hasClass("active-tool")) {
      toggleSearch();
    }
  }
};

$('#recent-nav a').click(function(event) { event.preventDefault();
  if ( !($('#recent-nav').hasClass("active-tool")) ) {
    toggleRecent();
  }
});

$(document).click(function() {
  if ($('#recent-menu').width()==290) {
    toggleRecent();
  }
});


toggleSearch = function(){
  checkCurrent();
  if ($('#search-nav').hasClass("active-tool")) {
    if (goActive==1) { currentnav.addClass("active"); }
    $('#search-nav').removeClass("active-tool");
    $('#thesearch input').val("");
    $('#thesearch').hide();
  } else {
    if (goActive==1) { currentnav.removeClass("active"); }
    $('#thesearch').show();
    $('#search-nav').addClass("active-tool");
    $('#thesearch').find("[autofocus]:first").focus();
  }
}

$('#search-nav a').click(function(event) { event.preventDefault();
  toggleSearch();
});
$('.search-backdrop').click(function(event) { event.preventDefault();
  toggleSearch();
});

initializer = function() {
  $(".modal").on('shown', function() {
    $(this).find("[autofocus]:first").focus();
  });
  $("#gmaps_index").width( $("#markers_list").width() )
    $("#markers_list").height( $(document).height() - 210 - $("#gmaps_index").height() )
    Mousetrap.bind('+', function() { $("#plusmenu").toggleClass('active'); $("#plusmenu").find("a:first").focus(); });
  Mousetrap.bind('s', function() {toggleSearch(); }, 'keyup');
  Mousetrap.bind('*', function() {toggleSearch(); }, 'keyup');
  Mousetrap.bind('@', function() {navTogMini(); });
}

