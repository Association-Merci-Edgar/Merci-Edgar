# == Schema Information
#
# Table name: reportings
#
#  id          :integer          not null, primary key
#  report_id   :integer
#  report_type :string(255)
#  asset_id    :integer
#  asset_type  :string(255)
#  project_id  :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Reporting < ActiveRecord::Base
  attr_accessible :asset_id, :asset_type, :note_report_content, :project_id
  belongs_to :asset, polymorphic:true
  belongs_to :report, polymorphic:true
  belongs_to :project
  belongs_to :user
  validates :report, presence: true 
  validates_associated :report

  def note_report_content=(content)
    self.report = NoteReport.new(content: content)
  end
  
  def note_report_content
    self.report.content if self.report
  end
end
