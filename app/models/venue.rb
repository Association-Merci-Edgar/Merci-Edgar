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

class Venue < ActiveRecord::Base
  default_scope { where(:account_id => Account.current_id) }

  attr_accessible :kind, :residency, :accompaniment, :start_season, :end_season, :structure_attributes, :schedulings_attributes, :rooms_attributes, :network_tags

  attr_accessible :structure_attributes

  has_one :structure, as: :structurable
  accepts_nested_attributes_for :structure

  has_many :schedulings, as: :show_host, dependent: :destroy
  has_one :show_buyer, through: :scheduling
  accepts_nested_attributes_for :schedulings


  has_many :rooms, :dependent => :destroy
  accepts_nested_attributes_for :rooms, :allow_destroy => true

  validates :start_season, numericality: { only_integer:true, greater_than: 0, less_than: 13}, allow_blank: true
  validates :end_season, numericality: { only_integer:true, greater_than: 0, less_than: 13}, allow_blank: true


  delegate :name, :people, :tasks, :reportings, :remark, :addresses, :emails, :phones, :websites, :city, :address, :network_list, :custom_list, :contacted?, :favorite?, :main_person, to: :structure
  # validate :venue_must_have_at_least_one_address
#  validate :venue_name_must_be_unique_by_city, :on => :create
  # validates_presence_of :addresses

  mount_uploader :avatar, AvatarUploader

  scope :by_type, (lambda do |kind|
    where(kind: kind) if kind.present?
  end)

  scope :capacities_less_than, (lambda do |nb|
    joins(:rooms => :capacities).where("capacities.nb <= ?", nb).uniq
  end)

  scope :capacities_more_than, (lambda do |nb|
    joins(:rooms => :capacities).where("capacities.nb >= ?", nb).uniq
  end)

  scope :capacities_between, (lambda do |nb1,nb2|
    joins(:rooms => :capacities).where("capacities.nb BETWEEN ? AND ? ", nb1,nb2).uniq
  end)

  scope :by_contract, lambda { |tag_name| joins(:scheduling).where("schedulings.contract_tags LIKE ?", "%#{tag_name}%") }

  scope :making_prospecting, lambda { |month| joins(:schedulings => :prospectings).where("prospectings.start_month <= ? AND prospectings.end_month >= ?",month,month) }

  CAPACITY_RANGE_OPTIONS = ["< 100", "100-400","400-1200","> 1200"]

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

  def capacities
    cap = []
    self.rooms.each{|r| cap << r.capacities}
    cap.flatten
  end

  def capacity_tags
    tags = []
    self.capacities.each do |c|
      case
      when c.nb < 100
        tags << "< 100" unless tags.include?("< 100")
      when c.nb <= 400
        tags << "100-400" unless tags.include?("100-400")
      when c.nb <= 1200
        tags << "400-1200" unless tags.include?("400-1200")
      when c.nb > 1200
        tags << "> 1200" unless tags.include?("> 1200")
      end
    end
    tags
  end


  def season
    [start_season, end_season].map {|m| I18n.t("date.month_names")[m].titleize if m.present? }.compact.join(' - ')
  end

  def contract_list
    cl = []
    self.schedulings.each do |s|
      s.contract_list.each do |c|
        cl.push(c) unless cl.include?(c)
      end
    end
    cl
  end

  def style_list
    sl = []
    self.schedulings.each do |s|
      s.style_list.each do |style|
        sl.push(style) unless sl.include?(style)
      end
    end
    sl
  end
end
