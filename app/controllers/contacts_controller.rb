class ContactsController < AppController
  def index
    if params[:empty] == "1"
      render "empty"
    else
      if params[:tag]
        @filtered_by = "(#{params[:tag]})"
        @contacts = Kaminari.paginate_array(Contact.tagged_with(params[:tag])).page params[:page]
      else
        @contacts = Contact.search(params[:search]).order(:name).page params[:page]
      end
    end
  end

  def favorites
    @contacts = current_user.favorites.order(:name).page params[:page]
    @filtered_by = "Favoris"
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