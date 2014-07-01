class ContactsImport 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  
  attr_accessor :contact_file, :contact_kind, :first_name_last_name_order, :test_mode, :account_id, :user_id, :imported_at
  # validates_presence_of :contact_file
  validates :contact_kind, inclusion: { in: %w(venue festival show_buyer structure person) }
  validates :filename, :contact_kind, :first_name_last_name_order, presence: true
  validate :import_cannot_be_launched_if_import_already_running
  
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    @account_id = Account.current_id
    @first_name_last_name_order ||= :last_name
    @contact_kind ||= :venue
  end
  
  def init
    self.first_name_last_name_order = :last_name
    self.contact_kind = :venue
  end
  
  def persisted?
    false
  end

  def import_cannot_be_launched_if_import_already_running
    account = Account.find(@account_id)
    if account.importing_now?
      errors.add(:base, :import_cannot_be_launched_if_import_already_running)
    end
  end
  
  def filename
    @filename ||= contact_file.try(:original_filename)
  end
  
  def filename=(new_filename)
    new_filename = nil unless new_filename.present?
    @filename = new_filename
  end
  
  def to_json
    { 
      test_mode: test_mode, contact_kind: contact_kind, first_name_last_name_order: first_name_last_name_order, 
      filename: filename, imported_at: imported_at, account_id: account_id, user_id: user_id 
    }
  end
  
  def self.get_payload(imported_at)
    imported_contacts = Contact.where(imported_at: imported_at)
    nb_duplicates = imported_contacts.where("duplicate_id IS NOT NULL").count
    nb_imported_contacts = imported_contacts.count
    [nb_imported_contacts, nb_duplicates]
  end
  
end