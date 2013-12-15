# == Schema Information
#
# Table name: schedulings
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  show_host_id   :integer
#  show_host_type :string(255)
#  show_buyer_id  :integer
#  scheduler_id   :integer
#  period         :string(255)
#  contract_tags  :string(255)
#  style_tags     :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Scheduling do
  pending "add some examples to (or delete) #{__FILE__}"
end
