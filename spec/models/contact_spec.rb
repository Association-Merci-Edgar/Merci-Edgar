# == Schema Information
#
# Table name: contacts
#
#  id               :integer          not null, primary key
#  contactable_id   :integer
#  contactable_type :string(255)
#  name             :string(255)
#  network_tags     :string(255)
#  custom_tags      :string(255)
#  remark           :text
#  account_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Contact do
  pending "add some examples to (or delete) #{__FILE__}"
end
