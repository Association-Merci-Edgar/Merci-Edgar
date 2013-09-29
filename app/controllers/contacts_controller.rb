class ContactsController < AppController
  def index
    if params[:tag]
      @filtered_by = "(#{params[:tag]})"
      @contacts = Contact.tagged_with(params[:tag]).page params[:page]
    else
      @contacts = Contact.search(params[:search]).page params[:page]
    end
    if @contacts.size < 1
      render 'empty'
    end
  end

  def show_map
    if params[:address].present?
      radius = params[:radius] || 100
      contacts = Address.near(params[:address], radius, units: :km)
    else
      contacts = Address.all
    end
    @contacts_json = contacts.to_gmaps4rails do |address, marker|
      marker.infowindow render_to_string(:partial => "contacts/infowindow_#{address.contact.type.downcase}", :locals => { :contact => address.contact})
      marker.title   address.contact.name
      # marker.sidebar render_to_string(address.contact)
      # marker.json({ :id => address.id, :foo => "bar" })
    end if contacts.present?
  end

  def only
    @contacts = case params[:filter]
      when "favorites" then current_user.favorites.page params[:page]
      when "contacted" then Contact.with_reportings.page params[:page]
      when "dept" then Contact.by_department(params[:no]).page params[:page]
      when "capacities_less_than" then Venue.capacities_less_than(params[:nb]).page params[:page]
      when "capacities_more_than" then Venue.capacities_more_than(params[:nb]).page params[:page]
      when "capacities_between" then Venue.capacities_between(params[:nb1],params[:nb2]).page params[:page]
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