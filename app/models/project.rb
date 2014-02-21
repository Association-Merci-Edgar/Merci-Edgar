# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  account_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  avatar      :string(255)
#

class Project < ActiveRecord::Base
  attr_accessible :description, :name, :avatar
  default_scope { where(:account_id => Account.current_id) }
  mount_uploader :avatar, AvatarUploader
  
  def to_s
    name
  end
end
