ClientSideValidations.formBuilders['NestedForm::SimpleBuilder'] = ClientSideValidations.formBuilders['SimpleForm::FormBuilder'];
$('form').on('nested:fieldAdded', function(event) {
  $(event.target).find(':input').enableClientSideValidations();
});
