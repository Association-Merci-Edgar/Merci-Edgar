class FestivalsController < AppController
  include ApplicationHelper
  # GET /festivals
  # GET /festivals.json
  def index
    @festivals = Festival.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @festivals }
    end
  end

  # GET /festivals/1
  # GET /festivals/1.json
  def show
    @festival = Festival.find(params[:id])
    add_asset(@festival)
    @structure = @festival.structure
    @main_person = @festival.main_person(current_user)
    @people = @festival.structure.people
    @tasks = @festival.structure.tasks
    @pending_tasks = @tasks.pending
    @completed_tasks = @tasks.completed
    @reportings = @festival.structure.reportings
    @reporting = @festival.structure.reportings.build
  end

  # GET /festivals/new
  # GET /festivals/new.json
  def new
    @festival = Festival.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @festival }
    end
  end

  # GET /festivals/1/edit
  def edit
    @festival = Festival.find(params[:id])
    add_asset(@festival)
    @festival.schedulings.build(name: "Programmation") unless @festival.schedulings.any?
  
  end

  # POST /festivals
  # POST /festivals.json
  def create
    @festival = Festival.new(params[:festival])

    respond_to do |format|
      if @festival.save
        format.html { redirect_to @festival, notice: 'Festival was successfully created.' }
        format.json { render json: @festival, status: :created, location: @festival }
      else
        format.html { render action: "new" }
        format.json { render json: @festival.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /festivals/1
  # PUT /festivals/1.json
  def update
    @festival = Festival.find(params[:id])
    
    respond_to do |format|
      if @festival.update_attributes(params[:festival])
        format.html { redirect_to @festival, notice: 'Festival was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @festival.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /festivals/1
  # DELETE /festivals/1.json
  def destroy
    @festival = Festival.find(params[:id])
    @festival_id = params[:id]
    @festival = Venue.find(@festival_id)
    @festival.destroy

    respond_to do |format|
      format.html { redirect_to festivals_url }
      format.js { render "destroy" }
    end
  end
end
