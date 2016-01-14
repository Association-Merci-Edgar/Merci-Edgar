class Person < ActiveRecord::Base
  default_scope { where(:account_id => Account.current_id) }
  attr_accessible :first_name, :last_name, :people_structures_attributes, :contact_attributes, :avatar, :remote_avatar_url
  has_one :contact, as: :contactable, dependent: :destroy
  has_many :structures, through: :people_structures, uniq:true
  has_many :people_structures, dependent: :destroy
  has_many :relatives, dependent: :destroy
  has_many :schedulings, foreign_key: "scheduler_id"

  validates_presence_of :first_name
  validates_presence_of :last_name

  accepts_nested_attributes_for :people_structures, :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :contact, :reject_if => :all_blank, allow_destroy: true

  delegate :imported_at, :tasks, :reportings, :network_list, :custom_list, :favorite?, :contacted?, :phone_number, :email_address, :addresses, :emails, :phones, :websites, :remark, to: :contact

  mount_uploader :avatar, AvatarUploader

  def fine_model
    self
  end

  def name
    [self.last_name, self.first_name].compact.join(' ')
  end

  def first_name=(fname)
    if fname.present?
      new_first_name = fname.split.map{|w| w.split('-').map(&:capitalize).join('-')}.join(' ')
      write_attribute(:first_name, new_first_name)
    else
      write_attribute(:first_name, fname)
    end
    set_contact_name
  end

  def last_name=(lname)
    if lname.present?
      new_last_name = lname.split.map{|w| w.split('-').map(&:capitalize).join('-')}.join(' ')
      write_attribute(:last_name, new_last_name)
    else
      write_attribute(:last_name, lname)
    end
    set_contact_name
  end

  def name=(name)
    words = name.split(' ')
    self.last_name = words.shift
    self.first_name = words.join(' ') if words.present?
  end

  def set_contact_name
    self.build_contact unless contact.present?
    contact.name = Contact.format_name("#{last_name} #{first_name}")
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

  def self.from_csv(row)
    if row[:first_name_last_name_order] == "first_name"
      old_name = row[:nom]
      words = old_name.split(' ')
      first_name = words.shift
      last_name = words.join(' ') if words.present?
      row[:nom] = [last_name, first_name].join(' ')
    end
    contact, invalid_keys = Contact.from_csv(row) #TODO
    person = nil
    if contact.new_record?
      person = Person.new
      person.name = contact.name
      person.contact = contact
    else
      if contact.contactable.kind_of?(Person)
        person = contact.contactable
      end
    end
    person
  end

  def self.csv_header
    "Nom, Emails, Téls, Adresses, Sites web, Réseaux, Tags Perso, Commentaires, Structures".split(',').to_csv
  end

  def self.export(account)
    people = Person.where(account_id: account.id)
    return nil if people.empty?

    f = File.new(export_filename(account), "w")
    File.open(f, 'w') do |file|
      file.puts csv_header
      people.each do |p|
        file.puts p.to_csv
      end
    end
    f
  end

  def self.export_filename(account)
    "personnes-#{account.domain}.csv"
  end

  def to_csv
    [self.name, ExportTools.build_list(self.emails), ExportTools.build_list(self.phones),
     ExportTools.build_list(self.addresses), ExportTools.build_list(self.websites), self.network_list,
     self.custom_list, self.remark, ExportTools.build_list(self.structures)
    ].to_csv
  end

  def to_s
    "#{self.first_name} #{self.last_name}"
  end
end
