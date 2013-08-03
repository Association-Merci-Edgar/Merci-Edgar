class Person < ActiveRecord::Base
  belongs_to :account
  belongs_to :structure, :polymorphic => true
  has_one :contact_datum, :as => :contactable, :dependent => :destroy
  attr_accessible :first_name, :last_name, :contact_datum_attributes, :structure_id, :structure_type

  accepts_nested_attributes_for :contact_datum

  default_scope { where(:account_id => Account.current_id) }
end
