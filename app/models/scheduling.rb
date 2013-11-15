class Scheduling < ActiveRecord::Base
  belongs_to :scheduler
  belongs_to :show_host, polymorphic: true
  belongs_to :show_buyer
  has_many :prospectings, dependent: :destroy

  attr_accessible :period, :contract_list, :prospectings_attributes


  accepts_nested_attributes_for :prospectings, :reject_if => :all_blank, :allow_destroy => true

  def period
    super || "Non precise" unless self.new_record?
  end


  def making_prospecting?(m=nil)
    if prospectings.any?
      m ||= Time.zone.now.month
      return prospectings.any? do |s|
        m += 12 if s.end_month < s.start_month && m < s.start_month
        end_month = s.end_month < s.start_month ? s.end_month + 12 : s.end_month
        s.start_month <= m && end_month >= m
      end
    else
      return false
    end
  end

  def contract_list
    self.contract_tags.split(',') if self.contract_tags.present?
  end

  def contract_list=(contracts)
    self.contract_tags = contracts.join(',') if contracts.present?
  end


end
