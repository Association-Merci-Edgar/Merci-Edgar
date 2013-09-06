class ReportingsController < ApplicationController
  def create
    reporting = Reporting.new(params[:reporting])
    reporting.user = current_user
    if reporting.save
      redirect_to reporting.asset
    else
      redirect_to reporting.asset, notice: "Une erreur est survenue"
    end
  end
end
