class ShowBuyer < ActiveRecord::Base
  default_scope { where(:account_id => Account.current_id) }

  attr_accessible :licence
  has_one :structure, :as :structurable
  has_many :schedulings
  has_many :show_hosts, through: :schedulings, uniq: true
end
