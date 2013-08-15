# == Schema Information
#
# Table name: contact_data
#
#  id               :integer          not null, primary key
#  contactable_id   :integer
#  contactable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ContactDatum < ActiveRecord::Base
  attr_accessible :emails_attributes, :phones_attributes, :addresses_attributes, :websites_attributes
  belongs_to :contactable, :polymorphic => true
  has_many :emails, :dependent => :destroy
  has_many :phones, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :websites, :dependent => :destroy

  accepts_nested_attributes_for :emails, :reject_if => proc { |attributes| attributes[:address].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :phones, :reject_if => proc { |attributes| attributes[:national_number].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :addresses, :reject_if => proc { |attributes| attributes[:street].blank? && attributes[:city].blank? && attributes[:postal_code].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :websites, :reject_if => :all_blank, :allow_destroy => true

  before_save :format_attributes
  def format_attributes
    country = self.addresses.first.country if self.addresses.any?
    self.phones.each do |phone|
      phone.internationalize_phone_number(country) if phone.present? && Phony.plausible?(phone.number)
    end
  end

  def reject_if_all_blank_except_country
    attributes[:street].blank? && attributes[:city].blank? && attributes[:postal_code].blank?
  end
end
