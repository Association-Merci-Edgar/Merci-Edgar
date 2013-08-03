class ContactDatum < ActiveRecord::Base
  attr_accessible :emails_attributes, :phones_attributes, :addresses_attributes, :websites_attributes
  belongs_to :contactable, :polymorphic => true
  has_many :emails
  has_many :phones
  has_many :addresses
  has_many :websites

  accepts_nested_attributes_for :emails, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :phones, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :addresses, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :websites, :reject_if => :all_blank, :allow_destroy => true

  before_validation :format_attributes
  def format_attributes
    country = self.addresses.first.country if self.addresses.any?
    self.phones.each do |phone|
      phone.internationalize_phone_number(country) if phone.present? && Phony.plausible?(phone.number)
    end
  end

end
