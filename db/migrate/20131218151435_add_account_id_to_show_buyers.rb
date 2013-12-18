class AddAccountIdToShowBuyers < ActiveRecord::Migration
  def change
    add_column :show_buyers, :account_id, :integer
    add_index :show_buyers, :account_id
  end
end
