
class VenuesController < AppController
  include ApplicationHelper

  # GET /venues
  # GET /venues.json
  def index
    if params[:kind]
      @filtered_by = "(#{params[:kind]})"
      @contacts = Venue.order(:name).by_type(params[:kind]).page params[:page]
    else
      @contacts = Venue.order(:name).page params[:page]
    end
    respond_to do |format|
      format.html { render "contacts/index"}
      format.json { render json: @contacts }
    end
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    @venue = Venue.find(params[:id])
    add_asset(@venue)
    @people = @venue.people
    @tasks = @venue.tasks
    @pending_tasks = @tasks.pending
    @completed_tasks = @tasks.completed
    @reportings = @venue.reportings
    @reporting = @venue.reportings.build
  end

  # GET /venues/new
  # GET /venues/new.json
  def new
    session[:return_to] = request.referer
    @venue = Venue.new
    @venue.addresses.build
    @venue.rooms.build

    respond_to do |format|
      format.html
      format.json { render json: @venue }
    end
  end

  # GET /venues/1/edit
  def edit
    @venue = Venue.find(params[:id])
    add_asset(@venue)
    @venue.build_venue_info unless @venue.venue_info.present?
    @venue.rooms.build(name:@venue.name) unless @venue.rooms.any?
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(params[:venue])
    add_asset(@venue)

    respond_to do |format|
      if @venue.save
        format.html do
          if params[:commit] == t("helpers.submit.venue.create")
            redirect_to @venue, notice: t("activerecord.notices.models.venue.created", name: @venue.name)
          else
            redirect_to edit_venue_path(@venue), notice: t("activerecord.notices.models.venue.created", name: @venue.name)
          end
        end
        format.json { render json: @venue, status: :created, location: @venue }
      else
        @venue.addresses.build unless @venue.addresses.any?
        format.html { render action: "new" }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /venues/1
  # PUT /venues/1.json
  def update
    @venue = Venue.find(params[:id])

    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        format.html do
          session.delete(:return_to)
          redirect_to @venue, notice: t("activerecord.notices.models.venue.updated", name: @venue.name)
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue_id = params[:id]
    @venue = Venue.find(@venue_id)
    @venue.destroy

    respond_to do |format|
      format.html { redirect_to venues_url }
      format.js { render "destroy" }
    end
  end

  def set_main_contact
    @venue = Venue.find(params[:venue_id])
    @old_contact = @venue.relative
    @contact = Person.find(params[:id])
    @venue.main_contact = @contact
    @venue.save
  end
end
