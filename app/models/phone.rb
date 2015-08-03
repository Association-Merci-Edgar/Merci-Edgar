# == Schema Information
#
# Table name: phones
#
#  id         :integer          not null, primary key
#  number     :string(255)
#  kind       :string(255)
#  contact_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Phone < ActiveRecord::Base
  belongs_to :contact, touch:true
  attr_accessible :kind, :national_number, :number, :country, :specific_kind, :classic_kind
  # validates :national_number, :phone => true, :allow_blank => true
  validate :check_number
  before_validation :set_kind
  before_validation :set_number
  
  attr_accessor :country
  VENUE_KIND = [:reception, :scheduling, :administrative, :ticket, :technical, :fax, :other]
  PERSON_KIND = [:work, :mobile, :perso, :fax, :other]
  PHONE_KIND = [:reception, :scheduling, :administrative, :ticket, :technical, :fax, :work, :mobile, :perso]

  def specific_kind
    self.kind unless kind_list.include?(self.kind.try(:to_sym))
  end

  def specific_kind=(special)
    @specific_kind = special if special.present?
  end

  def kind_list
    PHONE_KIND
  end

  def classic_kind
    case
    when self.kind.blank?
      kind_list[0]
    when kind_list.include?(self.kind.to_sym)
      self.kind
    else
      :other
    end
  end

  def classic_kind=(classic)
    self.kind = classic unless classic == "other"
  end

  def country
    @country ||= "FR"
  end

  def self.internat(phone_number,country)
    unless phone_number.starts_with?('+')
      c = Country.new(country)
      phone_number = "#{c.country_code}#{phone_number}" unless phone_number.starts_with?(c.country_code)
    end
    Phony.normalize(phone_number) if Phony.plausible?(phone_number)
  end

  def set_kind
    self.kind = @specific_kind if @specific_kind.present?
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

  def set_number
    if @national_number
      international = Phone.internat(@national_number,country)
      self.number = international if international
    end
  end

  def check_number
    if !Phony.plausible?(self.number)
      errors.add(:national_number, "Wrong phone number")
    end
  end

end
