class Address < ActiveRecord::Base
  belongs_to :contact_datum
  attr_accessible :city, :country, :kind, :postal_code, :state, :street
end
