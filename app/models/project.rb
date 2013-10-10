class Project < ActiveRecord::Base
  attr_accessible :description, :name
  default_scope { where(:account_id => Account.current_id) }
end
