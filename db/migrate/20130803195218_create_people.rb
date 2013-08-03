class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.references :account
      t.integer :structure_id
      t.string :structure_type

      t.timestamps
    end
    add_index :people, :account_id
    add_index :people, :structure_id
  end
end
