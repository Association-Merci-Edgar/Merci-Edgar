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
end
