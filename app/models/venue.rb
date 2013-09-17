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
  attr_accessible :name, :venue_info_attributes, :style_list, :network_list, :contract_ids, :people_structures_attributes
  has_one :venue_info, :dependent => :destroy

  delegate :capacities, :kind, :height, :depth, :width, :period, :stage, :remark, :start_scheduling, :end_scheduling, to: :venue_info, allow_nil: true
  validates :name, :presence => true, uniqueness: { scope: :account_id}
#  validate :venue_must_have_at_least_one_address
#  validate :venue_name_must_be_unique_by_city, :on => :create

  has_many :taggings, as: :asset
  has_many :styles, through: :taggings, source: :tag, class_name: "Style"
  has_many :networks, through: :taggings, source: :tag, class_name: "Network"
  has_many :contracts, through: :taggings, source: :tag, class_name: "Contract"

  accepts_nested_attributes_for :venue_info
  accepts_nested_attributes_for :addresses, :allow_destroy => true

  scope :by_type, (lambda do |kind|
    joins(:venue_info).where('venue_infos.kind = ?', kind) if kind.present?
  end)

  def to_s
    name
  end

  def venue_must_have_at_least_one_address
    if self.addresses.blank?
      errors.add(:addresses, "A venue must have at least one address")
    end
  end

  def venue_name_must_be_unique_by_city
    if addresses.any? && addresses.first.city
      unless Venue.joins(:addresses).where(:addresses => {:city => addresses.first.city, :country => addresses.first.country}, :contacts => {:name => name}).blank?
        logger.debug "city #{addresses.first.city}"
        errors.add(:name, :taken, city: addresses.first.city)
      end
    end
  end

  def to_param
    [id, name.try(:parameterize)].compact.join('-')
  end

  def style_list
    styles.map(&:name).join(", ")
  end

  def style_list=(names)
    self.styles = names.split(",").map do |n|
      Style.where(name: n.strip).first_or_create!
    end
  end

  def network_list
    networks.map(&:name).join(", ")
  end

  def network_list=(names)
    self.networks = names.split(",").map do |n|
      Network.where(name: n.strip).first_or_create!
    end
  end

  def relative
    self.main_contact ||= self.people.first
  end
end
