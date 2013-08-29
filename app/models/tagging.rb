class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :asset, polymorphic: true
  # attr_accessible :title, :body
end
