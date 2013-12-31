# == Schema Information
#
# Table name: festivals
#
#  id           :integer          not null, primary key
#  nb_edition   :integer
#  last_year    :integer
#  artists_kind :string(255)
#  avatar       :string(255)
#  account_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Festival < ActiveRecord::Base
  include Contacts::Xml
  default_scope { where(:account_id => Account.current_id) }

  attr_accessible :artists_kind, :last_year, :nb_edition, :structure_attributes, :schedulings_attributes, :network_tags, :avatar, :remote_avatar_url

  has_one :structure, as: :structurable, dependent: :destroy
  accepts_nested_attributes_for :structure

  has_many :schedulings, as: :show_host, dependent: :destroy, autosave: true, order: "id ASC"
  has_many :show_buyers, through: :schedulings, uniq: true
  accepts_nested_attributes_for :schedulings, :reject_if => :all_blank, :allow_destroy => true


  delegate :name, :people, :tasks, :reportings, :remark, :addresses, :emails, :phones, :websites, :city, :address, :network_list, :custom_list, :contacted?, :favorite?, :main_person, to: :structure
  # validate :venue_must_have_at_least_one_address
#  validate :venue_name_must_be_unique_by_city, :on => :create
  # validates_presence_of :addresses


  before_save :set_contact_criteria 
  
  mount_uploader :avatar, AvatarUploader

  scope :by_contract, lambda { |tag_name| joins(:schedulings).where("schedulings.contract_tags LIKE ?", "%#{tag_name}%") }
  scope :by_style, lambda { |tag_name| joins(:schedulings).where("schedulings.style_tags LIKE ?", "%#{tag_name}%") }

  def fine_model
    self
  end

  def set_contact_criteria
    self.build_structure unless structure.present?
    self.structure.build_contact unless structure.contact.present?
    contact = structure.contact
    
    c_style_list = self.style_list
    contact.style_tags = c_style_list.join(',') if c_style_list.present?
    
    c_contract_list = self.contract_list
    contact.contract_tags = c_contract_list.join(',') if c_contract_list.present?
        
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
      end if s.style_list.present?
    end
    sl
  end

  def self.from_xml(xml)
    attributes = Hash.from_xml(xml)
    festival_attributes = attributes["festival"]
    name = festival_attributes.delete("name")
    
    duplicate = Contact.find_by_name(name)
    if duplicate
      nb_duplicates = Contact.where("name LIKE ?","#{name} #%").size
      name = "#{name} ##{nb_duplicates + 1}"
    end


    structure_attributes = festival_attributes.delete("structure")
    contact_attributes = structure_attributes.delete("contact")
    f = Festival.new(festival_attributes)
    f.structure = Structure.new(structure_attributes)

    contact = Contact.new_from_mml_hash(contact_attributes)
    contact.name = name
    contact.duplicate = duplicate
    f.structure.contact = contact
    
    f    
  end
  
  def self.from_merciedgar_hash(festival_attributes, imported_at)
    structure_attributes = festival_attributes.delete("structure")
    structure = Structure.from_merciedgar_hash(structure_attributes, imported_at)

    festival = Festival.new(festival_attributes)
    festival.structure = structure
    
    festival
    
  end
  

end
