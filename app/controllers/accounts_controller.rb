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

  def duplicate_community
    if Contact.count < 1
      @job_id = ImportWorker.perform_async(Account.current_id)
      redirect_to contacts_path, notice: "Import initie"
    else
      redirect_to contacts_path, notice: "Pas d'import possible"
    end
  end
end
