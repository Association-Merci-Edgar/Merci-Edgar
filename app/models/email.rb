# == Schema Information
#
# Table name: emails
#
#  id               :integer          not null, primary key
#  address          :string(255)
#  kind             :string(255)
#  contact_datum_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Email < ActiveRecord::Base
  belongs_to :contact, touch:true
  attr_accessible :address, :kind
  validates_format_of :address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true, :message => "Not a valid email"

end
