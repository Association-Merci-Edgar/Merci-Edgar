class PeopleController < ApplicationController
  # GET /people
  # GET /people.json
  def index
    @contacts = Person.order(:name).page params[:page]

    respond_to do |format|
      format.html { render "contacts/index"}
      format.json { render json: @contacts }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])
    @tasks = @person.tasks
    @pending_tasks = @tasks.pending

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new
    if params[:venue_id]
      @structure = Venue.find(params[:venue_id]) if params[:venue_id]
      @person.structures << @structure
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])
    @structure = Venue.find(params[:venue_id]) if params[:venue_id]

    respond_to do |format|
      if @person.save
        format.html { redirect_to @structure, notice: 'Person was successfully created.' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])
    @structure = Venue.find(params[:venue_id]) if params[:venue_id]

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @structure, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end
end
