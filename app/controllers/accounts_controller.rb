class AccountsController < ApplicationController
  def create
  end
  def edit
    @account = Account.find(Account.current_id)
  end

  def update
    @account = Account.find(Account.current_id)
    if @account.update_attributes(params[:account])
      redirect_to root_path, notice:"Chouette"
    else
      render :edit
    end
  end

  def import_samples
    @job_id = XmlImportWorker.perform_async(Account.current_id, ENV["SAMPLES_XML_DIR"], ENV["SAMPLES_XML_FILE"], nil)
    render 'contacts/import_samples'
  end
  
end
