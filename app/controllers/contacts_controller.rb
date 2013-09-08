class ContactsController < AppController
  def index
    if params[:empty] == "1"
      render "empty"
    else
      if params[:tag]
        @filtered_by = "(#{params[:tag]})"
        @contacts = Kaminari.paginate_array(Contact.tagged_with(params[:tag])).page params[:page]
      else
        @contacts = Contact.search(params[:search]).page params[:page]
      end
    end
  end

  def only
    @contacts = case params[:filter]
      when "favorites" then current_user.favorites.page params[:page]
      when "contacted" then Contact.with_reportings.page params[:page]
      else
        redirect_to contacts_path
        return
    end
    @filtered_by = t(params[:filter])
    render "index"
  end

  def add_to_favorites
    @contact = Contact.find(params[:id])
    if @contact
      current_user.add_to_favorites(@contact)
      if current_user.save
        render "add_to_favorites"
      end
    end
  end

  def remove_to_favorites
    @contact = Contact.find(params[:id])
    if @contact
      current_user.remove_to_favorites(@contact)
      if current_user.save
        render "remove_to_favorites"
      end
    end
  end
end