class Structure < Contact
  # attr_accessible :title, :body
  # has_and_belongs_to_many :people
  has_many :people_structures
  has_many :people, :through => :people_structures, uniq: :true

  def add_person(first_name,last_name,title)
    p = self.people.find_or_initialize_by_first_name_and_last_name(first_name:first_name,last_name:last_name)
    ps = self.people_structures.build
    ps.person = p
    ps.title = title.titleize
    ps.save
  end
end
