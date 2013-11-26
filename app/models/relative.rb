# == Schema Information
#
# Table name: relatives
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  person_id    :integer
#  structure_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Relative < ActiveRecord::Base
  belongs_to :user
  belongs_to :person
  belongs_to :structure, class_name: "Structure"
  attr_accessible :user, :person, :structure
end
