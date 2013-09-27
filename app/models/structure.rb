class Structure < Contact
  attr_accessible :name
  has_many :people_structures, dependent: :destroy
  has_many :people, :through => :people_structures, uniq:true, source: :person

  accepts_nested_attributes_for :people_structures


  def add_person(first_name,last_name,title)
    p = Person.find_or_initialize_by_first_name_and_name(first_name:first_name,name:last_name)
    ps = self.people_structures.build
    ps.person = p
    ps.title = title.titleize
    ps.save
  end
end