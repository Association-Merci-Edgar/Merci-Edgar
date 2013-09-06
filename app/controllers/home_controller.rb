class HomeController < AppController
  def index
    if params[:empty] == "1"
      render "empty"
    end
  end
end
