class Email < ActiveRecord::Base
  belongs_to :contact_datum
  attr_accessible :address, :kind
  validates_format_of :address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true, :message => "Not a valid email"

end
