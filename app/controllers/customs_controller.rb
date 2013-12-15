class CustomsController < AppController
  def index
    customs = Custom.order(:custom)
    customs = customs.where("custom LIKE ?", "%#{params[:term]}%") if params[:term].present?
    render json: customs.pluck(:custom).to_json
  end
end