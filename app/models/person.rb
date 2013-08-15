# == Schema Information
#
# Table name: people
#
#  id             :integer          not null, primary key
#  first_name     :string(255)
#  last_name      :string(255)
#  account_id     :integer
#  structure_id   :integer
#  structure_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Person < ActiveRecord::Base
  belongs_to :account
  belongs_to :structure, :polymorphic => true
  has_one :contact_datum, :as => :contactable, :dependent => :destroy
  attr_accessible :first_name, :last_name, :contact_datum_attributes, :structure_id, :structure_type

  accepts_nested_attributes_for :contact_datum

  default_scope { where(:account_id => Account.current_id) }
end
