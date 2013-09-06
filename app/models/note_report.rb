class NoteReport < ActiveRecord::Base
  attr_accessible :content
  belongs_to :asset, polymorphic: true
end
