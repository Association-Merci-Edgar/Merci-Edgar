class Structure < Contact
  # attr_accessible :title, :body
  has_and_belongs_to_many :people
end
