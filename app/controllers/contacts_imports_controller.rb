class ContactsImportsController < AppController
  def new
    @import = ContactsImport.new
  end
  
  def create
    contacts_import_params = params[:from_test_mode] == "true" ? session[:form_import_params] : params[:contacts_import]
    @import = ContactsImport.new(contacts_import_params)
    if @import.valid?
      @import.test_mode = (params[:commit] == t('helpers.submit.contacts_import.test'))
      if @import.contact_file
        uploader = ContactsImportUploader.new(Account.current_id.to_s)
        uploader.store!(@import.contact_file)
      end
      import_worker_options = @import.options.merge({user_id: current_user.id})
      @job_id = ContactsImportWorker.perform_async(Account.current_id, @import.filename, import_worker_options)
      session[:form_import_params] = @import.to_json if @import.test_mode
      
      redirect_to contacts_import_path(@job_id, test_mode: @import.test_mode)
      # render "create.js"
    else
      render "new"
    end
  end
  
  def show
    job_id = params[:id]
    status_container = SidekiqStatus::Container.load(job_id)
    @nb_imported_contacts = status_container.payload["nb_imported_contacts"]
    @nb_duplicates = status_container.payload["nb_duplicates"]
    @imported_at = status_container.payload["imported_at"]
    if params[:test_mode] == "true"
      @url = job_path(job_id)
      render action: "test_mode_show"
    end
  end
end