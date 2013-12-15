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

require 'spec_helper'

describe Capacity do
  pending "add some examples to (or delete) #{__FILE__}"
end
