class PeopleStructureSerializer < ActiveModel::Serializer
  attributes :id, :person_id, :structure_id, :title
  
  def person_id
    object.person.contact.id
  end
  
  def structure_id
    object.structure.contact.id
  end
end
