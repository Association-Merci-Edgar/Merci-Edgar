# == Schema Information
#
# Table name: capacities
#
#  id         :integer          not null, primary key
#  nb         :integer
#  kind       :string(255)
#  venue_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Capacity < ActiveRecord::Base
  belongs_to :room, touch:true
  attr_accessible :kind, :nb, :modular
end
