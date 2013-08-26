class PeopleStructure < ActiveRecord::Base
  belongs_to :person
  belongs_to :structure
end