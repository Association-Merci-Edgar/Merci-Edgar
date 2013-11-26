# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  account_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  avatar      :string(255)
#

require 'spec_helper'

describe Project do
  pending "add some examples to (or delete) #{__FILE__}"
end
