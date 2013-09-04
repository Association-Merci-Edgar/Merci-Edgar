class VenueInfo < ActiveRecord::Base
  attr_accessible :capacities_attributes, :depth, :height, :kind, :width, :bar, :residency, :accompaniment, :remark, :period
  belongs_to :venue
  has_many :capacities, :dependent => :destroy
  accepts_nested_attributes_for :capacities
end
