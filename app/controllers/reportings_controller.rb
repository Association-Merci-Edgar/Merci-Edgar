class ReportingsController < ApplicationController
  def create
    @reporting = Reporting.new(params[:reporting])
    @reporting.user = current_user
    if @reporting.save
      render "reportings/create"
    else
      redirect_to reporting.asset, notice: "Une erreur est survenue"
    end
  end

  def update
    @reporting = Reporting.find(params[:id])
    @reporting.user = current_user
    if @reporting.update_attributes(params[:reporting])
      render "reportings/update"
    else
      redirect_to reporting.asset, notice: "Une erreur est survenue"
    end
  end
      
end
