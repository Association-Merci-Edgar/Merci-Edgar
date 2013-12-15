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
//= require onepage/jquery-1.2.7
//= require jquery_ujs
//= require onepage/google-code-prettify/prettify
//= require bootstrap
//= require onepage/jquery.easing
//= require onepage/jquery.waitforimages
//= require onepage/jquery.isotope.min
//= require onepage/jquery.prettyPhoto-3.1.4-W3C
//= require onepage/jquery.ui.totop
//= require onepage/jquery.inview
//= require onepage/jquery.nicescroll
//= require onepage/jquery.parallax-1.1.3
//= require onepage/jquery.localscroll-1.2.7-min
//= require onepage/jquery.scrollTo-1.4.2-min
//= require onepage/custom
//= require onepage/tweetable.jquery
//= require onepage/jquery.timeago
//= require_self
jQuery('document').ready(function() {

  // display validation errors for the "request invitation" form
  if (jQuery('.alert-error').length > 0) {
    jQuery("#request-invite").modal('toggle');
  }

  // use AJAX to submit the "request invitation" form
  jQuery('#invitation_button').on('click', function() {
    var email = jQuery('#invit_user #user_email').val();
    var dataString = 'user[email]='+ email;
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
