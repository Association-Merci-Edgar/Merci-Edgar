class Custom < ActiveRecord::Base
  default_scope { where(:account_id => Account.current_id) }
  validates :custom, presence: true
  validates_uniqueness_of :custom, scope: :account_id
  
  def self.add_custom(custom_name)
    c = Custom.new()
    c.custom = custom_name
    c.save
  end
  
  def self.add_customs(customs)
    customs.each { |c| add_custom(c) }
  end
  
end