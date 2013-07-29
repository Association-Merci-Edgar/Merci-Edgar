class Venue < ActiveRecord::Base
  attr_accessible :name
  default_scope { where(:account_id => Account.current_id) }
end
