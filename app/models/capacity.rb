class Capacity < ActiveRecord::Base
  belongs_to :venue
  attr_accessible :kind, :nb
  before_validation :reset_kind, :if => "nb.blank?"

  def reset_kind
    self.kind = ""
  end
end
