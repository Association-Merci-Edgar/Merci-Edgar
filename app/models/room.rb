# encoding: utf-8
class Room < ActiveRecord::Base
  belongs_to :venue, touch:true
  has_many :capacities
  validates_presence_of :name
  validates :depth, :height, :width, numericality:true, allow_nil:true
  attr_accessible :capacities_attributes, :bar, :depth, :height, :name, :width
  accepts_nested_attributes_for :capacities, :reject_if => proc { |attributes| attributes[:nb].blank? }, allow_destroy:true

  def stage
    self.depth.present? || self.width.present? || self.height.present? ? [self.depth, self.width, self.height].join(" x ") : "Non précisé"
  end

end
