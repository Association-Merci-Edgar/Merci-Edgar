class Coupon < ActiveRecord::Base
  after_initialize :set_code
  validates_uniqueness_of :code
  validates_presence_of :code
  attr_accessible :promoter, :event, :distributed
  # LENGTH = 6
  
  def set_code
    self.code = rand(36**6).to_s(36).upcase until self.valid?
  end
  
  def status
    if self.account_id
      Account.find(self.account_id).name
    else
      distributed? ? "En cours de disbtribution" : "A distribuer"
    end
  end
end