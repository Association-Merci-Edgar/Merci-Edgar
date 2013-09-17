# encoding: utf-8
class VenueInfo < ActiveRecord::Base
  attr_accessible :capacities_attributes, :depth, :height, :kind, :width, :bar, :residency, :accompaniment, :remark, :period, :start_scheduling, :end_scheduling
  belongs_to :venue
  has_many :capacities, :dependent => :destroy
  accepts_nested_attributes_for :capacities
  
  def stage
    [self.depth, self.width, self.height].join(" x ")
  end
  
  def period
    super || "Non précisé" unless self.new_record?
  end
end
