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
  attr_accessible :name, :venue_info_attributes
  has_many :tasks, :as => :asset
  has_one :venue_info, :dependent => :destroy
  accepts_nested_attributes_for :venue_info
  accepts_nested_attributes_for :addresses, :allow_destroy => true

  delegate :capacities, :kind, :height, :depth, :width, to: :venue_info, allow_nil: true
  validates :name, :presence => true
  validate :venue_must_have_at_least_one_address
  validate :venue_name_must_be_unique_by_city, :on => :create

  has_many :taggings, as: :asset
  has_many :styles, through: :taggings, source: :tag, class_name: "Style"


  def venue_must_have_at_least_one_address
    if self.addresses.blank?
      errors.add(:addresses, "A venue must have at least one address")
    end
  end

  def venue_name_must_be_unique_by_city
    if addresses.first.city
      unless Venue.joins(:addresses).where(:addresses => {:city => addresses.first.city, :country => addresses.first.country}, :contacts => {:name => name}).blank?
        errors.add(:name, :taken, city: addresses.first.city)
      end
    end
  end

  def to_param
    [id, name.parameterize].join('-')
  end

  def style_list
    styles.map(&:name).join(", ")
  end

  def style_list=(names)
    self.styles = names.split(",").map do |n|
      Style.where(name: n.strip).first_or_create!
    end
  end
end
