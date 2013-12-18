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
    logger.debug "account current_id: #{Account.current_id}"
    @job_id = SamplesImportWorker.perform_async(Account.current_id)
    render 'contacts/import_samples'
  end
  
  def import_samples_status
    jid = params[:id]
    logger.debug "jid: #{jid} "
    begin  
      status_container = SidekiqStatus::Container.load(jid)
      logger.debug "status: #{status_container.status.to_s} // #{status_container.at} // #{status_container.pct_complete}"
      render json: {:status => status_container.status, pct: status_container.pct_complete }      
    rescue
      render json: {:status => "job not found" }
    end
      
  end
end
