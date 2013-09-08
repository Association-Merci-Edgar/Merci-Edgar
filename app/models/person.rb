# == Schema Information
#
# Table name: people
#
#  id             :integer          not null, primary key
#  first_name     :string(255)
#  last_name      :string(255)
#  account_id     :integer
#  structure_id   :integer
#  structure_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Person < Contact
  attr_accessible :first_name, :name, :people_structures_attributes
  has_many :structures, through: :people_structures, uniq: :true, source: :structure, source_type: "Contact"
  has_many :people_structures

  alias_attribute :last_name, :name

  accepts_nested_attributes_for :people_structures

  def to_s
    [self.first_name, self.last_name].compact.join(' ')
  end

end
