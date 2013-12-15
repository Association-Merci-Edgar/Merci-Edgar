class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string  :network
      t.integer :account_id

      t.timestamps
    end
    add_index :networks, :account_id
  end
end
