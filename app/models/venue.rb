# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :integer
#

class Venue < Structure
  attr_accessible :name, :capacities_attributes
  has_many :capacities, :dependent => :destroy
  has_many :tasks, :as => :asset

  accepts_nested_attributes_for :capacities

  validates :name, :presence => true
  validate :venue_must_have_at_least_one_address
  validate :venue_name_must_be_unique_by_city, :on => :create


  def venue_must_have_at_least_one_address
    if self.addresses.blank?
      errors.add(:addresses, "A venue must have at least one address")
    end
  end

  def venue_name_must_be_unique_by_city
    if addresses.first
      unless Venue.joins(:addresses).where(:addresses => {:city => addresses.first.city}, :contacts => {:name => name}).blank?
        errors.add(:name,"Une salle existe deja avec ce nom dans la ville de #{addresses.first.city}")
      end
    end
  end

  def to_param
    [id, name.parameterize].join('-')
  end
end
