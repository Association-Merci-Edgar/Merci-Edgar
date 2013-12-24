class HomeController < AppController
  def index
    puts "in home controller !!!!!!!!!!!!!"
    if current_user.has_role? :admin
      redirect_to users_path
    else

      puts "welcome hidden ?"
      if !current_user.welcome_hidden?
        puts "redirect to welcome"
        redirect_to welcome_path
        return
      end
      if params[:empty] == "1"
        render "empty"
      end
      @pending_tasks = Task.pending.limit(2)
    end
  end
end
