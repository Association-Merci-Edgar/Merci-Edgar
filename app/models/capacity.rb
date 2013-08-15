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
  belongs_to :venue
  attr_accessible :kind, :nb
  before_validation :reset_kind, :if => "nb.blank?"

  def reset_kind
    self.kind = ""
  end
end
