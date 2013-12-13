# == Schema Information
#
# Table name: contacts
#
#  id               :integer          not null, primary key
#  contactable_id   :integer
#  contactable_type :string(255)
#  name             :string(255)
#  network_tags     :string(255)
#  custom_tags      :string(255)
#  remark           :text
#  account_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Contact < ActiveRecord::Base
  extend ContactsHelper
  default_scope { where(:account_id => Account.current_id) }

  attr_accessible :name, :emails_attributes, :phones_attributes, :addresses_attributes, :websites_attributes, :style_tags, :network_tags, :custom_tags, :remark

  belongs_to :contactable, polymorphic: true
  
  validates_uniqueness_of :name, scope: :account_id

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

  before_validation :titleize_name
  after_save  :update_networks
  after_save  :update_customs

  delegate :fine_model, to: :contactable
    
  def avatar  
    self.fine_model.avatar
  end
  
  def avatar_url(version)
    self.fine_model.avatar_url(version)
  end

  scope :by_network, lambda { |tag_name| where("network_tags LIKE ?", "%#{tag_name}%").order("contacts.name") }
  scope :by_custom, lambda { |tag_name| where("custom_tags LIKE ?", "%#{tag_name}%").order("contacts.name") }
  scope :by_style, lambda { |tag_name| where("style_tags LIKE ?", "%#{tag_name}%").order("contacts.name") }
  scope :by_contract, lambda { |tag_name| where("contract_tags LIKE ?", "%#{tag_name}%").order("contacts.name") }
  scope :by_capacity, lambda { |tag_name| where("capacity_tags LIKE ?", "%#{tag_name}%").order("contacts.name") }
  
  scope :with_name_like, lambda { |pattern| where('name LIKE ? OR first_name LIKE ?', "%#{pattern}%", "%#{pattern}%").order("contacts.name")}
  scope :with_first_name_and_last_name, lambda { |pattern,fn,ln| where('first_name LIKE ? AND name LIKE ? OR name LIKE ?', "%#{fn}%", "%#{ln}%","%#{pattern}%").order("contacts.name")}
  scope :with_reportings, joins: :reportings
  scope :by_department, lambda { |code_dept| joins(:addresses).where('addresses.postal_code LIKE ?', "#{code_dept}%").order("contacts.name")}

  scope :recently_created, order("created_at desc").limit(10)
  scope :recently_updated, order("updated_at desc").limit(10)

  AVAILABLE_STYLE_TAGS = ["Rock","Chanson","Electro","Jazz"]
  
  
  def titleize_name
    if self.name
      # titleize with hyphen
      self.name = name.split.map{|w| w.split('-').map(&:capitalize).join('-')}.join(' ')
      
      # capitalize after l' or d'
      r = /[lLdD]'(\w*)/
      self.name = self.name.gsub(r) {|m| m.gsub($1, $1.capitalize) }      
    end
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

  def self.by_type(type)
    case type
    when "venues"
      contact_ids = Venue.joins(:structure => :contact).order("contacts.name").collect {|v| v.structure.contact.id }
    when "festivals"
      contact_ids = Festival.joins(:structure => :contact).order("contacts.name").collect {|f| f.structure.contact.id }
    when "show_buyers"
      contact_ids = ShowBuyer.joins(:structure => :contact).order("contacts.name").collect {|s| s.structure.contact.id }
    when "structures"
      contact_ids = Structure.joins(:contact).order("contacts.name").collect {|s| s.contact.id }
    when "people"
      contact_ids = Contact.where(contactable_type: "Person").pluck(:id)
    else
      raise "Invalid Parameter"
    end
    
    Contact.where(id: contact_ids)

  end

  def self.advanced_search(params)
    if params[:category].present?
      @contacts = Contact.by_type(params[:category])
    else
      @contacts = Contact.order(:name)
    end
=begin    
    if params[:capacity_range].present? || params[:capacity_lt].present? || params[:capacity_gt].present? || params[:venue_kind].present?
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
=end

    @contacts = tagged_with(@contacts, params[:style_list], "style_tags") if params[:style_list].present?
    @contacts = tagged_with(@contacts, params[:network_list], "network_tags") if params[:network_list].present?
    @contacts = tagged_with(@contacts, params[:custom_list], "custom_tags") if params[:custom_list].present?
    @contacts = tagged_with(@contacts, params[:contract_list], "contract_tags") if params[:contract_list].present?
    @contacts = in_string_list(@contacts,params[:venue_kind], :venue_kind) if params[:venue_kind].present?
    @contacts = tagged_with(@contacts, params[:capacity_range], "capacity_tags") if params[:capacity_range].present?
    # @contacts = @contacts.by_department(params[:dept]) if params[:dept].present?
    
    # @contacts = @contacts.capacities_less_than(params[:capacity_lt]) if params[:capacity_lt].present?
    # @contacts = @contacts.capacities_more_than(params[:capacity_gt]) if params[:capacity_gt].present?
    # @contacts = @contacts.by_type(params[:venue_kind]) if params[:venue_kind].present?
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

  def to_s
    name
  end
  
  # private
  def self.tagged_with(contacts, param_list, field)
    if contacts && param_list.present? && field.present? 
      query = []
      query_params = []
      param_array = param_list.split(',').map(&:strip)
      param_array.length.times { query.push("#{field} LIKE ?") }
      param_array.each { |s| query_params.push("%#{s}%") }
      contacts.where(query.join(" OR "), *query_params)    
    end
  end
  
  def self.in_string_list(contacts, param_list, field)
    if contacts && param_list.present? && field.present? 
      hash_query = {}
      hash_query[field] = param_list.split(',').map(&:strip)
      contacts.where(hash_query)
    end
  end
=begin  
  @contacts = @contacts.by_style(params[:style_list]) if params[:style_list].present?
  @contacts = @contacts.by_network(params[:network_list]) if params[:network_list].present?
  @contacts = @contacts.by_custom(params[:custom_list]) if params[:custom_list].present?
  @contacts = @contacts.by_contract(params[:contract_list]) if params[:contract_list].present?
  @contacts = @contacts.by_capacity(params[:capacity_list]) if params[:contract_list].present?
=end

  def style_list
    self.style_tags.split(',') if self.style_tags
  end
  
  def contract_list
    self.contract_tags.split(',') if self.contract_tags
  end
  
  def network_list
    self.network_tags.split(',') if self.network_tags
  end

  def custom_list
    self.custom_tags.split(',') if self.custom_tags
  end
  
  def capacity_list
    self.capacity_tags.split(',') if self.capacity_tags
  end

  def update_networks
    Network.add_networks(network_list) if network_tags.present? && network_tags_changed?
  end
  
  def update_customs
    Custom.add_customs(custom_list) if custom_tags.present? && custom_tags_changed?
  end
    
end
