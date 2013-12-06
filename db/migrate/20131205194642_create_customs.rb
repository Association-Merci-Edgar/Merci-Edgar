class CreateCustoms < ActiveRecord::Migration
  def change
    create_table :customs do |t|
      t.string  :custom
      t.integer :account_id

      t.timestamps
    end
    add_index :customs, :account_id
  end
end
