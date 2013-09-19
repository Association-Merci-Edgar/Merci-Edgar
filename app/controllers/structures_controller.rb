class StructuresController < ApplicationController

  def index
    @structures = Venue.order(:name).where("lower(name) LIKE ?", "%#{params[:term].downcase}%")
    json=[]
    @structures.each { |s| json.push({id:s.id, name:s.name, city:s.city, country:s.country}) }
    render json: @structures.map(&:name)
  end
end
