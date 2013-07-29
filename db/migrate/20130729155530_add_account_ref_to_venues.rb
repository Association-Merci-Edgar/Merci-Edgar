class AddAccountRefToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :account_id, :integer
    add_index :venues, :account_id
  end
end
