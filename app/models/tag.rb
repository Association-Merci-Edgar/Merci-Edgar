class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :taggings

  def assets
    taggings.map(&:asset)
  end
end
