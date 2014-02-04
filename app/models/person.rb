# encoding: utf-8
# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  avatar     :string(255)
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Person < ActiveRecord::Base
  include Contacts::Xml
  default_scope { where(:account_id => Account.current_id) }
  attr_accessible :first_name, :last_name, :people_structures_attributes, :contact_attributes, :avatar, :remote_avatar_url
  has_one :contact, as: :contactable, dependent: :destroy
  has_many :structures, through: :people_structures, uniq:true
  has_many :people_structures, dependent: :destroy
  has_many :relatives, dependent: :destroy
  validates_presence_of :first_name
  validates_presence_of :last_name
  # validates_associated :contact

  accepts_nested_attributes_for :people_structures, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :contact, :reject_if => :all_blank, allow_destroy: true

  delegate :imported_at, :tasks, :reportings, :network_list, :custom_list, :favorite?, :contacted?, :phone_number, :email_address, :addresses, :emails, :phones, :websites, to: :contact

  before_validation :set_contact_name
  
  mount_uploader :avatar, AvatarUploader
  
  def fine_model
    self
  end

  def name
    [self.last_name, self.first_name].compact.join(' ')
  end
  
  # name : last_name first_name
  def name=(name)
    words = name.split(' ')
    self.last_name = words.shift
    self.first_name = words.join(' ') if words.present?
  end

  def set_contact_name
    self.build_contact unless contact.present?
    contact.name = "#{last_name} #{first_name}" if self.changed.include?("first_name") || self.changed.include?("last_name")
  end


  def other_people_structures(user)
    self.people_structures.where("structure_id != ?", self.main_structure(user).id)
  end

  def main_people_structure(user)
    self.people_structures.where(structure_id: self.main_structure(user).id).first if self.people_structures.present?
  end

  def to_s
    [self.first_name, self.last_name].compact.join(' ')
  end

  def to_param
    [id, to_s.try(:parameterize)].compact.join('-')
  end

  def title(structure)
    structure.people_structures.where(person_id:self.id).first.title if structure.present?
  end

  def info_contact(structure)
    [self.title(structure), self.phone_number, self.email_address].compact.join(' — ')
  end

  def main_structure(user)
    if self.structures.any?
      self.relative(user).present? ? self.relative(user).structure : self.structures.first
    end
  end

  def set_main_structure(user,structure)
    rel = self.relatives.build(user: user) unless relative(user).present?
    rel.structure = structure
  end


  def main_structure?(user,structure)
    structure == self.main_structure(user)
  end

  def relative(user)
    relative = self.relatives.where(user_id: user.id).first
  end
  
  def deep_xml(builder=nil)
    to_xml(
      :builder => builder, :skip_instruct => true, :skip_types => true, 
      except: [:id, :created_at, :updated_at, :account_id, :avatar]
      ) do |xml|
      # contact.deep_xml(xml)
      xml.base64_avatar do
        xml.filename self.avatar.file.filename 
        xml.content self.base64_avatar
      end  unless self.avatar_url == self.avatar.default_url      
    end    
  end
  
  def self.from_merciedgar_hash(person_attributes, imported_at, custom_tags)  
    avatar_attributes = person_attributes.delete("base64_avatar")
    contact_attributes = person_attributes.delete("contact") || {}
    first_name = person_attributes.delete("first_name")
    last_name = person_attributes.delete("last_name")
    person = Person.find_or_initialize_by_first_name_and_last_name(first_name,last_name)
    unless person.new_record?
      old_person = person
      duplicates = Contact.where("name LIKE ?", "#{person.name} #%")
      nb_duplicates = duplicates.size
      person = duplicates.where(imported_at: imported_at).first.try(:fine_model)
      unless person
        fname = "#{first_name} ##{nb_duplicates + 1}"
        
        person = Person.new(last_name:last_name, first_name:fname)
        logger.info {"CONTACT ATTRIBUTES --------- #{contact_attributes}"}

      end
      
    end
    person.assign_attributes(person_attributes)
    person.upload_base64_avatar(avatar_attributes) if avatar_attributes.present?

    person.contact = Contact.new_from_merciedgar_hash(contact_attributes, imported_at, custom_tags)
    person.contact.duplicate = old_person.contact if old_person
    person.contact.add_custom_tags(custom_tags)

    person
  end

end
