class Announcement < ActiveRecord::Base
  attr_accessible :link, :published_at, :title
end
