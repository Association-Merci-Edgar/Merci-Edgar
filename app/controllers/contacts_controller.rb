class ContactsController < AppController
  def index
    if request.xhr?
      @contacts = Contact.order(:name).where("lower(contacts.name) LIKE ?", "%#{params[:term].downcase}%").limit(10)
      json=[]
      @contacts.each do |c| 
        fm = c.fine_model
        link = send(fm.class.name.underscore + "_path", fm)
        json.push({value:c.name, label:c.name, new: "false", link: link, avatar: c.avatar_url(:thumb) })
      end
      unless @contacts.map(&:name).map(&:downcase).include?(params[:term].downcase)
        json.push({value:params[:term], 
          label: "Creer la structure : " + params[:term], new:"true", 
          link: new_structure_path(name: params[:term])
          })
        json.push({value:params[:term], 
          label: "Creer la personne : " + params[:term], new:"true", 
          link: new_person_path(name: params[:term])
          })
        
      end
      render json: json
      
      
    else
      if Contact.count == 0
        render "empty"
        return
      end
      if params[:commit] == "show map"
        if params[:address].present?
          radius = params[:radius].present? ? params[:radius] : 100
          contacts = Address.near(params[:address], radius, units: :km)
        else
          contacts = Address.where(account_id: Account.current_id)
        end

        contact_ids = Contact.advanced_search(params).pluck(:id)
        contacts = contacts.where(account_id: Account.current_id, contact_id: contact_ids)
        @contacts_json = contacts.to_gmaps4rails do |address, marker|
          contact = address.contact
          marker.infowindow render_to_string(:partial => "contacts/infowindow_venue", :locals => { :contact => contact})
          marker.title   address.contact.name
          # marker.sidebar render_to_string(address.contact)
          # marker.json({ :id => address.id, :foo => "bar" })
        end if contacts.present?
        render "show_map"
        
        
      else  
        @contacts = Contact.advanced_search(params).page params[:page]
        if params[:category].present?
          raise "Invalid Parameter" if %w(venues festivals show_buyers structures people).include?(params[:category]) == false
          @label_category = params[:category]
        end
      end
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
      model = address.contact.fine_model
      marker.infowindow render_to_string(:partial => "contacts/infowindow_#{model.class.name.downcase}", :locals => { :model => model})
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
        Kaminari.paginate_array(Contact.by_style(params[:name])).page params[:page]
      when 'network' then 
        @param_filter = params[:name]
        Contact.by_network(params[:name]).page params[:page]
      when 'custom' then 
        @param_filter = params[:name]
        Contact.by_custom(params[:name]).page params[:page]
      when 'contract' then 
        @param_filter = params[:name]
        Kaminari.paginate_array(Contact.by_contract(params[:name])).page params[:page]
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