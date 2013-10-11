class Project < ActiveRecord::Base
  attr_accessible :description, :name, :avatar
  default_scope { where(:account_id => Account.current_id) }
  mount_uploader :avatar, AvatarUploader
end
