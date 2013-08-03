class Capacity < ActiveRecord::Base
  belongs_to :venue
  attr_accessible :kind, :nb
end
