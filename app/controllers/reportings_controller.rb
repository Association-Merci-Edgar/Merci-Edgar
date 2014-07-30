class ReportingsController < AppController
  def create
    project_id = params[:reporting].delete(:project)
    @reporting = Reporting.new(params[:reporting])
    @reporting.project_id = project_id if project_id
    @reporting.user = current_user
    if @reporting.save
      # before in js
      # render "reportings/create"}
      
      # now with ember
      render :show, status: :created, location: @reporting
      
    else
      redirect_to @reporting.asset.fine_model, notice: "Une erreur est survenue"
    end
  end

  def update
    project_id = params[:reporting].delete(:project)
    @reporting = Reporting.find(params[:id])
    @reporting.project_id = project_id if project_id
    @reporting.user = current_user
    @reporting.update_attributes(params[:reporting])
    render :show, status: :ok, location: @reporting
  end

  def index
    contact = Contact.find(params[:contact_id])
    @reportings = contact.reportings
  end
  
  def destroy
    reporting = Reporting.find(params[:id])
    reporting.destroy
    head :no_content
  end
end
