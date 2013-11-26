# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  depth      :float
#  width      :float
#  height     :float
#  bar        :boolean
#  venue_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Room do
  pending "add some examples to (or delete) #{__FILE__}"
end
