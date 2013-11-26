# == Schema Information
#
# Table name: opportunities
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Opportunity < ActiveRecord::Base
  # attr_accessible :title, :body
end
