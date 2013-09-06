class PeopleStructure < ActiveRecord::Base
  belongs_to :person
  belongs_to :structure, polymorphic:true

  def structure_type=(sType)
    super(sType.to_s.classify.constantize.base_class.to_s)
  end
end