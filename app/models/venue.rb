class Venue < ActiveRecord::Base
  attr_accessible :name, :contact_datum_attributes, :capacities_attributes
  has_one :contact_datum, :as => :contactable
  #has_one :contact, :as => :contactable
  has_many :capacities

  accepts_nested_attributes_for :contact_datum
  accepts_nested_attributes_for :capacities

  default_scope { where(:account_id => Account.current_id) }

  #validates :name, :presence => true, :venue_name => true, :on => :create
  validates :name, :presence => true
end
