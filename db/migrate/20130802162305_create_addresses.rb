class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :postal_code
      t.string :city
      t.string :state
      t.string :country
      t.string :kind
      t.references :contact_datum

      t.timestamps
    end
    add_index :addresses, :contact_datum_id
  end
end
