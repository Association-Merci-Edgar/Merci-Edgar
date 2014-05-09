
$('#contact-file-type input.radio_buttons').on('click', function (event) {
  //event.stopPropagation(); event.preventDefault();
  //$('.new_reporting textarea').val("");
  if ( $(this).closest('span').hasClass('xml') ) {
    console.log("xml");
    //$('#first_name_last_name').addClass('hidden');
    $('#first_name_last_name').slideUp(200);
  } else {
    //$('#first_name_last_name').removeClass('hidden');
    $('#first_name_last_name').slideDown(200);
  }
  
});
