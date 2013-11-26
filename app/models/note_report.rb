# == Schema Information
#
# Table name: note_reports
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class NoteReport < ActiveRecord::Base
  attr_accessible :content
  belongs_to :asset, polymorphic: true
end
