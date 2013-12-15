module StructureHelper
  def add_person(first_name,last_name,title)
    p = self.people.find_or_initialize_by_first_name_and_name(first_name:first_name,name:last_name)
    ps = self.people_structures.build
    ps.person = p
    ps.title = title.titleize
    ps.save
  end
end
