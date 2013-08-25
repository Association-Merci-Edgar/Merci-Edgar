class VenueInfo < ActiveRecord::Base
  attr_accessible :depth, :height, :kind, :width, :capacities_attributes
  belongs_to :venue
  has_many :capacities, :dependent => :destroy
  accepts_nested_attributes_for :capacities
end
