class Relative < ActiveRecord::Base
  belongs_to :user
  belongs_to :person
  belongs_to :structure, class_name: "Structure"
  attr_accessible :user, :person, :structure
end
