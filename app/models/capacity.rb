# == Schema Information
#
# Table name: capacities
#
#  id         :integer          not null, primary key
#  nb         :integer
#  kind       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :integer
#  modular    :boolean
#

class Capacity < ActiveRecord::Base
  CAPACITY_MAX = 500000
  belongs_to :room, touch:true
  attr_accessible :kind, :nb, :modular
  validates :nb, numericality: { greater_than: 0, less_than: CAPACITY_MAX }
end
