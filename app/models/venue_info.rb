# encoding: utf-8
class VenueInfo < ActiveRecord::Base
  attr_accessible :kind, :residency, :accompaniment, :remark, :period, :start_scheduling, :end_scheduling, :start_season, :end_season, :contract_list
  belongs_to :venue
  validates :start_scheduling, numericality: { only_integer:true, greater_than: 0, less_than: 13}, allow_blank: true
  validates :end_scheduling, numericality: { only_integer:true, greater_than: 0, less_than: 13}, allow_blank: true
  validates :start_season, numericality: { only_integer:true, greater_than: 0, less_than: 13}, allow_blank: true
  validates :end_season, numericality: { only_integer:true, greater_than: 0, less_than: 13}, allow_blank: true

  def period
    super || "Non précisé" unless self.new_record?
  end

  def contract_list
    self.contract_tags.split(',') if self.contract_tags.present?
  end

  def contract_list=(contracts)
    self.contract_tags = contracts.join(',') if contracts.present?
  end
end
