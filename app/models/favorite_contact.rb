class FavoriteContact < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact
  validates :contact_id, uniqueness: {scope: :user_id}
  # attr_accessible :title, :body
end
