# encoding: utf-8
class VenueInfo < ActiveRecord::Base
  attr_accessible :kind, :residency, :accompaniment, :remark, :period, :start_scheduling, :end_scheduling
  belongs_to :venue

  def period
    super || "Non précisé" unless self.new_record?
  end
end
