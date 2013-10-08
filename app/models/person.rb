# encoding: utf-8
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
  has_many :structures, through: :people_structures, uniq:true, source: :structure
  has_many :people_structures, dependent: :destroy
  validates_presence_of :first_name
  validates_presence_of :last_name
  alias_attribute :last_name, :name

  accepts_nested_attributes_for :people_structures, :reject_if => :all_blank

  def other_people_structures
    self.people_structures.where("structure_id != ?", self.relative.id)
  end

  def main_people_structure
    self.people_structures.where(structure_id: self.relative.id).first if self.people_structures.present?
  end

  def to_s
    [self.first_name, self.last_name].compact.join(' ')
  end

  def title(structure)
    structure.people_structures.where(person_id:self.id).first.title if structure.present?
  end

  def info_contact(structure)
    [self.title(structure), self.phone_number, self.email_address].compact.join(' — ')
  end

  def relative
    self.main_contact ||= self.structures.first
  end

  def main_contact?(structure)
    structure.main_contact == self
  end

  amoeba do
    enable
    include_field :emails
    include_field :phones
    include_field :addresses
    include_field :websites
    include_field :taggings
  end

  def my_dup
    Contact.unscoped do
      self.amoeba_dup
    end
  end

end
