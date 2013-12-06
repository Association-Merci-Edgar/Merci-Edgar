class NetworksController < AppController
  def index
    networks = Network.order(:network)
    networks = networks.where("network LIKE ?", "%#{params[:term]}%") if params[:term].present?
    render json: networks.pluck(:network).to_json
  end
end