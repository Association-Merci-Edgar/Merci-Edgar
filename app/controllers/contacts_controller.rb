class ContactsController < AppController
  def index
    @contacts = Contact.advanced_search(params)
    
    @contacts = @contacts.page params[:page]
    if @contacts.present? == false
      render 'empty'
    end
  end

  def show_map
    if params[:address].present?
      radius = params[:radius] || 100
      contacts = Address.where(account_id: Account.current_id).near(params[:address], radius, units: :km)
    else
      contacts = Address.where(account_id: Account.current_id)
    end
    @contacts_json = contacts.to_gmaps4rails do |address, marker|
      marker.infowindow render_to_string(:partial => "contacts/infowindow_#{address.contact.type.downcase}", :locals => { :contact => address.contact})
      marker.title   address.contact.name
      # marker.sidebar render_to_string(address.contact)
      # marker.json({ :id => address.id, :foo => "bar" })
    end if contacts.present?
  end

  def only
    @no_paging = false
    @contacts = case params[:filter]
      when "favorites" then current_user.favorites.page params[:page]
      when "contacted" then Contact.with_reportings.page params[:page]
      when "recently_created" then 
        @no_paging = true
        Contact.recently_created
      when "recently_updated" then 
        @no_paging = true
        Contact.recently_updated
      when 'style' then 
        @param_filter = params[:name]
        Contact.by_style(params[:name]).page params[:page]
      when 'network' then 
        @param_filter = params[:name]
        Contact.by_network(params[:name]).page params[:page]
      when 'custom' then 
        @param_filter = params[:name]
        Contact.by_custom(params[:name]).page params[:page]
      when 'contract' then 
        @param_filter = params[:name]
        Venue.by_contract(params[:name]).page params[:page]
      when "dept" then 
        @param_filter = params[:no]
        Contact.by_department(params[:no]).page params[:page]
      when "capacities_less_than" then 
        @param_filter = params[:nb]
        Venue.capacities_less_than(params[:nb]).page params[:page]
      when "capacities_more_than" then 
        @param_filter = params[:nb]
        Venue.capacities_more_than(params[:nb]).page params[:page]
      when "capacities_between" then 
        @param_filter = [params[:nb1],params[:nb2]].join(" => ")
        Venue.capacities_between(params[:nb1],params[:nb2]).page params[:page]
      else
        redirect_to contacts_path
        return
    end
    @filtered_by = t(params[:filter], scope:"filters")
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