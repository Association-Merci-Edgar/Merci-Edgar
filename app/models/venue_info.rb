# encoding: utf-8
class VenueInfo < ActiveRecord::Base
  attr_accessible :kind, :residency, :accompaniment, :remark, :period, :schedulings_attributes, :start_season, :end_season, :contract_list
  belongs_to :venue, touch: true
  has_many :schedulings, dependent: :destroy
  validates :start_season, numericality: { only_integer:true, greater_than: 0, less_than: 13}, allow_blank: true
  validates :end_season, numericality: { only_integer:true, greater_than: 0, less_than: 13}, allow_blank: true

  accepts_nested_attributes_for :schedulings, :reject_if => :all_blank, :allow_destroy => true

  def period
    super || "Non précisé" unless self.new_record?
  end

  def contract_list
    self.contract_tags.split(',') if self.contract_tags.present?
  end

  def contract_list=(contracts)
    self.contract_tags = contracts.join(',') if contracts.present?
  end

  def season
    [start_season, end_season].map {|m| I18n.t("date.month_names")[m].titleize if m.present? }.compact.join(' - ')
  end

  def making_scheduling?(m=nil)
    if schedulings.any?
      m ||= Time.zone.now.month
      return schedulings.any? do |s|
        m += 12 if s.end_month < s.start_month && m < s.start_month
        end_month = s.end_month < s.start_month ? s.end_month + 12 : s.end_month
        s.start_month <= m && end_month >= m
      end
    else
      return false
    end
  end
end
