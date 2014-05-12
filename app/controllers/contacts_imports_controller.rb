class ContactsImportsController < AppController
  def new
    @import = ContactsImport.new
  end
  
  def edit
    @import = ContactsImport.new(session[:form_import_params])
  end
  
  def create
    contacts_import_params = params[:contacts_import].present? ? params[:contacts_import] : session[:form_import_params]
    @import = ContactsImport.new(contacts_import_params)
    if @import.valid?
      @import.test_mode = (params[:commit] == t('helpers.submit.contacts_import.test'))
      if @import.contact_file
        uploader = ContactsImportUploader.new(Account.current_id.to_s)
        uploader.store!(@import.contact_file)
      end
      
      @import.user_id = current_user.id
      @import.imported_at = Time.zone.now.to_i
      @import.account_id = Account.current_id
      @job_id = ContactsImportWorker.perform_async(@import.to_json)
      session[:form_import_params] = @import.to_json if @import.test_mode
      
      if @import.test_mode
        @job_url = job_path(@job_id)
        render "test_mode_create"
      end
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
    @imported_at = params[:imported_at]
    if params[:test_mode] == "true"
      @job_url = job_path(job_id)
      render action: "test_mode_show"
    end
  end

end