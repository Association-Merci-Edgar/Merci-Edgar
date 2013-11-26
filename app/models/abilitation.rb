class Abilitation < ActiveRecord::Base
  attr_accessible :account_id, :kind, :user_id
  belongs_to :user
  belongs_to :account
end
