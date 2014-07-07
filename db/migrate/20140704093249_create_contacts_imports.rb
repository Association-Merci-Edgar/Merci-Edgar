class CreateContactsImports < ActiveRecord::Migration
  def change
    create_table :contacts_imports do |t|
      t.string :contacts_file
      t.string :contacts_kind, default: "venue"
      t.string :first_name_last_name_order, default: "last_name"
      t.boolean :test_mode
      t.integer :account_id
      t.integer :user_id

      t.timestamps
    end
    add_index :contacts_imports, :account_id
    add_index :contacts_imports, :user_id
  end
end
