class Venue < ActiveRecord::Base
  attr_accessible :name, :contact_datum_attributes, :capacities_attributes
  has_one :contact_datum, :as => :contactable, :dependent => :destroy
  has_many :people, :as => :structure
  #has_one :contact, :as => :contactable
  has_many :capacities, :dependent => :destroy

  accepts_nested_attributes_for :contact_datum
  accepts_nested_attributes_for :capacities

  default_scope { where(:account_id => Account.current_id) }

  validates :name, :presence => true
  #validates :name, :presence => true
  # validates_associated :contact_datum
  validates :contact_datum, :presence => :true
  validate :venue_must_have_at_least_one_address
  validate :venue_name_must_be_unique_by_city, :on => :create

  delegate :addresses, :phones, :websites, :emails, :to => :contact_datum

  def venue_must_have_at_least_one_address
    if !contact_datum || contact_datum.addresses.blank?
      errors.add(:contact_datum, "A venue must have at least one address")
    end
  end

  def venue_name_must_be_unique_by_city
    if contact_datum && addresses.first
      unless Venue.joins(:contact_datum => :addresses).where(:addresses => {:city => contact_datum.addresses.first.city}, :venues => {:name => name}).blank?
        errors.add(:name,"Une salle existe deja avec ce nom dans la ville de #{contact_datum.addresses.first.city}")
      end
    end
  end
end
