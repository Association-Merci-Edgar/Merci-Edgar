class StylesController < AppController
  def index
    styles = Style.order(:style)
    styles = styles.where("style LIKE ?", "%#{params[:term]}%") if params[:term].present?
    render json: styles.pluck(:style).to_json
  end
end