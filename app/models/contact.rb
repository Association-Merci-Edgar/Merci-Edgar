class Contact < ActiveRecord::Base
  attr_accessible :city, :country, :email, :phone, :postal_code, :street, :state, :website
  belongs_to :contactable, :polymorphic => true

  before_validation :format_attributes

  validates :postal_code, :postal_code => { :country => :fr }, :if => "postal_code.present?"
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :if => "email.present?"
  validates :phone, :phone => true , :if => "phone.present?"
  validates_format_of :website, :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  def format_attributes
    internationalize_phone_number if phone.present? && Phony.plausible?(phone) && country.present?
  end


  def internationalize_phone_number
    c = Country.new(country)
    if c
      self.phone = Phony.normalize(self.phone)
      self.phone = "#{c.country_code}#{phone}" unless self.phone.starts_with?(c.country_code)
    end
    self.phone = Phony.normalize(self.phone)
  end
  
  def formatted_phone
    Phony.formatted(self.phone,:format => :international)
  end
end
