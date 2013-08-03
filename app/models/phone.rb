class Phone < ActiveRecord::Base
  belongs_to :contact_datum
  attr_accessible :kind, :number
  validates :number, :phone => true , :allow_blank => true

  before_validation :reset_kind, :if => "number.blank?"
  def reset_kind
    self.kind = ""
  end

  def internationalize_phone_number(country)
    if country
      c = Country.new(country)
      self.number = Phony.normalize(self.number)
      self.number = "#{c.country_code}#{self.number}" unless self.number.starts_with?(c.country_code)
    end
    self.number = Phony.normalize(self.number)
  end

  def formatted_phone
    Phony.formatted(self.number,:format => :international) unless self.number.blank?
  end

end
