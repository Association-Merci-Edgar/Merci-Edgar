// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require bootstrap
//= require_self


/*
  = require multipage/tinyscrolling
*/

jQuery('document').ready(function() {
  /*
  $('[data-toggle="modali"]').on('click', function (event) {
      event.stopPropagation(); event.preventDefault();
      console.log("modali");
      var target = $(this).attr("data-content");
      console.log("modali "+target);
      
      var offset = $(this).offset();
      $(target).css({top: offset.top, left: offset.left});
         
      
      //$("#mydiv").parent().css({position: 'relative'});
      //$("#mydiv").css({top: 200, left: 200, position:'absolute'});
      
      
      $(target).toggle()
      
  });
  */
  /*
  $('.collapse').on('show', function () {
    // do something…
    console.log("acc")
  })
  */
  /*
      $('.collapse').on('shown', function (event) {
        event.preventDefault();
        console.log("accu")
          //var offset = $('.accordion-toggle.in').offset();
          var offset = $('.accordion-toggle:not(.collapsed)').offset();
          console.log(offset.top)
              if(offset)$('html,body').scrollTop( offset.top); //offset.top + 80
      });
      */
      //$('#collapse1').collapse({ toggle: true })
  
      //$(".collapse").collapse()
      /*
      $('.accordion-toggle').click(function(){
        $('.accordion-toggle').removeClass("in");
        $(this).addClass("in");
      }
      */
  

  // display validation errors for the "request invitation" form
  if (jQuery('.alert-error').length > 0) {
    jQuery("#request-invite").modal('toggle');
  }

  // use AJAX to submit the "request invitation" form
  jQuery('#invitation_button').on('click', function() {
    email = jQuery('#invit_user #user_email').val();
    dataString = 'user[email]='+ email;
    jQuery.ajax({
      type: "POST",
      url: "/fr/users",
      data: dataString,
      success: function(data) {
        jQuery('#request-invite').html(data);
        loadSocial();
      }
    });
    return false;
  });

})

// load social sharing scripts if the page includes a Twitter "share" button
function loadSocial() {

    //Twitter
    if (typeof (twttr) != 'undefined') {
      twttr.widgets.load();
    } else {
      jQuery.getScript('http://platform.twitter.com/widgets.js');
    }

    //Facebook
    if (typeof (FB) != 'undefined') {
      FB.init({ status: true, cookie: true, xfbml: true });
    } else {
      jQuery.getScript("http://connect.facebook.net/en_US/all.js#xfbml=1", function () {
        FB.init({ status: true, cookie: true, xfbml: true });
      });
    }

    //Google+
    if (typeof (gapi) != 'undefined') {
      jQuery(".g-plusone").each(function () {
        gapi.plusone.render($(this).get(0));
      });
    } else {
      jQuery.getScript('https://apis.google.com/js/plusone.js');
    }
}



jQuery('.login-toggle').click(function(){
  console.log("ter")
  if (!jQuery('#login-tab').hasClass("invisible")) {
    jQuery('#login-tab').addClass("invisible");
    jQuery('#nav').addClass("hidden");
    //jQuery('#socialfixed').addClass("hidden");
    //jQuery('#socialfixed').addClass("invisible");
    //jQuery('#langswitch').addClass("invisible");
    jQuery('#login-form').removeClass("invisible");
    jQuery("input:text:visible:first").focus();
  } else {
    jQuery('#login-tab').removeClass("invisible");
    jQuery('#nav').removeClass("hidden");
    //jQuery('#socialfixed').removeClass("hidden");
    
    //jQuery('#socialfixed').removeClass("invisible");
    //jQuery('#langswitch').removeClass("invisible");
    jQuery('#login-form').addClass("invisible");
  }
  
});


jQuery("[rel='tooltip']").tooltip();



jQuery('.login-btn').removeClass("btn");

jQuery('.nav-collapse .nav > li > a').click(function(){
			
			jQuery('.collapse.in').removeClass('in').css('height', '0');

});