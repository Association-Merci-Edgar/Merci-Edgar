# == Schema Information
#
# Table name: structures
#
#  id                :integer          not null, primary key
#  structurable_id   :integer
#  structurable_type :string(255)
#  avatar            :string(255)
#  account_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Structure < ActiveRecord::Base
  include Contacts::Xml
  default_scope { where(:account_id => Account.current_id) }

  attr_accessible :contact_attributes, :avatar, :remote_avatar_url, :kind

  has_one :contact, as: :contactable, dependent: :destroy
  accepts_nested_attributes_for :contact

  belongs_to :structurable, polymorphic: true

  has_many :relatives, dependent: :destroy

  has_many :people_structures
  has_many :people, through: :people_structures, uniq:true, dependent: :destroy

  delegate :name, :tasks, :reportings, :addresses, :remark, :emails, :phones, :websites, :city, :country,  :address, :phone_number, :website, :website_url, :network_list, :custom_list, :contacted?, :favorite?, to: :contact

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :contact

  def kind
    fm = self.fine_model
    if fm.present?
      fm.class.name.underscore
    end
  end

  def kind=(k)
    unless structurable.present?
      case k
      when "venue"
        v = Venue.new
        self.structurable = v
        v.structure = self

      when "festival"
        f = Festival.new
        self.structurable = f
        f.structure = self
      when "show_buyer"
        s = ShowBuyer.new
        self.structurable = s
        s.structure = self
      end
    end
  end

  def fine_model
    self.structurable.present? ? self.structurable.fine_model : self
  end

  def add_person(first_name,last_name,title)
    p = Person.find_or_initialize_by_first_name_and_name(first_name:first_name,name:last_name)
    ps = self.people_structures.build
    ps.person = p
    ps.title = title.titleize
    ps.save
  end

  def main_person(user)
    if self.people.any?
      self.relative(user).present? ? self.relative(user).person : self.people.first
    end
  end

  def set_main_person(user,person)
    rel = relative(user) || self.relatives.build(user: user)
    rel.person = person
    rel.save
  end


  def main_person?(user,person)
    person == self.main_person(user)
  end

  def relative(user)
    relative = self.relatives.where(user_id: user.id).first
  end

  def deep_xml(builder=nil)
    to_xml(
      :builder => builder, :skip_instruct => true, :skip_types => true,
      except: [:id, :created_at, :updated_at, :account_id, :avatar, :structurable_type, :structurable_id]
      ) do |xml|
      contact.deep_xml(xml)
      xml.people do
        people_structures.each do |ps|
          xml.person do
            xml.last_name ps.person.last_name
            xml.first_name ps.person.first_name
            xml.title ps.title
          end
        end
      end
      xml.base64_avatar do
        xml.filename self.avatar.file.filename
        xml.content self.base64_avatar
      end  unless self.avatar_url == self.avatar.default_url
    end
  end

  def self.from_merciedgar_hash(structure_attributes, imported_at, custom_tags)
    avatar_attributes = structure_attributes.delete("base64_avatar")

    contact_attributes = structure_attributes.delete("contact")

    people_attributes = structure_attributes.delete("people")

    structure = Structure.new(structure_attributes)

    people_array = people_attributes["person"]

    if people_array.is_a?(Array)
      people_array.each do |person_hash|
        person = Person.find_or_initialize_by_first_name_and_last_name(person_hash["first_name"],person_hash["last_name"])
        if person.new_record?
          person.build_contact.imported_at = imported_at
        else
          old_person = person
          duplicates = Contact.where("name = ? OR name LIKE ?",person.name,"#{person.name} #%")
          nb_duplicates = duplicates.size
          person = duplicates.where(imported_at: imported_at).first.try(:fine_model)
          unless person
            first_name = "#{person_hash["first_name"]} ##{nb_duplicates + 1}"

            person = Person.new(last_name:person_hash["last_name"], first_name: first_name)
            person.build_contact.imported_at = imported_at
            person.contact.duplicate = old_person.contact
            person.contact.add_custom_tags(custom_tags)
          end
        end
        ps = structure.people_structures.build
        ps.person = person
        ps.title = person_hash["title"]
      end
    else
      if people_array.is_a?(Hash)
        person_hash = people_array
        person = Person.find_or_initialize_by_first_name_and_last_name(person_hash["first_name"],person_hash["last_name"])
        if person.new_record?
          person.build_contact.imported_at = imported_at
        else
          old_person = person
          duplicates = Contact.where("name = ? OR name LIKE ?",person.name,"#{person.name} #%")
          nb_duplicates = duplicates.size
          person = duplicates.where(imported_at: imported_at).first.try(:fine_model)
          unless person
            first_name = "#{person_hash["first_name"]} ##{nb_duplicates + 1}"

            person = Person.new(last_name:person_hash["last_name"], first_name: first_name)
            person.build_contact.imported_at = imported_at
            person.contact.duplicate = old_person.contact
            person.contact.add_custom_tags(custom_tags)
          end
        end
        ps = structure.people_structures.build
        ps.person = person
        ps.title = person_hash["title"]
      end
    end

    contact = Contact.new_from_merciedgar_hash(contact_attributes, imported_at, custom_tags)
    structure.contact = contact
    structure.upload_base64_avatar(avatar_attributes)
    structure
  end

  def self.from_csv(row)
    structure = Structure.new
    people = {}
    row.keys.each do |key|
      elements = key.to_s.split('_')
      attribute = elements.shift
      title = elements.map(&:capitalize).join(' ')
      if title.present? && Contact::VALID_CSV_KEYS.include?(attribute)
        people[title] ||= {}
        people[title][attribute.to_sym] = row[key.to_sym]
      end
    end

    people.each do |title, person_hash|
      person_name = person_hash[:nom]
      if person_name && person_name.strip.length > 1 && title != "programmateur"
        ps = structure.people_structures.build
        ps.title = title
        person_hash[:imported_at] = row[:imported_at]
        person_hash[:first_name_last_name_order] = row[:first_name_last_name_order]
        ps.person = Person.from_csv(person_hash)
        underscore_title = title.split.map(&:downcase).join('_')
        person_hash_keys_in_row = person_hash.keys.map{ |key| [key.to_s,underscore_title].join('_').to_sym }
        row.delete_if{|key| person_hash_keys_in_row.include?(key)}
      end
    end

    structure.save
    structure.contact, invalid_keys = Contact.from_csv(row, true)
    [structure, invalid_keys]
  end

  def self.csv_header
    ['Nom', 'Emails', 'Téls', 'Adresses', 'Sites web', 'Réseaux', 'Tag Perso', 'Commentaires', 'Personnes'].to_csv
  end

  def self.export(account)
    structures = Structure.where(account_id: account.id)
    return nil if structures.empty?

    f = File.new("structures-#{account.domain}.csv", "w")
    File.open(f, 'w') do |file|
      file.puts csv_header
      structures.each do |s|
        file.puts s.to_csv
      end
    end
    f
  end

  def to_csv
    [self.to_s, ExportTools.build_list(self.emails), ExportTools.build_list(self.phones), ExportTools.build_list(self.addresses), ExportTools.build_list(self.websites), self.network_list, self.custom_list, self.remark, ExportTools.build_list(self.people)
    ].to_csv
  end

  def to_s
    if self.structurable_type
      type = I18n.t(self.structurable_type.to_s.underscore, scope: 'activerecord.models')
    else
      type = I18n.t('generic_structure')
    end
    "#{self.name} [#{type.capitalize}]"
  end
end
