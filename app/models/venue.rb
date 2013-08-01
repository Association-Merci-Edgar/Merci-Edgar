class Venue < ActiveRecord::Base
  attr_accessible :name, :contact_attributes
  has_one :contact, :as => :contactable
  accepts_nested_attributes_for :contact
  default_scope { where(:account_id => Account.current_id) }
  #validates_associated :contact
  validates :name, :presence => true, :venue_name => true
end
