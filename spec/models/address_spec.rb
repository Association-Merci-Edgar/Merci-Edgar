# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  street      :string(255)
#  postal_code :string(255)
#  city        :string(255)
#  state       :string(255)
#  country     :string(255)
#  kind        :string(255)
#  contact_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  latitude    :float
#  longitude   :float
#  more_info   :text
#  account_id  :integer
#

require 'spec_helper'

describe Address do
  pending "add some examples to (or delete) #{__FILE__}"
end
