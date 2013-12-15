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
  belongs_to :room, touch:true
  attr_accessible :kind, :nb, :modular
end
