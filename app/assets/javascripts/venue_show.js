
//______________________ New Entry - Cancel Button
$('.new_reporting .cancel').on('click', function (event) {
  event.stopPropagation(); event.preventDefault();
  $('.new_reporting textarea').val("");

});


//______________________ Existing Entry - Edit Button

$('#activity .list-large > li .editbtn').on('click', function (event) {
  event.stopPropagation();
  event.preventDefault();
  var $content = $(this).closest('li').find('.content');
  var $form = $(this).closest('li').find('form');
  var $textarea = $form.find('textarea');
  
  // remplit le textarea et 'trigger' l'autosize
  $textarea.val( $.trim( $content.text() )).trigger('autosize.resize');
  
  //cache / révéle les éléments
  $form.toggleClass('hidden');
  $content.toggleClass('hidden');
  $(this).toggleClass('hidden');
  $(this).closest('li').find('.cancel').toggleClass('hidden');
  
  $textarea.focus();
  
  //console.log($content);
  //event.preventDefault(); return false;
  
});



//______________________ Existing Entry - Submit Button

$('#activity .list-large > li button[type="submit"] ').on('click', function (event) {
  event.stopPropagation(); event.preventDefault();
  var $content = $(this).closest('li').find('.content');
  var $form = $(this).closest('li').find('form');

  $form.toggleClass('hidden');
  $content.toggleClass('hidden');
  $(this).closest('li').find('.editbtn').toggleClass('hidden');
  

});



//______________________ Existing Entry - Cancel Button
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
