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
  attr_accessible :name, :venue_info_attributes, :style_list, :network_list, :contract_ids, :people_structures_attributes, :rooms_attributes
  has_one :venue_info, :dependent => :destroy
  has_many :rooms, :dependent => :destroy
  before_save :format_strings

  delegate :kind, :period, :remark, :start_scheduling, :end_scheduling, to: :venue_info, allow_nil: true
  validates :name, :presence => true, uniqueness: { scope: :account_id}
  # validate :venue_must_have_at_least_one_address
#  validate :venue_name_must_be_unique_by_city, :on => :create
  validates_presence_of :addresses
  has_many :taggings, as: :asset
  has_many :styles, through: :taggings, source: :tag, class_name: "Style"
  has_many :networks, through: :taggings, source: :tag, class_name: "Network"
  has_many :contracts, through: :taggings, source: :tag, class_name: "Contract"
  has_many :cap_ranges, through: :taggings, source: :tag, class_name: "CapRange"
  accepts_nested_attributes_for :venue_info
  accepts_nested_attributes_for :rooms, :reject_if => proc { |attributes| attributes[:name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :rooms, :allow_destroy => true

  scope :by_type, (lambda do |kind|
    joins(:venue_info).where('venue_infos.kind = ?', kind) if kind.present?
  end)

  before_validation :sync_cap_ranges

  amoeba do
    enable
    set :account_id => Account.current_id
    include_field :emails
    include_field :phones
    include_field :addresses
    include_field :websites
    include_field :venue_info
    include_field :rooms
    include_field :taggings
  end

  def to_s
    name
  end

  def sync_cap_ranges
    # self.cap_ranges = []
    to_delete = []
    self.cap_ranges.each do |cap_range|
      case
      when cap_range.name == "< 100"
        if (self.capacities.map(&:nb).any? {|n| n < 100}) == false
          to_delete << cap_range
        end
      when cap_range.name == "< 500"
        if (self.capacities.map(&:nb).any? {|n| n < 500 && n > 100}) == false
          to_delete << cap_range
        end
      when cap_range.name == "> 500"
        if (self.capacities.map(&:nb).any? {|n| n > 500}) == false
          to_delete << cap_range
        end
      end
    end
    puts "todelete:"
    puts to_delete
    to_delete.each { |cap_range| self.cap_ranges.destroy cap_range }
    capacities.each do |c|
      tag_name = case
      when c.nb <  100
        "< 100"
      when c.nb < 500
        "100-500"
      else
        "> 500"
      end
      if self.cap_ranges.where(name: tag_name).blank?
        self.cap_ranges << CapRange.where(name: tag_name).first_or_create!
      end
    end
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

  def my_dup
    Contact.unscoped do
      dup = self.amoeba_dup
      self.people_structures.each do |ps|
        dup_ps = dup.people_structures.build
        dup_ps.title = ps.title
        p = Person.find_by_first_name_and_name_and_account_id(ps.person.first_name,ps.person.name,Account.current_id)
        if p.present?
          dup_ps.person = p
        else
          dup_ps.person = ps.person.my_dup
          dup_ps.person.save
        end
        # 
      end
      return dup
    end
  end

  def capacities
    cap = []
    self.rooms.each{|r| cap << r.capacities}
    cap.flatten
  end
  
  def format_strings
    self.name = self.name.titleize if self.name
  end

end
