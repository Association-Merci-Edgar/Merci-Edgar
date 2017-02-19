class Project < ActiveRecord::Base
  validates :name, length: {maximum: 255}
  attr_accessible :description, :name, :avatar

  default_scope { where(:account_id => Account.current_id) }

  mount_uploader :avatar, AvatarUploader

  def to_s
    name
  end
end
