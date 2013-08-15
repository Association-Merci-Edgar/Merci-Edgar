# == Schema Information
#
# Table name: contacts
#
#  id               :integer          not null, primary key
#  phone            :string(255)
#  email            :string(255)
#  website          :string(255)
#  street           :string(255)
#  postal_code      :string(255)
#  state            :string(255)
#  city             :string(255)
#  country          :string(255)
#  contactable_id   :integer
#  contactable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Contact do
  pending "add some examples to (or delete) #{__FILE__}"
end
