# == Schema Information
#
# Table name: festivals
#
#  id           :integer          not null, primary key
#  nb_edition   :integer
#  last_year    :integer
#  artists_kind :string(255)
#  avatar       :string(255)
#  account_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Festival do
  pending "add some examples to (or delete) #{__FILE__}"
end
