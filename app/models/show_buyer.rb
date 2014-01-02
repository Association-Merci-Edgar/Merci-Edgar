# == Schema Information
#
# Table name: show_buyers
#
#  id         :integer          not null, primary key
#  licence    :string(255)
#  avatar     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShowBuyer < ActiveRecord::Base
  include Contacts::Xml
  
  default_scope { where(:account_id => Account.current_id) }

  attr_accessible :licence, :structure_attributes, :schedulings_attributes, :avatar, :remote_avatar_url
  has_one :structure, as: :structurable, dependent: :destroy
  accepts_nested_attributes_for :structure

  has_many :schedulings, autosave: true, order: "id ASC"
  accepts_nested_attributes_for :schedulings, :reject_if => :all_blank, :allow_destroy => true

  has_many :show_hosts, through: :schedulings, uniq: true

  delegate :name, to: :structure

  mount_uploader :avatar, AvatarUploader

  delegate :name, :people, :tasks, :reportings, :remark, :addresses, :emails, :phones, :websites, :city, :address, :network_list, :custom_list, :contacted?, :favorite?, :main_person, to: :structure  

  before_update :set_contact_criteria 
  
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
    show_buyer_attributes = attributes["show_buyer"]
    name = show_buyer_attributes.delete("name")
    
    duplicate = Contact.find_by_name(name)
    if duplicate
      nb_duplicates = Contact.where("name LIKE ?","#{name} #%").size
      name = "#{name} ##{nb_duplicates + 1}"
    end


    structure_attributes = show_buyer_attributes.delete("structure")
    contact_attributes = structure_attributes.delete("contact")
    s = ShowBuyer.new(show_buyer_attributes)
    s.structure = Structure.new(structure_attributes)

    contact = Contact.new_from_mml_hash(contact_attributes)
    contact.name = name
    contact.duplicate = duplicate
    s.structure.contact = contact
    
    s    
  end

  def self.from_merciedgar_hash(show_buyer_attributes, imported_at)
    avatar_attributes = show_buyer_attributes.delete("base64_avatar")
    structure_attributes = show_buyer_attributes.delete("structure")
    structure = Structure.from_merciedgar_hash(structure_attributes, imported_at)

    show_buyer = ShowBuyer.new(show_buyer_attributes)
    show_buyer.structure = structure
    show_buyer.upload_base64_avatar(avatar_attributes)
    
    show_buyer
    
  end

end
