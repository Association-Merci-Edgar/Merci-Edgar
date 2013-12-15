class GenericStructuresController < ApplicationController
  def index
    @contacts = GenericStructure.order(:name).page params[:page]
    respond_to do |format|
      format.html { render "contacts/index"}
      format.json { render json: @contacts }
    end
  end

  def create
    @structure = GenericStructure.new(params[:generic_structure])

    respond_to do |format|
      if @structure.save
        format.html do
          if params[:commit] == t("helpers.submit.venue.create")
            redirect_to @structure, notice: t("activerecord.notices.models.venue.created", name: @structure.name)
          else
            redirect_to edit_generic_structure_path(@structure), notice: t("activerecord.notices.models.venue.created", name: @structure.name)
          end
        end
        format.json { render json: @structure, status: :created, location: @structure }
      else
        @structure.addresses.build unless @structure.addresses.any?
        format.html { render action: "new" }
        format.json { render json: @structure.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    session[:return_to] ||= request.referer
    @structure = GenericStructure.new
    @structure.addresses.build

    respond_to do |format|
      format.html
      format.json { render json: @structure }
    end
  end

  def edit
    @structure = GenericStructure.find(params[:id])
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


end