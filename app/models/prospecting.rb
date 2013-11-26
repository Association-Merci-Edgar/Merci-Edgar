# == Schema Information
#
# Table name: prospectings
#
#  id            :integer          not null, primary key
#  start_month   :integer
#  end_month     :integer
#  scheduling_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Prospecting < ActiveRecord::Base
  belongs_to :scheduling, touch: true
  attr_accessible :start_month, :end_month
  validates :start_month, numericality: { only_integer:true, greater_than: 0, less_than: 13}, presence: true
  validates :end_month, numericality: { only_integer:true, greater_than: 0, less_than: 13}, presence: true

  def to_s
    [start_month, end_month].map {|m| I18n.t("date.month_names")[m].titleize if m.present? }.compact.join(' - ')
  end
end
