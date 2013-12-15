# encoding: utf-8
# == Schema Information
#
# Table name: people_structures
#
#  id           :integer          not null, primary key
#  person_id    :integer
#  structure_id :integer
#  title        :string(255)
#

class PeopleStructure < ActiveRecord::Base
  attr_accessible :title, :structure, :structure_attributes, :structure_name
  belongs_to :person
  belongs_to :structure

  accepts_nested_attributes_for :structure

  def structure_name
    self.structure.name if self.structure
  end

  def structure_name=(name)
    self.structure = Structure.joins(:contact).where(contacts: {name:name}).first_or_initialize
    self.structure.build_contact(name: name) unless self.structure.contact.present?
  end

  def to_s
    [title, structure.name].compact.join(" à ")
  end

end
