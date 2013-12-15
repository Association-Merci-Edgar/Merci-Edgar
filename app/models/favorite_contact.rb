# == Schema Information
#
# Table name: favorite_contacts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  contact_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FavoriteContact < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact
  validates :contact_id, uniqueness: {scope: :user_id}
  # attr_accessible :title, :body
end
