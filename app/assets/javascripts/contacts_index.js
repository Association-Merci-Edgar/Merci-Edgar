
//___________________________________________________ popovers
var tmp = $.fn.popover.Constructor.prototype.show;
$.fn.popover.Constructor.prototype.show = function () {
  tmp.call(this); if (this.options.callback) { this.options.callback();
    }
};

$('.filters-stage [data-role="close"]').hide();

$('.filters-stage [data-role="close"]').click(function() {  $('.filters-stage .tag-actor').remove(); });


$('.filters-pool .tag').popover({callback: function() {
  //$(".popover-content").find("input").focus();
  $(".popover-content").find("[autofocus]:first").focus();
  
  $('.popover').find(".btn[type='submit']").click(function () {
      //___________________________________________________ actions on click on the OK button here :
      //some AJAX here ??
      $('.popover').each(function(){
          //$theFiltervalue = undefined;
          $theFiltervalue = $(this).find("input").val();
          //alert ( $(this.previousSibling).html() ); // access to the trigger element
          //alert ( $(this.previousSibling).html() );
          if ($theFiltervalue != "") {
            $('.filters-stage').append( "<a class='tag tag-actor' href='#'><span class='close'>x</span>"+ $theFiltervalue +"</a>" );
            $('.filters-stage [data-role="close"]').show();
          }
          $(this.previousSibling).popover('hide');
      });


      //___________________________________________________ actions on click on the tag-actor here : ( = remove a filter)
      //some AJAX here ??
      $('.filters-stage .tag-actor').click(function() {  $(this).remove();});   
      
    });
  },
  placement:"bottom", animation: false
});




$('html').on('mouseup', function(e) {
    if(!$(e.target).closest('.popover').length) {
        $('.popover').each(function(){
            $(this.previousSibling).popover('hide');
        });
    }
});


//$('#f_type').popover({placement:"bottom"});
//$('#f_style').popover();

/* Boostrap V3 ....
$(".popover").on('shown.bs.popover', function () {
  alert ("g");
        $(this).find("[autofocus]:first").focus();
});
*/




//___________________________________________________ heigh auto animation

//$('.filters-pool .tag').click(function() {  $(".dd").hide();}
/*
$(".filters-trigger").click(function () {
  
  $(".filters-outercontainer").toggle(function(){
	  var el = $(".filters-outercontainer"),
          curHeight = el.height(),
          autoHeight = el.css('height', 'auto').height(); //temporarily change to auto and get the height.

          el.height(curHeight).animate({ height: autoHeight }, 600, function() {
               //Now, change the height to auto when animation finishes. 
               //Added to make the container flexible (Optional).
               el.css('height', 'auto'); 
          });
       
  }     ,function(){
     $(this).animate({height:0},200);
     
    });
  });
  */
  
  //$(".filters-outercontainer").css("height", 0);	
  	$(".filters-trigger").click(function () {
  	  $(this).toggleClass("active");
  		$('.filters-outercontainer').toggleClass("open");
  		/*$(".filters-outercontainer").toggle(function(){

           $(this).css("height", "auto");
            theH = $(this).height;
            $(this).animate({height:theH},200);
        },function(){


         $(this).animate({height:0},200);

        });*/

  		//$(".filters-outercontainer").animate({height:'toggle'});

  	});
  	 //$(this).slideDown(2000);
  	//$(this).slideUp(2000);


  	//alert ("yo");
