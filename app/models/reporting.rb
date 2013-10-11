class Reporting < ActiveRecord::Base
  attr_accessible :asset_id, :asset_type, :note_report_content, :project_id
  belongs_to :asset, polymorphic:true
  belongs_to :report, polymorphic:true
  belongs_to :project
  belongs_to :user

  def note_report_content=(content)
    self.report = NoteReport.new(content: content)
  end
  
  def note_report_content
    self.report.content if self.report
  end
end
