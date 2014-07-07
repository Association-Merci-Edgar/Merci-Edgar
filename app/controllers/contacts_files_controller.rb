class ContactsFilesController < AppController
  def new
    @uploader = ContactsImport.new.contacts_file
    @uploader.success_action_redirect = new_contacts_import_url
  end
  
  def edit
    import = ContactsImport.find(params[:id])
    @uploader = import.contacts_file
    @uploader.success_action_redirect = edit_contacts_import_url(params)
  end
end