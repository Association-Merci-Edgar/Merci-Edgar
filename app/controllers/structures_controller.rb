class StructuresController < AppController

  def index
    @structures = Structure.joins(:contact).order("contacts.name").where("lower(contacts.name) LIKE ?", "%#{params[:term].downcase}%")
    case params[:type]
    when "ShowBuyer"
      @structures = @structures.where(structurable_type: ["ShowBuyer"])
    when "ShowHost"
      @structures = @structures.where(structurable_type: ["Venue","Festival"])
    end
    json=[]
    unless @structures.map(&:name).map(&:downcase).include?(params[:term].downcase)
      if params[:type] == "ShowHost"
        json.push({value:params[:term], label: "Creer le lieu " + params[:term], new:"true", show_host_kind:"Venue"})
        json.push({value:params[:term], label: "Creer le festival " + params[:term], show_host_kind: "Festival", new:"true"})
      else  
        json.push({value:params[:term], label: "Creer la structure " + params[:term], new:"true"})
      end
    end
    @structures.each { |s| json.push({value:s.name, label:s.name, new: "false"}) }
    render json: json
  end
  
  def new
    session[:return_to] ||= request.referer
    @structure = Structure.new
    @structure.build_contact.addresses.build

    respond_to do |format|
      format.html
      format.json { render json: @structure }
    end
  end
  
  def create
    @structure = Structure.new(params[:structure])
    
    
    if @structure.save
      if params[:commit] == t("helpers.submit.venue.create")
        redirect_to @structure.fine_model, notice: t("activerecord.notices.models.structure.created", name: @structure.name)
      else
        edit_link_path = send("edit_#{@structure.fine_model.class.name.downcase}_path",@structure.fine_model)
        redirect_to edit_link_path, notice: t("activerecord.notices.models.structure.created", name: @structure.name)
      end
      
    else
      @structure.addresses.build unless @structure.addresses.any?
      render action: "new"
    end
    
  end

  def edit
    @structure = Structure.find(params[:id])
  end
  
  def update
    @structure = Structure.find(params[:id])

    respond_to do |format|
      if @structure.update_attributes(params[:structure])
        format.html do
          session.delete(:return_to)
          redirect_to @structure.fine_model, notice: t("activerecord.notices.models.structure.updated", name: @structure.name)
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @structure.errors, status: :unprocessable_entity }
      end
    end
  end
    

  def show
    @structure = Structure.find(params[:id])
    @people = @structure.people
    @tasks = @structure.tasks
    @pending_tasks = @tasks.pending
    @completed_tasks = @tasks.completed
    @reportings = @structure.reportings
    @reporting = @structure.reportings.build
  end

  def set_main_person
    @structure = Structure.find(params[:structure_id])
    @old_contact = @structure.main_person(current_user)
    @person = Person.find(params[:id])
    @structure.set_main_person(current_user,@person)
    @structure.save
  end

end
