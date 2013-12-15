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

class GenericStructure < Structure
end
