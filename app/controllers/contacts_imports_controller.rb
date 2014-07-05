class ContactsImportsController < AppController
  def new
    @import = ContactsImport.new
  end
  
  def edit
    @import = ContactsImport.find(params[:id])
  end
  
  def create_fake
    @import = ContactsImport.find(4)
    @job_id = ContactsImportWorker.perform_async(@import.id)
    render "test_mode_create"
  end
  
  def create
    @import = ContactsImport.new(params[:contacts_import])
    @import.user = current_user
    @import.account = current_account
    @import.test_mode = (params[:commit] == t('helpers.submit.contacts_import.test'))
    
    if @import.save
      @job_id = ContactsImportWorker.perform_async(@import.id)
      
      if @import.test_mode
        @job_url = job_path(@job_id)
        render "test_mode_create"
      end
      # render "create.js"
    else
      render "new"
    end
  end
  
  def update
    @import = ContactsImport.find(params[:id])
    @import.user = current_user
    @import.account = current_account
    @import.test_mode = (params[:commit] == t('helpers.submit.contacts_import.test'))
    if @import.update_attributes(params[:contacts_import])
      @job_id = ContactsImportWorker.perform_async(@import.id)
      
      if @import.test_mode
        @job_url = job_path(@job_id)
        render "test_mode_create"
      else
        render "create"
      end
      
    else
      render "edit"
    end
  end
    
end