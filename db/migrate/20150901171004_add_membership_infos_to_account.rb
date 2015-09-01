class AddMembershipInfosToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :accounts, :string
    add_column :accounts, :last_subscription_at, :date
  end
end
