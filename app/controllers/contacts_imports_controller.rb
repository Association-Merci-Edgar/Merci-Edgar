class ContactsImportsController < AppController
  def new
    @import = ContactsImport.new
  end
  
  def create
    @import = ContactsImport.new(params[:contacts_import])
    if @import.valid?
      @import.test_mode = (params[:commit] == t('helpers.submit.contacts_import.test'))
      uploader = ContactsImportUploader.new(Account.current_id.to_s)
      uploader.store!(@import.contact_file)
      @job_id = ContactsImportWorker.perform_async(Account.current_id, @import.filename, @import.options)
      redirect_to contacts_import_path(@job_id, test_mode: @import.test_mode)
    else
      render "errors"
    end
  end
  
  def show
    job_id = params[:id]
    status_container = SidekiqStatus::Container.load(job_id)
    @nb_imported_contacts = status_container.payload["nb_imported_contacts"]
    @nb_duplicates = status_container.payload["nb_duplicates"]
    @imported_at = status_container.payload["imported_at"]
    if params[:test_mode] == "true"
      render action: "test_mode_show"
    end
  end
end