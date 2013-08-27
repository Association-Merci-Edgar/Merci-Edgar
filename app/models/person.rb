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
  attr_accessible :first_name, :name, :structure_id, :structure_type
  has_many :structures, through: :people_structures, uniq: :true
  has_many :people_structures
  before_validation :add_structure, :on => :create

  def structure_id=(sid)
    @structure_id = sid
  end

  def structure_type=(stype)
    @structure_type = stype
  end

  private
  def add_structure
    if @structure_id.present? && @structure_type.present?
      structure = @structure_type.constantize.find(@structure_id)
      self.structures << structure
    end
  end
end
