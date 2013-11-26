# == Schema Information
#
# Table name: reportings
#
#  id          :integer          not null, primary key
#  report_id   :integer
#  report_type :string(255)
#  asset_id    :integer
#  asset_type  :string(255)
#  project_id  :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Reporting do
  pending "add some examples to (or delete) #{__FILE__}"
end
