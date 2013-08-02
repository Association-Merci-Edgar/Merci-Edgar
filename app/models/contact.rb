class Contact < ActiveRecord::Base
  attr_accessible :city, :country, :email, :phone, :postal_code, :street, :state, :website
  belongs_to :contactable, :polymorphic => true

  before_validation :format_attributes

  validates :postal_code, :postal_code => { :country => :fr }, :if => "postal_code.present?"
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true, :message => "Not a valid email"
  validates :phone, :phone => true , :allow_blank => true
  validates_format_of :website, :allow_blank => true, :with => /(^((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  def format_attributes
    internationalize_phone_number if phone.present? && Phony.plausible?(phone) && country.present?
    add_url_protocol if website.present?
  end


  def internationalize_phone_number
    c = Country.new(country)
    if c
      self.phone = Phony.normalize(self.phone)
      self.phone = "#{c.country_code}#{phone}" unless self.phone.starts_with?(c.country_code)
    end
    self.phone = Phony.normalize(self.phone)
  end

  def add_url_protocol
    u = URI.parse(self.website)
    if (!u.scheme)
      self.website = 'http://' + self.website
    end
  end

  def formatted_phone
    Phony.formatted(self.phone,:format => :international)
  end
end
