class PeopleStructure < ActiveRecord::Base
  attr_accessible :title, :structure_id, :structure_type, :structure_name, :structure_city, :structure_country
  belongs_to :person
  belongs_to :structure, polymorphic:true, class_name: "Contact"

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

  def structure_name=(name)
    @name = name
  end

  def structure_city=(city)
    @city = city
  end

  def structure_country=(country)
    @country = country
  end

  def set_structure
    v = Venue.where(name: @name).joins(:addresses).where(addresses:{city: @city, country: @country}).first_or_initialize
    if v.new_record?
      v.addresses.build(city: @city, country: @country)
      v.save
      self.structure_id = v.id
      self.structure_type = "Venue"
    end
  end
end