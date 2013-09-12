class PeopleStructure < ActiveRecord::Base
  attr_accessible :title, :structure, :structure_attributes, :structure_name
  belongs_to :person, class_name: "Contact"
  belongs_to :structure, class_name: "Contact"

  accepts_nested_attributes_for :structure

#  before_validation :set_structure
  def structure_name
    self.structure.name if self.structure
  end
  
  def structure_name=(name)
    self.structure = Venue.where(name:name).first_or_initialize
  end
end