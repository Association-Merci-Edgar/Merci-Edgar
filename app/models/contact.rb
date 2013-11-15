# == Schema Information
#
# Table name: contacts
#
#  id               :integer          not null, primary key
#  phone            :string(255)
#  email            :string(255)
#  website          :string(255)
#  street           :string(255)
#  postal_code      :string(255)
#  state            :string(255)
#  city             :string(255)
#  country          :string(255)
#  contactable_id   :integer
#  contactable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Contact < ActiveRecord::Base
  extend ContactsHelper
  default_scope { where(:account_id => Account.current_id) }

  attr_accessible :name, :emails_attributes, :phones_attributes, :addresses_attributes, :websites_attributes, :avatar, :style_tags, :network_tags, :custom_tags, :remark

  belongs_to :contactable, polymorphic: true

  has_many :emails, :dependent => :destroy
  has_many :phones, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :websites, :dependent => :destroy

  has_many :tasks, :as => :asset, dependent: :destroy

  has_many :reportings, :as => :asset, :order => 'created_at DESC', dependent: :destroy
  has_many :reports, through: :reportings, source: :report, source_type: :report

  has_many :favorite_contacts, dependent: :destroy


  accepts_nested_attributes_for :emails, :reject_if => proc { |attributes| attributes[:address].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :phones, :reject_if => proc { |attributes| attributes[:national_number].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :addresses, :reject_if => proc { |attributes| attributes[:street].blank? && attributes[:city].blank? && attributes[:postal_code].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :websites, :reject_if => :all_blank, :allow_destroy => true

  # mount_uploader :avatar, AvatarUploader

  before_save :titleize_name

  scope :searchy, lambda { |names|
    joins(:tags).where(tags: {name: names}).group('contacts.id').having(['COUNT(*) >= ?', names.length])
  }
  scope :tagged_by, lambda { |names|
    all(:conditions => {:tags => {:name => names}},
          :joins      => :taggings,
          :joins      => :tags,
          :group      => 'contacts.id',
          :having     => ['COUNT(*) >= ?', names.length]
        )
  }
  scope :tagged_with, lambda { |tag_type,tag_name| where('? = ?', tag_type, tag_name).order("contacts.name") }
  scope :by_style, lambda { |tag_name| where("style_tags LIKE ?", "%#{tag_name}%").order("contacts.name") }
  scope :by_network, lambda { |tag_name| where("network_tags LIKE ?", "%#{tag_name}%").order("contacts.name") }
  scope :by_custom, lambda { |tag_name| where("custom_tags LIKE ?", "%#{tag_name}%").order("contacts.name") }
  scope :with_name_like, lambda { |pattern| where('name LIKE ? OR first_name LIKE ?', "%#{pattern}%", "%#{pattern}%").order("contacts.name")}
  scope :with_first_name_and_last_name, lambda { |pattern,fn,ln| where('first_name LIKE ? AND name LIKE ? OR name LIKE ?', "%#{fn}%", "%#{ln}%","%#{pattern}%").order("contacts.name")}
  scope :with_reportings, joins: :reportings
  scope :by_department, lambda { |code_dept| joins(:addresses).where('addresses.postal_code LIKE ?', "#{code_dept}%").order("contacts.name")}

  scope :recently_created, order("created_at desc").limit(10)
  scope :recently_updated, order("updated_at desc").limit(10)

  AVAILABLE_STYLE_TAGS = ["Rock","Chanson","Electro","Jazz"]

  def titleize_name
    self.name = self.name.titleize if self.name
  end

  def phone_number
    @phone_number ||= phones.first.try(:formatted_phone)
  end

  def email_address
    @email_address ||= emails.first.try(:address)
  end

  def address
    @address ||= addresses.first
  end

  def postal_code
    @postal_code ||= address.try(:postal_code)
  end

  def city
    @city ||= address.try(:city)
  end

  def country
    @country ||= address.try(:country)
  end

  def website_url
    @website_url ||= websites.first.try(:url)
  end

  def contacted?
    self.reportings.any?
  end


  def reject_if_all_blank_except_country
    attributes[:street].blank? && attributes[:city].blank? && attributes[:postal_code].blank?
  end

  def self.with_tags(contacts, type, tags)
    Contact.tags_to_array(tags).each do |tag|
      contacts = contacts.send("by_#{type}", tag)
    end
    contacts
  end

  def self.advanced_search(params)
    if params[:capacity_range].present? || params[:capacity_lt].present? || params[:capacity_gt].present? || params[:venue_kind].present? || params[:contract_list]
      @contacts = Venue.order("contacts.name")
    else
      @contacts = Contact.order("contacts.name")
    end
    if params[:capacity_range].present?
      case
      when params[:capacity_range] =~ /< (\d+)/
        @contacts = @contacts.capacities_less_than($1) if $1.present?
      when params[:capacity_range] =~ /> (\d+)/
        @contacts = @contacts.capacities_more_than($1) if $1.present?
      when params[:capacity_range] =~ /(\d+)-(\d+)/
        @contacts = @contacts.capacities_between($1,$2) if $1.present? && $2.present?
      end
    end

    @contacts = @contacts.by_department(params[:dept]) if params[:dept].present?
    @contacts = with_tags(@contacts, "style", params[:style_list]) if params[:style_list]
    @contacts = with_tags(@contacts, "network", params[:network_list]) if params[:network_list]
    @contacts = with_tags(@contacts, "custom", params[:custom_list]) if params[:custom_list]
    @contacts = with_tags(@contacts, "contract", params[:contract_list]) if params[:contract_list]
    @contacts = @contacts.capacities_less_than(params[:capacity_lt]) if params[:capacity_lt].present?
    @contacts = @contacts.capacities_more_than(params[:capacity_gt]) if params[:capacity_gt].present?
    @contacts = @contacts.by_type(params[:venue_kind]) if params[:venue_kind].present?
    @contacts
  end

  def self.search(search)
    if search.present?
      a = search.split
      if a.size > 1
        Contact.with_first_name_and_last_name(search,a.shift,a.join(' '))
      else
        Contact.with_name_like(search)
      end
    else
      Contact.order(:name)
    end
  end

  def favorite?(user)
    @favorite ||= self.favorite_contacts.where(user_id: user.id).any?
  end

  def style_list
    self.style_tags.split(',') if self.style_tags.present?
  end

  def style_list=(styles)
    self.style_tags = styles.join(',') if styles.present?
  end


  def custom_list
    self.custom_tags.split(',') if self.custom_tags.present?
  end

  def custom_list=(customs)
    self.custom_tags = customs.join(',') if customs.present?
  end

  def network_list
    self.network_tags.split(',') if self.network_tags.present?
  end

  def network_list=(networks)
    self.network_tags = networks.join(',') if networks.present?
  end


end
