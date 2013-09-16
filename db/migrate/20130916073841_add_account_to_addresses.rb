class AddAccountToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :account_id, :integer
    add_index :addresses, :account_id
  end
end
