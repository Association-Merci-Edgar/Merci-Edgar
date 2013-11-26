# == Schema Information
#
# Table name: structures
#
#  id                :integer          not null, primary key
#  structurable_id   :integer
#  structurable_type :string(255)
#  avatar            :string(255)
#  account_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Structure do
  pending "add some examples to (or delete) #{__FILE__}"
end
