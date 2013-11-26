# encoding: utf-8
# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  depth      :float
#  width      :float
#  height     :float
#  bar        :boolean
#  venue_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Room < ActiveRecord::Base
  belongs_to :venue, touch:true
  has_many :capacities, :dependent => :destroy
  validates_presence_of :name
  validates :depth, :height, :width, numericality:true, allow_nil:true
  attr_accessible :capacities_attributes, :bar, :depth, :height, :name, :width
  accepts_nested_attributes_for :capacities, :reject_if => proc { |attributes| attributes[:nb].blank? }, allow_destroy:true

  amoeba do
    enable
    include_field :capacities
  end

  def stage
    self.depth.present? || self.width.present? || self.height.present? ? [self.depth, self.width, self.height].join(" x ") : "Non précisé"
  end

end
