class CreateContactData < ActiveRecord::Migration
  def change
    create_table :contact_data do |t|
      t.integer :contactable_id
      t.string :contactable_type
      t.timestamps
    end
    add_index :contact_data, :contactable_id
  end
end
