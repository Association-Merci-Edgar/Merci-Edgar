class ImportsController < AppController
  def new
    @import = Import.new
  end
  
  def create
    @import = Import.new(params[:import])
    if @import.valid?
      uploader = XmlImportUploader.new
      uploader.store!(@import.filename)
      logger.info "uploader url: #{uploader.url}"
      @job_id = XmlImportWorker.perform_async(Account.current_id, uploader.url, @import.custom_tags)
      render "create"
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
  end
end