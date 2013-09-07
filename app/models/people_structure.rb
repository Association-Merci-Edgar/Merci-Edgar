class PeopleStructure < ActiveRecord::Base
  attr_accessible :title, :structure_id, :structure_type, :structure_name, :structure_city, :structure_country
  belongs_to :person
  belongs_to :structure, polymorphic:true, class_name: "Contact"
  # attr_writer :structure_name, :structure_city, :structure_country

  before_validation :set_structure
  def structure_type=(sType)
    super(sType.to_s.classify.constantize.base_class.to_s)
  end

  def structure_name
    self.structure.name if self.structure
  end

  def structure_city
    self.structure.city if self.structure
  end

  def structure_country
    self.structure.country if self.structure
  end

  def structure_name_with_city_and_country(pattern)
    name, city, country = pattern.match(/(^.*)#(.*)#(.*)/i).captures
  end

  def set_structure
    self.structure = Structure.find_or_create_by(name: @name, city: @city, country: @country)
  end
end