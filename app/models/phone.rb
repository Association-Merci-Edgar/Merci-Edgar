# == Schema Information
#
# Table name: phones
#
#  id               :integer          not null, primary key
#  number           :string(255)
#  kind             :string(255)
#  contact_datum_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Phone < ActiveRecord::Base
  belongs_to :contact
  attr_accessible :kind, :national_number, :country
  # validates :national_number, :phone => true, :allow_blank => true
  validate :check_number
  before_validation :internationalize_phone_number
  attr_accessor :country

  def country
    @country ||= "FR"
  end

  def internationalize_phone_number
    if Phony.plausible?(self.number)
      c = Country.new(country)
      self.number = Phony.normalize(self.number)
      self.number = "#{c.country_code}#{self.number}" unless self.number.starts_with?(c.country_code)
    end
  end

  def formatted_phone
    Phony.formatted(self.number,:format => :international) unless self.number.blank?
  end

  def national_number
    @national_number || Phony.formatted(self.number,:format => :national) unless self.number.blank?
  end

  def national_number=(n)
    @national_number = n
    self.number = @national_number
  end

  def check_number
    if !Phony.plausible?(number)
      errors.add(:national_number, "Wrong phone number")
    end
  end

end
