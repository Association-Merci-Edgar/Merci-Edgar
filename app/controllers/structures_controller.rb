class StructuresController < ApplicationController

  def index
    @structures = Venue.order(:name).where("lower(name) LIKE ?", "%#{params[:term].downcase}%")
    json=[]
    @structures.each { |s| json.push({id:s.id, name:s.name, city:s.city, country:s.country}) }
    render json: @structures.map(&:name)
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
    @structure = Structure.find(params[:id])
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
