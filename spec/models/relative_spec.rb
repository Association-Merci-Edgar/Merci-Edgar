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

require 'spec_helper'

describe Relative do
  pending "add some examples to (or delete) #{__FILE__}"
end
