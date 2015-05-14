class ContactsImport < ActiveRecord::Base

  belongs_to :account
  belongs_to :user
  validates_presence_of :account
  validates_presence_of :user
  validate :import_cannot_be_launched_if_import_already_running

  attr_accessible :contacts_file, :contacts_file_cache, :contacts_kind, :first_name_last_name_order, :test_mode, :user_id

  attr_accessor :contacts_file_cache

  mount_uploader :contacts_file, ContactsImportUploader

  def import_cannot_be_launched_if_import_already_running
    if account && account.importing_now?
      errors.add(:base, :import_cannot_be_launched_if_import_already_running)
    end
  end

  def filename
    contacts_file.file.filename
  end

  def self.get_payload(imported_at)
    imported_contacts = Contact.where(imported_at: imported_at)
    nb_duplicates = imported_contacts.where("duplicate_id IS NOT NULL").count
    nb_imported_contacts = imported_contacts.count
    [nb_imported_contacts, nb_duplicates]
  end

end
