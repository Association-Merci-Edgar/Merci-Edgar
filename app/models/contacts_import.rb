class ContactsImport 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  
  attr_accessor :contact_file, :custom_tags, :contact_kind, :first_name_last_name_order, :test_mode
  validates_presence_of :contact_file
  validates :contact_kind, inclusion: { in: %w(venue festival show_buyer structure person) }
  
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end

  def options
    { custom_tags: custom_tags, contact_kind: contact_kind, first_name_last_name_order: first_name_last_name_order, test_mode: test_mode }
  end
  
  def filename
    contact_file.try(:original_filename)
  end
end