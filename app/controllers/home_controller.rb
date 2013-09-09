class HomeController < AppController
  def index
    if params[:empty] == "1"
      render "empty"
    end
    @pending_tasks = Task.pending.limit(2)
  end
end
